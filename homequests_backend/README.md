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
  Hinweis: Host `db` ist fuer Docker Compose gedacht und im HA Add-on normalerweise nicht erreichbar.
  Wenn die externe DB nicht erreichbar ist, faellt das Add-on automatisch auf SQLite zurueck.
- APNs-Felder (`apns_enabled`, `apns_team_id`, `apns_key_id`, `apns_bundle_id`, `apns_private_key_path`)

## Empfohlener Start

1. Nur `secret_key` setzen
2. Add-on starten
3. WebUI testen
4. Erst danach optional auf externe Postgres-DB umstellen

## Benachrichtigungen

Empfohlen:

- Benachrichtigungen ueber Home Assistant nutzen (`home_assistant`).
- In der HomeQuests WebUI konfigurierbar (HA Base URL, Token, Notify-Service, SSL-Optionen).

Alternativ:

- Apple Push Notification (APNs) nutzen. Erfordert einen Apple Developer Account.
- APNs im Add-on nur ueber `apns_private_key_path` als Datei unter `/ssl/...`.
- Das Add-on mountet `/ssl` read-only.
- Vollstaendige APNs-Schritt-fuer-Schritt-Anleitung:
  [HomeQuests Backend: APNs Remote Push Anleitung](https://github.com/kolossboss/HomeQuests-backend/blob/main/docs/apns-remote-push.md)

## Wichtige Optionen

- `secret_key`: Signatur fuer JWT/Session, immer setzen und stabil halten.
  Im Terminal erzeugen:
  `openssl rand -base64 48`
- `database_url`: Optional. Wenn leer, wird `sqlite:////data/homequests.db` verwendet.

## Erreichbarkeit

- WebUI: `http://HOME_ASSISTANT_HOST:8010/`
- API-Doku: `http://HOME_ASSISTANT_HOST:8010/docs`
- Health: `http://HOME_ASSISTANT_HOST:8010/health`
