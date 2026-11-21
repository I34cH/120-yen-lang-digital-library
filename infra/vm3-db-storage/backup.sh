#!/usr/bin/env bash
set -euo pipefail

# Backup PostgreSQL (custom format) từ container trên VM 3 vào ./backups/
# Cách dùng: bash backup.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/.env"

BACKUP_DIR="${SCRIPT_DIR}/backups"
mkdir -p "${BACKUP_DIR}"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
OUT_FILE="${BACKUP_DIR}/${POSTGRES_DB}_${TIMESTAMP}.dump"

docker exec digital_library_postgres \
  pg_dump -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -Fc > "${OUT_FILE}"

echo "Backup thanh cong: ${OUT_FILE}"
ls -lh "${OUT_FILE}"
