from typing import Any, Optional


class VetDigitalException(Exception):
    def __init__(self, message: str, status_code: int = 400, details: Optional[Any] = None):
        self.message = message
        self.status_code = status_code
        self.details = details
        super().__init__(message)


class NotFoundError(VetDigitalException):
    def __init__(self, resource: str, identifier: Any = None):
        message = f"{resource} not found"
        if identifier:
            message = f"{resource} with id '{identifier}' not found"
        super().__init__(message=message, status_code=404)


class UnauthorizedError(VetDigitalException):
    def __init__(self, message: str = "Authentication required"):
        super().__init__(message=message, status_code=401)


class ForbiddenError(VetDigitalException):
    def __init__(self, message: str = "Insufficient permissions"):
        super().__init__(message=message, status_code=403)


class ValidationError(VetDigitalException):
    def __init__(self, message: str, details: Optional[Any] = None):
        super().__init__(message=message, status_code=422, details=details)


class ConflictError(VetDigitalException):
    def __init__(self, message: str):
        super().__init__(message=message, status_code=409)


class ExternalServiceError(VetDigitalException):
    def __init__(self, service: str, message: str):
        super().__init__(
            message=f"External service error [{service}]: {message}",
            status_code=502,
        )
