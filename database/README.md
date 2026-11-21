# Database (PostgreSQL — SQL thuần)

## Cấu trúc

- `migrations/`: Các file SQL thay đổi cấu trúc bảng, đánh số tăng dần (`001_init.sql`, `002_create_users.sql`, ...).
- `seeds/`: Các file SQL nạp dữ liệu mẫu sạch để dev/test local.
- `schema.sql`: Bản tổng hợp schema hiện tại để dễ tra cứu.

## Quy tắc

1. **Không sửa** file migration đã được merge vào `main`. Muốn chỉnh sửa bảng, hãy tạo file migration mới với số thứ tự tiếp theo.
2. Mọi file trong `migrations/` nên viết an toàn (ưu tiên `IF NOT EXISTS` khi phù hợp).
3. Nếu chạy bằng `docker compose up -d`, PostgreSQL sẽ tự động chạy các file trong `database/migrations/` khi khởi tạo database lần đầu.
