FROM python:3.13-slim-bookworm

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_PYTHON_DOWNLOADS=never \
    PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PYTHONDONTWRITEBYTECODE=1 \
    PATH="/app/.venv/bin:$PATH"

ARG WITH_DEV=false
ARG UID=1000
ARG GID=1000

SHELL ["/bin/bash", "-eo", "pipefail", "-c"]

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    bash \
    brotli \
    build-essential \
    curl \
    gettext \
    git \
    libpq-dev \
    postgresql-client \
    tini \
    wait-for-it \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN groupadd -g "${GID}" -r web \
  && useradd -d /app -g web -l -r -u "${UID}" web \
  && mkdir -p /var/www/django/static /var/www/django/media \
  && chown web:web /var/www/django/static /var/www/django/media

COPY pyproject.toml uv.lock ./

RUN --mount=type=cache,target=/root/.cache/uv \
    if [[ "${WITH_DEV}" == "true" ]]; then \
      uv sync --frozen; \
    else \
      uv sync --frozen --no-group dev; \
    fi \
  && chown -R web:web /app/.venv

COPY --chown=web:web . .

COPY docker/django/entrypoint.sh /entrypoint.sh
COPY docker/django/gunicorn.sh /gunicorn.sh

RUN chmod +x /entrypoint.sh \
  && sed -i 's/\r$//g' /entrypoint.sh \
  && mkdir -p /app/static /app/media \
  && chown -R web:web /app

USER web

ENTRYPOINT ["tini", "--", "/entrypoint.sh"]
