# Postman Collections (Tùy chọn)

Thư mục này **không bắt buộc** — nhóm có thể kiểm thử API trực tiếp bằng Swagger UI của FastAPI (`http://localhost:8000/docs`). Nếu muốn dùng thêm Postman và chia sẻ bộ test cho cả nhóm thì lưu các file `*.postman_collection.json` tại đây.

## Quy ước
- Đặt tên file rõ ràng theo module hoặc giai đoạn, ví dụ: `digital_library_v1.postman_collection.json`.
- **Không export kèm mật khẩu thật hoặc JWT token cá nhân** trong file collection (dùng biến môi trường Postman như `{{base_url}}`, `{{access_token}}`).
