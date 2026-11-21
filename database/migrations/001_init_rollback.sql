-- 001_init_rollback.sql
-- Chỉ dùng trên môi trường thử nghiệm khi chấp nhận xóa bảng schema_migrations.

BEGIN;

DROP TABLE IF EXISTS schema_migrations;

COMMIT;
