# Kiến trúc hệ thống — Thư viện số Trường Đại học

## 1. Tổng quan

Hệ thống tách biệt 3 lớp chính để 4 thành viên dễ chia việc và ít xung đột code:

- **`backend/` (FastAPI + SQLAlchemy 2.0 + psycopg v3):** Cung cấp REST API tại `/api/v1`, chia theo từng module nghiệp vụ.
- **`frontend/` (React 18 + Vite 7 + CSS thuần):** Giao diện người dùng, tổ chức theo từng feature tương ứng với Backend.
- **`database/` (PostgreSQL — SQL thuần):** Lưu schema tổng quan, các file migration đánh số tăng dần và script dữ liệu mẫu.

## 2. Ánh xạ Module Backend <-> Feature Frontend

| Nghiệp vụ | Backend (`backend/app/modules/`) | Frontend (`frontend/src/features/`) |
| --- | --- | --- |
| Xác thực & phân quyền | `auth/` | `auth/` |
| Quản lý tài khoản / thẻ thư viện | `users/` | `auth/` hoặc `users/` |
| Danh mục tài liệu, khoa, ngành | `catalog/` | `catalog/` |
| Tài liệu số (xem/tải PDF, metadata) | `documents/` | `reader/` |
| Mượn / trả / đặt trước | `borrowing/` | `borrowing/` |

## 3. Quy ước một module Backend

Mỗi module trong `backend/app/modules/<ten_module>/` nên giữ cấu trúc gọn, nhất quán:

```text
<ten_module>/
├── __init__.py
├── router.py      # Định nghĩa FastAPI routes
├── schemas.py     # Pydantic request / response models
├── service.py     # Xử lý logic nghiệp vụ
└── repository.py  # Truy vấn PostgreSQL (SQLAlchemy 2.0)
```
