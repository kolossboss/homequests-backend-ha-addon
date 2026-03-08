#!/usr/bin/env bash
set -euo pipefail

OPTIONS_FILE="/data/options.json"

if [[ ! -f "${OPTIONS_FILE}" ]]; then
  echo "{}" > "${OPTIONS_FILE}"
fi

json_string() {
  local path="$1"
  jq -r "${path} // \"\"" "${OPTIONS_FILE}"
}

json_bool() {
  local path="$1"
  local raw
  raw="$(jq -r "${path} // false" "${OPTIONS_FILE}")"
  if [[ "${raw}" == "true" ]]; then
    echo "true"
  else
    echo "false"
  fi
}

SECRET_KEY="$(json_string '.secret_key')"
DATABASE_URL="$(json_string '.database_url')"
APNS_ENABLED="$(json_bool '.apns_enabled')"
APNS_TEAM_ID="$(json_string '.apns_team_id')"
APNS_KEY_ID="$(json_string '.apns_key_id')"
APNS_BUNDLE_ID="$(json_string '.apns_bundle_id')"
APNS_PRIVATE_KEY_PATH="$(json_string '.apns_private_key_path')"

if [[ -z "${SECRET_KEY}" ]]; then
  echo "[ERROR] Option 'secret_key' darf nicht leer sein." >&2
  exit 1
fi

if [[ ${#SECRET_KEY} -lt 16 ]]; then
  echo "[ERROR] Option 'secret_key' muss mindestens 16 Zeichen lang sein." >&2
  exit 1
fi

if [[ -z "${DATABASE_URL}" ]]; then
  DATABASE_URL="sqlite:////data/homequests.db"
fi

if [[ "${DATABASE_URL}" == *"@db:"* ]]; then
  echo "[WARN] DATABASE_URL verweist auf Host 'db'. In Home Assistant Add-ons ist dieser Host normalerweise nicht erreichbar."
  echo "[WARN] Fallback auf lokale SQLite-Datenbank /data/homequests.db"
  DATABASE_URL="sqlite:////data/homequests.db"
fi

export SECRET_KEY
export DATABASE_URL
export APNS_ENABLED
export APNS_TEAM_ID
export APNS_KEY_ID
export APNS_BUNDLE_ID
export APNS_PRIVATE_KEY_PATH

echo "[INFO] Starte HomeQuests Backend"
echo "[INFO] DATABASE_URL gesetzt (${DATABASE_URL%%:*}://...)"

aexec() {
  exec "$@"
}

aexec uvicorn app.main:app --host 0.0.0.0 --port 8000
