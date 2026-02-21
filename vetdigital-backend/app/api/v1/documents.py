"""
Documents API — EDS signing initiation, signature management, PDF download.
"""
from typing import Optional
from uuid import UUID
from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from pydantic import BaseModel

from app.database import get_db
from app.dependencies import CurrentUser, require_permission
from app.models.document import DigitalSignature
from app.models.veterinary import ProcedureAct
from app.core.permissions import Permission
from app.integrations.ncalayer.client import egov_mobile_client
from app.services.veterinary_service import veterinary_service

router = APIRouter()


# ─── Schemas ──────────────────────────────────────────────────────────────────

class CompleteSignRequest(BaseModel):
    challenge_token: str
    signature_data: str


class SignatureOut(BaseModel):
    id: str
    signer_name: str
    signer_iin: str
    signed_at: Optional[str]
    is_valid: bool


# ─── Endpoints ────────────────────────────────────────────────────────────────

@router.get("", summary="List documents for current user")
async def list_documents(
    current_user: CurrentUser,
    doc_type: Optional[str] = Query(None, description="Filter by type: procedure_act, etc."),
    status: Optional[str] = Query(None),
    page: int = Query(1, ge=1),
    page_size: int = Query(20, ge=1, le=100),
    db: AsyncSession = Depends(get_db),
):
    """List signed and unsigned documents accessible to the current user."""
    if doc_type == "procedure_act" or not doc_type:
        from app.services.veterinary_service import veterinary_service
        from app.models.user import User
        acts, total = await veterinary_service.get_procedure_acts(
            db,
            page=page,
            page_size=page_size,
            status=status,
            specialist_id=current_user.id,
        )
        return {
            "items": [
                {
                    "id": str(a.id),
                    "type": "procedure_act",
                    "title": a.act_number,
                    "status": a.status,
                    "created_at": a.created_at.isoformat() if a.created_at else None,
                    "signed_at": a.signed_at.isoformat() if a.signed_at else None,
                    "pdf_url": a.pdf_url,
                }
                for a in acts
            ],
            "total": total,
            "page": page,
            "page_size": page_size,
        }
    return {"items": [], "total": 0, "page": page, "page_size": page_size}


@router.get("/{doc_id}/download", summary="Get PDF download URL for a document")
async def get_pdf_url(
    current_user: CurrentUser,
    doc_id: UUID,
    doc_type: str = Query("procedure_act"),
    db: AsyncSession = Depends(get_db),
):
    """
    Get pre-signed MinIO URL for downloading a document PDF.
    Generates PDF if not yet created.
    """
    if doc_type == "procedure_act":
        pdf_url = await veterinary_service.generate_pdf(db, doc_id)
        if not pdf_url:
            raise HTTPException(
                status_code=503,
                detail="PDF generation failed. Check MinIO and ReportLab configuration.",
            )
        return {"pdf_url": pdf_url, "expires_in": 86400}

    raise HTTPException(status_code=400, detail=f"Unsupported document type: {doc_type}")


@router.post("/{doc_id}/sign/initiate", summary="Initiate EDS signing via eGov Mobile")
async def initiate_signing(
    current_user: CurrentUser,
    doc_id: UUID,
    doc_type: str = Query("procedure_act"),
    _: None = Depends(require_permission(Permission.PROCEDURE_SIGN)),
    db: AsyncSession = Depends(get_db),
):
    """
    Initiate EDS signing flow. Returns QR code data for eGov Mobile.

    Flow:
    1. Call this endpoint to get challenge_token + QR data
    2. Display QR code to user
    3. User scans with eGov Mobile and signs with their PIN
    4. eGov Mobile calls back to /auth/eds-callback
    5. Call POST /sign/complete with the received signature
    """
    if doc_type == "procedure_act":
        result = await veterinary_service.initiate_signing(
            db,
            doc_id,
            signer_id=current_user.id,
            signer_name=current_user.full_name,
            signer_iin=current_user.iin,
        )
        return result

    raise HTTPException(status_code=400, detail=f"Unsupported document type: {doc_type}")


@router.post("/{doc_id}/sign/complete", summary="Complete EDS signing after eGov Mobile callback")
async def complete_signing(
    current_user: CurrentUser,
    doc_id: UUID,
    body: CompleteSignRequest,
    doc_type: str = Query("procedure_act"),
    db: AsyncSession = Depends(get_db),
):
    """
    Complete signing after receiving signature from eGov Mobile.
    Verifies signature via KNCA and updates document status.
    """
    # Verify signature via KNCA
    is_valid, error = await egov_mobile_client.verify_signature(
        document_hash=body.challenge_token,  # hash was embedded in QR
        signature_data=body.signature_data,
        signer_iin=current_user.iin,
    )
    if not is_valid:
        raise HTTPException(status_code=400, detail=f"Signature invalid: {error}")

    if doc_type == "procedure_act":
        act = await veterinary_service.complete_signing(
            db,
            doc_id,
            challenge_token=body.challenge_token,
            signature_data=body.signature_data,
            signer_id=current_user.id,
            signer_name=current_user.full_name,
            signer_iin=current_user.iin,
        )
        return {
            "status": "signed",
            "act_id": str(act.id),
            "act_number": act.act_number,
            "signed_at": act.signed_at.isoformat() if act.signed_at else None,
        }

    raise HTTPException(status_code=400, detail=f"Unsupported document type: {doc_type}")


@router.get("/signatures/{doc_type}/{doc_id}", summary="Get EDS signatures for a document")
async def get_signatures(
    current_user: CurrentUser,
    doc_type: str,
    doc_id: str,
    db: AsyncSession = Depends(get_db),
) -> dict:
    result = await db.execute(
        select(DigitalSignature).where(
            DigitalSignature.document_type == doc_type,
            DigitalSignature.document_id == doc_id,
        )
    )
    sigs = result.scalars().all()
    return {
        "document_type": doc_type,
        "document_id": doc_id,
        "signatures": [
            {
                "id": str(s.id),
                "signer_name": s.signer_name,
                "signer_iin": s.signer_iin,
                "signed_at": s.signed_at.isoformat() if s.signed_at else None,
                "is_valid": s.is_valid,
            }
            for s in sigs
        ],
    }


@router.get("/ncalayer/js-snippet", summary="Get NCALayer JS snippet for desktop signing")
async def get_ncalayer_snippet(
    current_user: CurrentUser,
    document_hash: str = Query(..., description="SHA-256 hash of document"),
):
    """Returns JavaScript snippet for NCALayer WebSocket desktop signing."""
    from app.integrations.ncalayer.client import NCALayerDesktopClient
    snippet = NCALayerDesktopClient.get_frontend_js_snippet(document_hash)
    return {"js_snippet": snippet, "ncalayer_url": NCALayerDesktopClient.NCALAYER_URL}
