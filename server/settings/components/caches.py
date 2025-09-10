import os

REDIS_HOST: str = os.environ.get("REDIS_HOST", "redis://redis:6379/0")
REDIS_SOCKET_TIMEOUT: int | None = os.getenv("REDIS_SOCKET_TIMEOUT", None)

CACHES = {
    "default": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": REDIS_HOST,
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
            "SOCKET_TIMEOUT": REDIS_SOCKET_TIMEOUT,
        },
    },
}
