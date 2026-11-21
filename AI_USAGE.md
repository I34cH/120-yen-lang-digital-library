# Nhật ký sử dụng AI (AI_USAGE.md)

Theo quy định học phần *Cơ sở dữ liệu Web và Hệ thống thông tin*, tài liệu này ghi nhận ngắn gọn phạm vi sử dụng công cụ AI hỗ trợ trong quá trình phát triển Project nhóm **120 YÊN LÃNG** và cách thành viên kiểm chứng lại kết quả.

> **Nguyên tắc nhóm:** Mọi đoạn mã, câu SQL hoặc cấu hình do AI gợi ý đều phải được thành viên đọc hiểu, tự chạy kiểm chứng (test / SQL / Docker / DevTools) và có thể giải thích trực tiếp khi bảo vệ không dùng AI.

---

## Bảng ghi nhận các hạng mục có AI hỗ trợ

| Ngày | Thành viên | Hạng mục / Vấn đề | Công cụ AI | Phần đã dùng / Không dùng | Cách kiểm chứng thực tế |
| --- | --- | --- | --- | --- | --- |
| 2026-11-21 | Nguyễn Văn Bách (`I34cH`) | Khởi tạo cấu trúc repository, `.gitignore`, Dockerfile, khung 3 VM và GitHub Actions CI | Antigravity | Dùng khung thư mục, `.gitignore` và workflow mẫu; bỏ phần cấu hình AI dùng chung để mỗi thành viên tự cấu hình trên máy | Chạy `node --test`, `python -m compileall`, `git check-ignore` và kiểm tra GitHub Actions CI pass xanh |
| *(cập nhật tiếp...)* | | | | | |
