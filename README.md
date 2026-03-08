# HomeQuests Home Assistant Add-on Repository

Dieses Repository enthaelt das HomeQuests Backend als Home Assistant Add-on.

## Enthaltenes Add-on

- `homequests_backend`: HomeQuests API + WebUI

## Installation in Home Assistant

1. Home Assistant -> **Einstellungen** -> **Add-ons** -> **Add-on Store**
2. Oben rechts auf die drei Punkte -> **Repositories**
3. URL dieses GitHub-Repositories einfuegen
4. Das Add-on **HomeQuests Backend** oeffnen
5. **Installieren**
6. Unter **Konfiguration** mindestens `secret_key` setzen
7. Add-on starten

## Nach dem Start

- WebUI: `http://HOME_ASSISTANT_HOST:8010/`
- API Docs: `http://HOME_ASSISTANT_HOST:8010/docs`
- Health: `http://HOME_ASSISTANT_HOST:8010/health`

## GitHub anlegen (lokal)

```bash
cd backend-HA-app
git init
git add .
git commit -m "Initial Home Assistant Add-on for HomeQuests backend"
# Danach auf GitHub neues Repo erstellen und remote setzen:
# git remote add origin git@github.com:<USER>/<REPO>.git
# git push -u origin main
```
