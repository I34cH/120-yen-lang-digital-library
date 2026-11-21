# Thiết kế Cơ sở dữ liệu (ERD)

> Tài liệu này ghi nhận sơ đồ ERD, danh sách bảng, khóa chính/khóa ngoại và ràng buộc dữ liệu của Hệ thống Quản lý Thư viện Số.

## Các nhóm bảng dự kiến

1. **Người dùng & Phân quyền:** `roles`, `users`
2. **Danh mục học thuật:** `faculties` (khoa), `categories` (loại tài liệu), `authors` (tác giả)
3. **Tài liệu số:** `documents`, `document_authors`, `document_files`
4. **Tương tác / Mượn trả (nếu áp dụng):** `borrow_records`, `bookmarks`, `download_logs`

*(Cập nhật sơ đồ ERD chi tiết sau khi nhóm thống nhất schema.)*
