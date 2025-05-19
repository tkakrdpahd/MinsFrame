#!/usr/bin/env bash
set -euo pipefail

# ─── 경로 ─────────────────────────────────────────────
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

# ─── .env 로드 ───────────────────────────────────────
export $(grep -v '^#' "$ROOT_DIR/.env" | xargs)

# ─── Docker 정리 ─────────────────────────────────────
echo "[docker] prune ..."
docker system prune -af

# ─── 이미지 빌드 ─────────────────────────────────────
echo "[docker] build (no-cache) ..."
docker compose \
  --env-file "$ROOT_DIR/.env" \
  -f "$ROOT_DIR/docker/docker-compose.yml" \
  -p "${PROJECT_NAME}-${MODE}" \
  build --no-cache

# ─── 컨테이너 기동 ───────────────────────────────────
echo "[docker] up (detached) ..."
docker compose \
  --env-file "$ROOT_DIR/.env" \
  -f "$ROOT_DIR/docker/docker-compose.yml" \
  -p "${PROJECT_NAME}-${MODE}" \
  up -d
