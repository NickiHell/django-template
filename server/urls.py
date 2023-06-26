from django.conf import settings
from django.contrib import admin
from django.urls import path, include
from ninja import NinjaAPI

api = NinjaAPI()

urlpatterns = [
    path("admin/", admin.site.urls),
]


if settings.DEBUG:  # pragma: no cover
    # external
    import debug_toolbar
    from django.conf.urls.static import static

    urlpatterns = [
        # URLs specific only to django-debug-toolbar:
        path('__debug__/', include(debug_toolbar.urls)),
        *urlpatterns,
        # Serving media files in development only:
        *static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT),
    ]
