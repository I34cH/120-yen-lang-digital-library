#!/usr/bin/env bash
set -euo pipefail

# Khôi phục file .dump sang một database thử nghiệm để kiểm chứng backup (không ghi đè DB chính).
# Cách dùng: bash restore.sh ./backups/<ten-file>.dump [ten_db_thu]

if [ "$#" -lt 1 ]; then
  echo "Cach dung: bash restore.sh <duong-dan-file.dump> [ten_db_thu]"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/.env"

DUMP_FILE="$1"
TARGET_DB="${2:-${POSTGRES_DB}_restore_test}"

docker exec digital_library_postgres \
  psql -U "${POSTGRES_USER}" -d postgres -c "DROP DATABASE IF EXISTS ${TARGET_DB};"
docker exec digital_library_postgres \
  psql -U "${POSTGRES_USER}" -d postgres -c "CREATE DATABASE ${TARGET_DB};"

docker exec -i digital_library_postgres \
  pg_restore -U "${POSTGRES_USER}" -d "${TARGET_DB}" --no-owner --no-privileges < "${DUMP_FILE}"

echo "Khoi phuc thanh cong vao database thu nghiem: ${TARGET_DB}"
