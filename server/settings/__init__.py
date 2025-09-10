from os import environ

import django_stubs_ext
from split_settings.tools import include, optional

django_stubs_ext.monkeypatch()

# Managing environment via `DJANGO_ENV` variable:
environ.setdefault("DJANGO_ENV", "dev")
_ENV = environ["DJANGO_ENV"]

_base_settings = (
    "components/common.py",
    "components/logging.py",
    "components/csp.py",
    "components/caches.py",
    # Select the right env:
    f"environments/{_ENV}.py",
    # Optionally override some settings:
    optional("environments/test.py"),
)

# Include settings:
include(*_base_settings)
