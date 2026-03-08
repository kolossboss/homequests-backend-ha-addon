# HomeQuests Backend Add-on

Dieses Add-on startet das HomeQuests Backend inklusive WebUI direkt in Home Assistant.

## Funktionsumfang

- FastAPI Backend
- Integrierte WebUI unter `/`
- API-Dokumentation unter `/docs`
- Persistente lokale SQLite-Datenbank ohne externe Abhaengigkeiten

## Konfiguration

Pflicht:

- `secret_key` (mindestens 16 Zeichen)

Optional (haeufig):

- `database_url` fuer externe DB (z. B. PostgreSQL)
- `cors_allow_origins` (`*` oder CSV-Liste)
- `auth_cookie_secure`
- `sse_allow_query_token`
- APNs-Felder (`apns_enabled`, `apns_team_id`, `apns_key_id`, `apns_bundle_id`, `apns_private_key`, `apns_private_key_path`)

## Empfohlener Start

1. Nur `secret_key` setzen
2. Add-on starten
3. WebUI testen
4. Erst danach optional auf externe Postgres-DB umstellen

## APNs Hinweise

- Empfohlen: `apns_private_key_path` auf eine Datei unter `/ssl/...` setzen
- `apns_private_key` (Inline `.p8` Inhalt) nur als Ausnahme verwenden
- Das Add-on mountet `/ssl` read-only

Vollstaendige APNs-Schritt-fuer-Schritt-Anleitung:

- [HomeQuests Backend: APNs Remote Push Anleitung](https://github.com/kolossboss/HomeQuests-backend/blob/main/backend/docs/apns-remote-push.md)

Empfehlung: Statt APNs den im Backend integrierten HomeQuests-Kanal `home_assistant` fuer Benachrichtigungen nutzen.

## Secret-Schluessel

- `secret_key`: Signatur fuer JWT/Session, immer setzen und stabil halten.
- `secret_encryption_key`: Optionaler separater Verschluesselungsschluessel fuer gespeicherte Secrets.
  Wenn leer, wird automatisch `secret_key` verwendet.

## Erreichbarkeit

- WebUI: `http://HOME_ASSISTANT_HOST:8010/`
- API-Doku: `http://HOME_ASSISTANT_HOST:8010/docs`
- Health: `http://HOME_ASSISTANT_HOST:8010/health`
