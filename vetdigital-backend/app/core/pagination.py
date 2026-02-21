from typing import Generic, List, TypeVar
from pydantic import BaseModel, Field
from app.config import settings

T = TypeVar("T")


class PaginationParams(BaseModel):
    page: int = Field(default=1, ge=1)
    size: int = Field(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE)

    @property
    def offset(self) -> int:
        return (self.page - 1) * self.size


class PagedResponse(BaseModel, Generic[T]):
    items: List[T]
    total: int
    page: int
    size: int
    pages: int

    @classmethod
    def create(cls, items: List[T], total: int, page: int, size: int) -> "PagedResponse[T]":
        pages = (total + size - 1) // size if total > 0 else 0
        return cls(items=items, total=total, page=page, size=size, pages=pages)
