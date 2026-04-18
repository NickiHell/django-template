from __future__ import annotations

from typing import cast

from django.conf import settings
from django.contrib import admin
from django.urls import URLPattern, URLResolver, include, path
from ninja import NinjaAPI

api = NinjaAPI()

urlpatterns: list[URLPattern | URLResolver] = [
    path("api/", api.urls),
    path("admin/", admin.site.urls),
]


if settings.DEBUG:  # pragma: no cover
    import debug_toolbar
    from django.conf.urls.static import static

    urlpatterns = cast(
        "list[URLPattern | URLResolver]",
        [
            path("__debug__/", include(debug_toolbar.urls)),
            *urlpatterns,
            *static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT),
        ],
    )
