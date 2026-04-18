from __future__ import annotations

from typing import Any

from django.db import models


class CreatedField(models.DateTimeField[Any, Any]):
    """Created datetime field."""

    def __init__(self, **kwargs: Any) -> None:
        kwargs["auto_now_add"] = True
        kwargs["editable"] = False
        super().__init__(**kwargs)


class ModifiedField(models.DateTimeField[Any, Any]):
    """Modified datetime field."""

    def __init__(self, **kwargs: Any) -> None:
        kwargs["auto_now"] = True
        kwargs["editable"] = False
        super().__init__(**kwargs)
