# Kiến trúc triển khai 03 Máy ảo (3 VM — Yêu cầu bắt buộc)

Theo yêu cầu Project cuối kỳ (Mục V), hệ thống hoàn chỉnh phải chạy trên **03 VM tách biệt có hệ điều hành khách và địa chỉ IP riêng** (không tính 3 container/3 port trên cùng 1 VM).

```text
[Trình duyệt người dùng]
          │ HTTP/HTTPS (80 / 443)
          ▼
┌──────────────────────────────┐
│ VM 1 — Frontend (Nginx+React)│  infra/vm1-frontend/
└──────────────┬───────────────┘
               │ /api/* -> http://<VM2_IP>:8000/ (mạng nội bộ)
               ▼
┌──────────────────────────────┐
│ VM 2 — Backend (FastAPI)     │  infra/vm2-backend/
└──────────────┬───────────────┘
               │ SQL (5432) + Object Storage S3/MinIO (9000) (mạng nội bộ)
               ▼
┌──────────────────────────────┐
│ VM 3 — DB + Storage          │  infra/vm3-db-storage/
│  • PostgreSQL 16             │
│  • MinIO (lưu PDF/tài liệu)  │
│  • Backup / Restore scripts  │
└──────────────────────────────┘
```

## Quy tắc mạng & bảo mật bắt buộc

| Máy ảo | Cổng mở | Ai được phép truy cập |
| --- | --- | --- |
| **VM 1 — Frontend** | `80`, `443` | Người dùng (công khai / mạng demo) |
| **VM 2 — Backend** | `8000` | Chỉ **VM 1** (reverse proxy `/api/*`) |
| **VM 3 — DB + Storage** | `5432` (PostgreSQL), `9000` (MinIO API) | Chỉ **VM 2** (tuyệt đối **không mở công khai** cổng CSDL và giao diện quản trị MinIO `9001`) |

- **VM 1 (Frontend) tuyệt đối không kết nối trực tiếp tới PostgreSQL trên VM 3.**
- Dữ liệu trên **VM 3** dùng Docker named volume bền vững — khởi động lại container hoặc VM không mất dữ liệu.
- Trước khi nghiệm thu, chạy thử `infra/vm3-db-storage/backup.sh` và `restore.sh` sang DB thử nghiệm để lưu minh chứng.
