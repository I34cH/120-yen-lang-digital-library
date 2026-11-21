-- 001_init.sql
-- Migration khởi tạo bảng theo dõi phiên bản migration (schema_migrations).
-- Các bảng nghiệp vụ của Thư viện số sẽ được thêm ở các migration tiếp theo (002_..., 003_...).

BEGIN;

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE IF NOT EXISTS schema_migrations (
    version VARCHAR(50) NOT NULL PRIMARY KEY,
    description VARCHAR(200) NOT NULL,
    applied_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO schema_migrations (version, description)
VALUES ('001', 'Initialize schema_migrations and pgcrypto extension')
ON CONFLICT (version) DO NOTHING;

COMMIT;
