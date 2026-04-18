from __future__ import annotations

from typing import ClassVar

from django.contrib.auth.models import AbstractUser

from apps.core.models import BaseModel


class User(BaseModel, AbstractUser):
    class Meta:
        verbose_name = "User"
        verbose_name_plural = "Users"
        ordering: ClassVar[list[str]] = ["-date_joined"]
