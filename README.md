# HomeQuests Home Assistant Add-on Repository

Dieses Repository enthaelt das HomeQuests Backend als Home Assistant Add-on.

## Verwandte Projekte

- iOS App: [HomeQuests im App Store](https://apps.apple.com/de/app/homequests/id6759489304)
- Haupt-Backend-Repository: [kolossboss/HomeQuests-backend](https://github.com/kolossboss/HomeQuests-backend)
- Home Assistant Integration (HACS): [kolossboss/homequests-backend-ha](https://github.com/kolossboss/homequests-backend-ha)

## Add-on in Home Assistant hinzufuegen

1. Home Assistant -> `Einstellungen` -> `Add-ons` -> `Add-on Store`
2. Oben rechts `...` -> `Repositories`
3. Diese URL einfuegen:
   `https://github.com/kolossboss/homequests-backend-ha-addon`
4. Add-on `HomeQuests Backend` oeffnen
5. `Installieren`
6. Unter `Konfiguration` mindestens `secret_key` setzen
7. Add-on starten

## Beispielkonfiguration

```yaml
app_name: HomeQuests API
secret_key: "bitte-einen-langen-secret-key-verwenden"
secret_encryption_key: ""
database_url: ""
access_token_expire_minutes: 525600
cors_allow_origins: "*"
auth_cookie_secure: false
sse_allow_query_token: false
penalty_worker_enabled: true
penalty_worker_interval_seconds: 60
push_worker_enabled: true
push_worker_interval_seconds: 60
apns_enabled: false
apns_team_id: ""
apns_key_id: ""
apns_bundle_id: swapps.HomeQuests
apns_private_key_path: ""
```

## Sicherheits-Hinweise zu Schluesseln

- `secret_key`:
  Signierschluessel fuer Login/JWT. Pflichtwert, lang und zufaellig waehlen.
  Im Terminal erzeugen:
  `openssl rand -base64 48`
- `secret_encryption_key`:
  Optionaler separater Schluessel fuer DB-Secrets (z. B. gespeicherte HA-Tokens).
  Wenn leer, faellt das Backend auf `secret_key` zurueck.
- `apns_private_key_path`:
  Empfohlener Weg. Pfad zur `.p8` Datei im Dateisystem, z. B.
  `/ssl/homequests/AuthKey_ABC123.p8`.

APNs im Add-on ist nur noch ueber `apns_private_key_path` vorgesehen.

## APNs Anleitung (Hauptrepo)

Die vollstaendige APNs-Einrichtung ist hier dokumentiert:

- [HomeQuests Backend: APNs Remote Push Anleitung](https://github.com/kolossboss/HomeQuests-backend/blob/main/backend/docs/apns-remote-push.md)

Empfehlung: Statt Apple Push Notification (APNs) die im Backend integrierte Home-Assistant-Benachrichtigungsfunktion von HomeQuests (Kanal `home_assistant`) nutzen.

## Erreichbarkeit nach dem Start

- WebUI: `http://HOME_ASSISTANT_HOST:8010/`
- API-Doku: `http://HOME_ASSISTANT_HOST:8010/docs`
- Health: `http://HOME_ASSISTANT_HOST:8010/health`

## Standard-Datenbank

Wenn `database_url` leer bleibt, wird automatisch SQLite genutzt:

`sqlite:////data/homequests.db`

## Vollautomatisch eingerichtet

- PRs in `main` werden automatisch auf `auto-merge (squash)` gestellt.
- Docker-Image wird automatisch in GHCR gebaut und bei `main`/Tags veroeffentlicht.
- Basis-CI prueft YAML und Startskript.

## Container-Image

- Registry: `ghcr.io/kolossboss/homequests-backend-ha-addon`
- `latest`: aktueller Stand von `main`
- `sha-*`: commitbasierte Tags
- `v*`: Release-Tags
