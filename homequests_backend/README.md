# HomeQuests Backend Add-on

Dieses Add-on startet das HomeQuests Backend inkl. WebUI direkt in Home Assistant.

## Enthalten

- FastAPI Backend
- WebUI unter `/`
- API Dokumentation unter `/docs`

## Standard-Datenbank

Wenn `database_url` leer bleibt, nutzt das Add-on automatisch:

`sqlite:////data/homequests.db`

Damit ist keine externe Datenbank noetig.

## Konfiguration

Pflicht:

- `secret_key` (mindestens 16 Zeichen)

Optional (Auszug):

- `database_url` (z. B. PostgreSQL extern)
- `cors_allow_origins` (z. B. `*` oder CSV-Liste)
- `sse_allow_query_token`
- `apns_enabled` + APNs Felder

## APNs Hinweise

- Entweder `apns_private_key` direkt setzen
- Oder `apns_private_key_path` auf eine Datei unter `/ssl/...` setzen
- Das Add-on mountet `/ssl` read-only

## Erreichbarkeit

Nach dem Start (Standard-Port):

- WebUI: `http://HOME_ASSISTANT_HOST:8010/`
- API Docs: `http://HOME_ASSISTANT_HOST:8010/docs`
- Health: `http://HOME_ASSISTANT_HOST:8010/health`
