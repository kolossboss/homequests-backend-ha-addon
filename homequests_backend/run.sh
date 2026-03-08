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

json_int() {
  local path="$1"
  local default_value="$2"
  jq -r "${path} // ${default_value}" "${OPTIONS_FILE}"
}

APP_NAME="$(json_string '.app_name')"
SECRET_KEY="$(json_string '.secret_key')"
SECRET_ENCRYPTION_KEY="$(json_string '.secret_encryption_key')"
DATABASE_URL="$(json_string '.database_url')"
ACCESS_TOKEN_EXPIRE_MINUTES="$(json_int '.access_token_expire_minutes' '525600')"
CORS_ALLOW_ORIGINS="$(json_string '.cors_allow_origins')"
AUTH_COOKIE_SECURE="$(json_bool '.auth_cookie_secure')"
SSE_ALLOW_QUERY_TOKEN="$(json_bool '.sse_allow_query_token')"
PENALTY_WORKER_ENABLED="$(json_bool '.penalty_worker_enabled')"
PENALTY_WORKER_INTERVAL_SECONDS="$(json_int '.penalty_worker_interval_seconds' '60')"
PUSH_WORKER_ENABLED="$(json_bool '.push_worker_enabled')"
PUSH_WORKER_INTERVAL_SECONDS="$(json_int '.push_worker_interval_seconds' '60')"
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

if [[ -z "${CORS_ALLOW_ORIGINS}" ]]; then
  CORS_ALLOW_ORIGINS="*"
fi

export APP_NAME
export SECRET_KEY
export SECRET_ENCRYPTION_KEY
export DATABASE_URL
export ACCESS_TOKEN_EXPIRE_MINUTES
export CORS_ALLOW_ORIGINS
export AUTH_COOKIE_SECURE
export SSE_ALLOW_QUERY_TOKEN
export PENALTY_WORKER_ENABLED
export PENALTY_WORKER_INTERVAL_SECONDS
export PUSH_WORKER_ENABLED
export PUSH_WORKER_INTERVAL_SECONDS
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
