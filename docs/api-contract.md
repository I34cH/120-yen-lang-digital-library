# API Contract (Thống nhất giữa Backend & Frontend)

Base URL local: `http://localhost:8000`

## Quy ước chung

- Prefix API: `/api/v1`
- Format dữ liệu: `application/json` (trừ endpoint upload/download file)
- Kiểm tra hoạt động hệ thống:
  - `GET /health` → `200 OK` `{ "status": "ok", "service": "digital-library-api" }`

## Danh sách Endpoints (Cập nhật theo từng sprint)

| Module | Method | Endpoint | Mô tả | Trạng thái |
| --- | :-: | --- | --- | :-: |
| System | `GET` | `/health` | Kiểm tra server sống | Ready |
| Auth | `POST` | `/api/v1/auth/login` | Đăng nhập | Planned |
| Catalog | `GET` | `/api/v1/documents` | Tìm kiếm / lọc danh sách tài liệu | Planned |
| Documents | `GET` | `/api/v1/documents/{id}` | Xem chi tiết tài liệu | Planned |
