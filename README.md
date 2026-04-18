# Django Template

[![Application CI](https://github.com/The-Dark-Limit/django-template/actions/workflows/backend.yml/badge.svg)](https://github.com/The-Dark-Limit/django-template/actions/workflows/backend.yml)
[![Dependency Review](https://github.com/The-Dark-Limit/django-template/actions/workflows/dependency-review.yml/badge.svg?branch=main)](https://github.com/The-Dark-Limit/django-template/actions/workflows/dependency-review.yml)
[![Code Quality](https://github.com/The-Dark-Limit/django-template/actions/workflows/codeql.yml/badge.svg?branch=main)](https://github.com/The-Dark-Limit/django-template/actions/workflows/codeql.yml)
[![Security Scanning](https://github.com/The-Dark-Limit/django-template/actions/workflows/codacy.yml/badge.svg?branch=main)](https://github.com/The-Dark-Limit/django-template/actions/workflows/codacy.yml)
[![Mark stale issues and pull requests](https://github.com/The-Dark-Limit/django-template/actions/workflows/stale.yml/badge.svg?branch=main)](https://github.com/The-Dark-Limit/django-template/actions/workflows/stale.yml)

Python **3.13+**, Django **6**, зависимости через **[uv](https://docs.astral.sh/uv/)**.

## Локально

```bash
cp config/.example.env config/.env
uv sync --group dev
uv run ruff check .
uv run ruff format --check .
uv run mypy
uv run pytest
DJANGO_SETTINGS_MODULE=server.settings.environments.test uv run python manage.py migrate
```

## Docker Compose

```bash
cp config/.example.env config/.env
docker compose up --build
```

Приложение: `http://127.0.0.1:8000`, nginx (прокси): `http://127.0.0.1:8080`, health nginx: `http://127.0.0.1:8080/health`.
