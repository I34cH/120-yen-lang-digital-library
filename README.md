# Hệ thống Quản lý Thư viện Số cho Trường Đại học

Project cuối kỳ 2026 — Học phần **Cơ sở dữ liệu Web và Hệ thống thông tin** (Ngành Khoa học dữ liệu).

## Thông tin nhóm & Bảng phân công — 120 YÊN LÃNG

> Theo yêu cầu học phần (Mục II.3), bảng phân công ghi rõ người thực hiện, người kiểm tra chéo, sản phẩm bàn giao và liên kết minh chứng (cập nhật khi phân công thay đổi).

| Họ tên / GitHub | MSSV | Vai trò | Hạng mục phụ trách | Người kiểm tra | Sản phẩm bàn giao | Minh chứng |
| --- | :-: | --- | --- | --- | --- | --- |
| Trần Quang Ngọc ([@ngocq6867-png](https://github.com/ngocq6867-png)) | 23001542 | **Trưởng nhóm** (Release/Integration Owner); Backend | Điều phối yêu cầu, quản lý tích hợp & phát hành 3 VM, Backend nghiệp vụ | *(cập nhật theo Issue/PR)* | Bản release, tag, API & tài liệu chốt nộp | *(link PR/Release)* |
| Hoàng Phi Hùng ([@Hoanghung1008](https://github.com/Hoanghung1008)) | 23001522 | CSDL; Backend | Thiết kế ERD, schema/migration, dữ liệu lớn, truy vấn/index & Backend dữ liệu | *(cập nhật theo Issue/PR)* | `database/`, ERD, kết quả EXPLAIN & API | *(link PR/Issue)* |
| Lê Thái Hùng Anh ([@r3ijun](https://github.com/r3ijun)) | 23001494 | Frontend người dùng; Thiết kế UI | Phác giao diện Figma, màn hình tra cứu/đọc/mượn cho sinh viên & giảng viên | *(cập nhật theo Issue/PR)* | Figma, `frontend/src/features/` & test UI | *(link PR/Issue)* |
| Nguyễn Văn Bách ([@I34cH](https://github.com/I34cH)) | 23001499 | Frontend quản trị/thống kê; Kiểm thử; Hạ tầng | Màn hình quản trị/báo cáo, kiểm thử chéo, Docker & cấu hình hạ tầng 3 VM | *(cập nhật theo Issue/PR)* | `infra/`, CI/CD, màn hình thống kê & báo cáo test | *(link PR/Issue)* |

---

## Công nghệ sử dụng

- **Backend:** Python 3.12, FastAPI (`>=0.115,<1`), Pydantic, SQLAlchemy (`>=2.0,<3`) + `psycopg` (v3), Uvicorn
- **Frontend:** JavaScript + JSX *(không dùng TypeScript)*, React (`18.2.0`), Vite (`7.1.7`), CSS thuần (`styles.css`), Node.js (`>=22.12.0`)
- **Database & Storage:** PostgreSQL 16 (schema, migration & index bằng SQL thuần trong `database/`), MinIO Object Storage (lưu file tài liệu số trên VM 3)
- **Đóng gói & Triển khai:** Docker, Docker Compose (`compose.yaml` local & `infra/` cho kiến trúc 03 VM bắt buộc), Nginx reverse proxy
- **Kiểm thử & CI:** `pytest` (Backend), `node --test` (Frontend), GitHub Actions CI (`backend`, `frontend`, `docker`), Swagger UI (`/docs`), Postman (`postman/`, *tùy chọn*)

---

## Cấu trúc thư mục

```text
.
├── backend/                         # Ứng dụng Backend (FastAPI + SQLAlchemy 2.0 + psycopg v3)
│   ├── app/
│   │   ├── main.py                  # Điểm khởi chạy FastAPI, CORS, endpoint /health
│   │   ├── core/                    # Cấu hình lõi toàn hệ thống
│   │   │   ├── config.py            # Đọc biến môi trường từ backend/.env
│   │   │   └── database.py          # Engine SQLAlchemy, session & hàm get_db()
│   │   ├── api/
│   │   │   └── router.py            # Gom router các module dưới prefix /api/v1
│   │   ├── shared/
│   │   │   └── schemas.py           # Pydantic schemas dùng chung
│   │   └── modules/                 # Code nghiệp vụ — chia theo chức năng để tránh conflict
│   │       ├── auth/                # Đăng nhập, đăng xuất, phân quyền (Độc giả / Thủ thư / Admin)
│   │       ├── users/               # Quản lý tài khoản, hồ sơ người dùng, thẻ thư viện
│   │       ├── catalog/             # Danh mục tài liệu, khoa, ngành, tác giả, từ khóa
│   │       ├── documents/           # Tài liệu số (metadata, upload/xem/tải PDF trên Storage)
│   │       └── borrowing/           # Mượn/trả, đặt trước, xử lý đồng thời (SELECT ... FOR UPDATE)
│   ├── tests/                       # Kiểm thử Backend (pytest: health, OpenAPI contract, concurrency)
│   ├── Dockerfile                   # Đóng gói image Backend FastAPI
│   ├── requirements.txt             # Thư viện chạy ứng dụng
│   ├── requirements-dev.txt         # Thư viện phát triển & kiểm thử (pytest, httpx)
│   ├── .env.example                 # Mẫu biến môi trường chạy local (copy sang backend/.env)
│   └── .env.docker.example          # Mẫu biến môi trường chạy Docker Compose (copy sang backend/.env.docker)
│
├── frontend/                        # Ứng dụng Frontend (React 18.2.0 + Vite 7.1.7 + CSS thuần)
│   ├── public/                      # File tĩnh (favicon, ảnh logo...)
│   ├── src/
│   │   ├── main.jsx                 # Điểm mount React vào index.html
│   │   ├── App.jsx                  # Component gốc & định tuyến chính
│   │   ├── styles.css               # CSS thuần toàn giao diện
│   │   ├── core/
│   │   │   └── apiClient.js         # Hàm gọi REST API (xử lý JSON, 204, lỗi 4xx/422)
│   │   ├── shared/                  # Thành phần UI tái sử dụng (components/, layouts/)
│   │   └── features/                # Tách giao diện theo tính năng (auth, catalog, reader, borrowing)
│   ├── tests/                       # Kiểm thử Frontend bằng node --test
│   ├── Dockerfile                   # Multi-stage build (Node 22 -> Nginx)
│   ├── nginx.conf                   # Reverse proxy /api/ -> backend:8000/ cho bản Docker local
│   ├── package.json                 # Dependencies & scripts (dev, build, preview, test)
│   ├── package-lock.json            # Lockfile để cài đồng nhất bằng npm ci
│   ├── vite.config.js               # Cấu hình Vite (esbuild JSX automatic)
│   └── .env.example                 # Mẫu biến môi trường (copy sang frontend/.env.local)
│
├── database/                        # Quản lý PostgreSQL bằng SQL thuần
│   ├── README.md                    # Quy ước migration & schema_migrations
│   ├── schema.sql                   # Bản tổng hợp schema hiện tại để tra cứu
│   ├── migrations/                  # Các file SQL tăng dần + file rollback (001_init.sql, ...)
│   ├── seeds/                       # Bộ dữ liệu demo gọn (không chứa dữ liệu cá nhân thật)
│   └── scripts/                     # Script sinh dữ liệu lớn (10k/100k dòng) & đo EXPLAIN (ANALYZE, BUFFERS)
│
├── infra/                           # Hạ tầng triển khai bắt buộc 03 Máy ảo (3 VM — Mục V)
│   ├── README.md                    # Sơ đồ mạng 3 VM & quy tắc tường lửa/bảo mật
│   ├── vm1-frontend/                # Compose + nginx.conf.example chạy trên VM 1 (Frontend)
│   ├── vm2-backend/                 # Compose + .env.example chạy trên VM 2 (Backend)
│   └── vm3-db-storage/              # Compose (PostgreSQL + MinIO) + backup.sh / restore.sh trên VM 3
│
├── docs/                            # Tài liệu thiết kế, ERD, API contract & minh chứng kiểm thử
├── postman/                         # (Tùy chọn) Postman collections — không bắt buộc, có thể test trên /docs
├── report/                          # Mã nguồn LaTeX & PDF báo cáo cuối kỳ (điểm cộng +0,5)
├── .github/                         # Template PR/Issue & GitHub Actions CI (backend, frontend, docker)
├── AI_USAGE.md                      # Nhật ký phạm vi sử dụng AI & cách kiểm chứng (Mục VIII)
├── compose.yaml                     # Docker Compose chạy cục bộ trên 1 máy (chuẩn Buổi 6)
├── pytest.ini                       # Cấu hình pytest từ thư mục gốc
├── .dockerignore                    # Loại bỏ .env, .venv, node_modules khỏi Docker build context
├── .gitignore                       # Chặn secrets, file cá nhân (local/) và cấu hình AI riêng từng máy
├── .editorconfig                    # Thống nhất UTF-8, LF, indent giữa Windows/macOS
├── CONTRIBUTING.md                  # Hướng dẫn pull, tạo branch, commit, PR & review cho 4 thành viên
└── README.md                        # Tài liệu tổng quan & hướng dẫn cài đặt
```

### Tóm tắt: Viết cái gì thì đặt vào đâu?

| Nhu cầu công việc | Đặt vào đâu |
| --- | --- |
| Viết API, logic, phân quyền, transaction Backend | `backend/app/modules/<ten_module>/` rồi gắn vào `backend/app/api/router.py` |
| Viết test Backend (pytest / contract / concurrency) | `backend/tests/` |
| Làm giao diện 1 màn hình/chức năng | `frontend/src/features/<ten_feature>/` |
| Tạo component UI dùng lại ở nhiều nơi | `frontend/src/shared/components/` hoặc `frontend/src/shared/layouts/` |
| Tạo/sửa bảng PostgreSQL (có quản lý phiên bản) | Thêm file mới + file rollback trong `database/migrations/` (không sửa file cũ đã merge) |
| Viết script sinh dữ liệu 10k/100k dòng & đo `EXPLAIN` | `database/scripts/` (không commit file `.dump` lớn) |
| Cấu hình triển khai 3 VM, backup/restore | `infra/vm1-frontend/`, `infra/vm2-backend/`, `infra/vm3-db-storage/` |
| Lưu file riêng trên máy (`.xlsx`/`.docx` gốc, ghi chú, cấu hình AI cá nhân) | Thư mục `local/` hoặc file trong `.gitignore` — **không push lên Git** |

---

## Hướng dẫn cài đặt & chạy local

### 1. Clone repo và tạo file biến môi trường

```bash
git clone https://github.com/I34cH/120-yen-lang-digital-library.git
cd 120-yen-lang-digital-library

# Copy file mẫu (tuyệt đối không commit file .env / .env.local / .env.docker)
cp .env.example .env
cp backend/.env.example backend/.env
cp backend/.env.docker.example backend/.env.docker
cp frontend/.env.example frontend/.env.local
```

### 2. Chạy phát triển cục bộ (không cần Docker cho FE/BE)

- **PostgreSQL:** Dùng PostgreSQL cài sẵn trên máy, hoặc bật nhanh bằng Docker:
  ```bash
  docker compose --profile with-db up -d postgres
  ```
- **Terminal 1 — Backend (chạy từ thư mục gốc repo):**
  ```bash
  python -m venv .venv
  # Windows PowerShell: .\.venv\Scripts\Activate.ps1
  # macOS / Linux:      source .venv/bin/activate

  python -m pip install -r backend/requirements-dev.txt
  python -m uvicorn backend.app.main:app --reload
  ```
  - Swagger UI: `http://127.0.0.1:8000/docs`
  - Chạy test Backend: `python -m pytest backend/tests -q`

- **Terminal 2 — Frontend:**
  ```bash
  cd frontend
  npm ci
  npm run dev
  ```
  - Giao diện chạy tại: `http://127.0.0.1:5173`
  - Chạy test Frontend: `npm test`

### 3. Chạy đóng gói bằng Docker Compose (chuẩn Buổi 6)

```bash
docker compose up --build
```

- Giao diện qua Nginx: `http://127.0.0.1:8080` (reverse proxy `/api/*` → `backend:8000`)
- API trực tiếp để kiểm tra `/docs`: `http://127.0.0.1:8000/docs`
- Triển khai kiến trúc **03 VM bắt buộc**: xem hướng dẫn tại [infra/README.md](./infra/README.md).

---

## Quy trình làm việc nhóm (Pull, Branch, Commit, PR)

**Không code và không push trực tiếp lên nhánh `main`.** Mỗi nhiệm vụ làm theo 5 bước:

```bash
git checkout main && git pull origin main             # 1. Lấy code mới nhất
git checkout -b feat/<ten-nhiem-vu>                   # 2. Tạo nhánh riêng cho task
# ... code & chạy pytest / npm test ...
git add <files> && git commit -m "feat(...): mô tả"   # 3. Commit
git push -u origin feat/<ten-nhiem-vu>                # 4. Đẩy nhánh lên GitHub
# 5. Mở Pull Request vào main -> 1 bạn review (ghi nhận xét kỹ thuật, không chỉ "OK") -> CI pass -> Merge
```

Xem hướng dẫn chi tiết từng bước tại **[CONTRIBUTING.md](./CONTRIBUTING.md)**.
