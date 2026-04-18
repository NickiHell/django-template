from __future__ import annotations

import os

REDIS_URL: str = os.environ.get("REDIS_URL", "redis://redis:6379/0")
_raw_timeout = os.environ.get("REDIS_SOCKET_TIMEOUT")
REDIS_SOCKET_TIMEOUT: float | None = float(_raw_timeout) if _raw_timeout is not None else None

CACHES = {
    "default": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": REDIS_URL,
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
            "SOCKET_TIMEOUT": REDIS_SOCKET_TIMEOUT,
        },
    },
}
