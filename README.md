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
secret_key: ""
database_url: ""
apns_enabled: false
apns_team_id: ""
apns_key_id: ""
apns_bundle_id: swapps.HomeQuests
apns_private_key_path: ""
```

## Wichtige Optionen

- `secret_key`:
  Signierschluessel fuer Login/JWT. Pflichtwert, lang und zufaellig waehlen.
  Im Terminal erzeugen:
  `openssl rand -base64 48`
- `database_url`:
  Optional. Wenn leer, wird automatisch `sqlite:////data/homequests.db` verwendet.
  Hinweis: Werte mit Host `db` sind fuer Docker Compose gedacht und im HA Add-on normalerweise nicht erreichbar.

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
