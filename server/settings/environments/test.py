from __future__ import annotations

from split_settings.tools import include

from server.settings.components import BASE_DIR

include(
    "../components/common.py",
    "../components/logging.py",
    "../components/csp.py",
    "../components/caches.py",
    "dev.py",
)

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": BASE_DIR / "test.sqlite3",
    },
}

CACHES = {
    "default": {
        "BACKEND": "django.core.cache.backends.locmem.LocMemCache",
    },
}
