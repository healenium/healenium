#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-${0}}")" && pwd)"
cd "$SCRIPT_DIR"

log() {
  printf '%s\n' "$*" >&2
}

fatal() {
  log "ERROR: $*"
  exit 1
}

# Unzip latest *-pro-selenium.zip and create unversioned symlinks for JARs
ZIP_FILE="$(ls -1 ./*-pro-selenium.zip 2>/dev/null | sort | tail -n 1 || true)"

if [[ -z "$ZIP_FILE" ]]; then
  fatal "No *-pro-selenium.zip file found in ${SCRIPT_DIR}. Run download_pro.sh first."
fi

log "Using archive: $ZIP_FILE"
unzip -oq "$ZIP_FILE" -d "$SCRIPT_DIR"

link_latest_jar() {
  local pattern="$1"
  local link_name="$2"

  local target
  target="$(find "$SCRIPT_DIR" -maxdepth 2 -type f -name "$pattern" | sort | tail -n 1 || true)"

  if [[ -z "$target" ]]; then
    fatal "No JAR found for pattern '$pattern'."
  fi

  ln -sf "$target" "$link_name"
  log "Linked $link_name -> $target"
}

link_latest_jar "hlm-backend-*.jar"      "hlm-backend.jar"
link_latest_jar "hlm-proxy-*.jar"        "hlm-proxy.jar"
link_latest_jar "hlm-ui-dashboard-*.jar" "hlm-ui-dashboard.jar"
link_latest_jar "hlm-ai-*.jar"           "hlm-ai.jar"

# Ensure selector imitator folder is available at expected path
if [[ ! -d "healenium-selector-imitator" ]]; then
  SEL_DIR="$(find "$SCRIPT_DIR" -maxdepth 2 -type d -name 'healenium-selector-imitator' | head -n 1 || true)"
  if [[ -n "$SEL_DIR" && "$SEL_DIR" != "${SCRIPT_DIR}/healenium-selector-imitator" ]]; then
    ln -s "$SEL_DIR" healenium-selector-imitator
    log "Linked healenium-selector-imitator -> $SEL_DIR"
  fi
fi

# Backend configuration
HLM_POSTGRES_DB_HOST=localhost
HLM_POSTGRES_DB_PORT=5432
HLM_POSTGRES_DB=healenium
HLM_POSTGRES_SCHEMA=healenium
HLM_POSTGRES_USER=healenium_user
HLM_POSTGRES_PASSWORD=YDk2nmNs4s9aCP6K
HLM_COLLECT_METRICS=true
HLM_SERVER_PORT=7878
HLM_FIND_ELEMENTS_AUTO_HEALING=false
HLM_LOG_LEVEL=info

# Proxy configuration
RECOVERY_TRIES=1
SCORE_CAP=.6
HEAL_ENABLED=true
SELENIUM_SERVER_URL=http://localhost:4444
# For Appium:
# SELENIUM_SERVER_URL=http://localhost:4723/wd/hub
HEALENIUM_SERVER_URL=http://localhost:7878
HEALENIUM_SERVICE=http://localhost:7878
IMITATE_SERVICE=http://localhost:8000

# UI dashboard configuration
VITE_API_BASE_URL=http://localhost:8085

# Start hlm-backend
SPRING_POSTGRES_DB_HOST=$HLM_POSTGRES_DB_HOST \
SPRING_POSTGRES_DB_PORT=$HLM_POSTGRES_DB_PORT \
SPRING_POSTGRES_DB=$HLM_POSTGRES_DB \
SPRING_POSTGRES_SCHEMA=$HLM_POSTGRES_SCHEMA \
SPRING_POSTGRES_USER=$HLM_POSTGRES_USER \
SPRING_POSTGRES_PASSWORD=$HLM_POSTGRES_PASSWORD \
COLLECT_METRICS=$HLM_COLLECT_METRICS \
SPRING_SERVER_PORT=$HLM_SERVER_PORT \
HLM_LOG_LEVEL=$HLM_LOG_LEVEL \
java -jar hlm-backend.jar 2>&1 & echo $! > ./pid-hlm-backend.file &

# Start hlm-proxy
RECOVERY_TRIES=$RECOVERY_TRIES \
SCORE_CAP=$SCORE_CAP \
HEAL_ENABLED=$HEAL_ENABLED \
SELENIUM_SERVER_URL=$SELENIUM_SERVER_URL \
APPIUM_SERVER_URL=${APPIUM_SERVER_URL:-} \
HEALENIUM_SERVER_URL=$HEALENIUM_SERVER_URL \
HEALENIUM_SERVICE=$HEALENIUM_SERVICE \
IMITATE_SERVICE=$IMITATE_SERVICE \
HLM_LOG_LEVEL=$HLM_LOG_LEVEL \
java -jar hlm-proxy.jar 2>&1 & echo $! > ./pid-hlm-proxy.file &

# Start selector imitator
pip install --upgrade pip
pip install -r healenium-selector-imitator/requirements.txt

if [[ $OSTYPE == 'msys'* ]]; then
  python healenium-selector-imitator/app.py & echo $! > ./pid-selector.file &
else
  python3 healenium-selector-imitator/app.py & echo $! > ./pid-selector.file &
fi

# Start UI dashboard
VITE_API_BASE_URL=$VITE_API_BASE_URL \
java -jar hlm-ui-dashboard.jar 2>&1 & echo $! > ./pid-hlm-ui-dashboard.file &

# Start AI service
HEALENIUM_SERVICE=$HEALENIUM_SERVICE \
java -jar hlm-ai.jar 2>&1 & echo $! > ./pid-hlm-ai.file &