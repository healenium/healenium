#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-${0}}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/../.env"

REPO="healenium/aws-healenium-pro"
FILE_PATTERN="-pro-playwright.zip"

log() {
  printf '%s\n' "$*" >&2
}

fatal() {
  log "ERROR: $*"
  exit 1
}

# Load .env and always take token from there
if [[ ! -f "$ENV_FILE" ]]; then
  fatal ".env file not found next to this script: ${ENV_FILE}"
fi

set -a
# shellcheck disable=SC1090
source "$ENV_FILE"
set +a

GITHUB_TOKEN="${GITHUB_TOKEN:-}"

if [[ -z "$GITHUB_TOKEN" ]]; then
  fatal "GITHUB_TOKEN is not set in .env. Define GITHUB_TOKEN=... inside ${ENV_FILE}."
fi

LATEST_JSON=$(
  curl -sSfL \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/$REPO/releases/latest"
)

if [[ -z "$LATEST_JSON" || "$LATEST_JSON" == *"Not Found"* ]]; then
  fatal "Failed to fetch latest release metadata. Check token permissions (contents:read) and repository access."
fi

VERSION="$(jq -r '.tag_name' <<<"$LATEST_JSON")"

if [[ -z "$VERSION" || "$VERSION" == "null" ]]; then
  fatal "Failed to determine latest release tag_name."
fi

EXPECTED_FILENAME="${VERSION}${FILE_PATTERN}"

ASSET_ID="$(
  jq -r --arg fn "$EXPECTED_FILENAME" \
    '.assets[] | select(.name == $fn) | .id' <<<"$LATEST_JSON"
)"

if [[ -z "$ASSET_ID" || "$ASSET_ID" == "null" ]]; then
  log "Available assets:"
  jq -r '.assets[].name' <<<"$LATEST_JSON"
  fatal "Asset '${EXPECTED_FILENAME}' not found in latest release (${VERSION})."
fi

log "Latest release: ${VERSION}"
log "File: ${EXPECTED_FILENAME}"
log "Asset ID: ${ASSET_ID}"

curl -fL \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/octet-stream" \
  "https://api.github.com/repos/$REPO/releases/assets/${ASSET_ID}" \
  -o "${EXPECTED_FILENAME}" || fatal "Failed to download asset."

ls -lh "${EXPECTED_FILENAME}"
