# Hệ thống Quản lý Thư viện Số cho Trường Đại học

Project cuối kỳ 2026 — Học phần **Cơ sở dữ liệu Web và Hệ thống thông tin**.

## Thông tin nhóm — 120 YÊN LÃNG

| STT | Họ và tên | Mã sinh viên | GitHub | Vai trò |
| :-: | --- | :-: | --- | --- |
| 1 | Trần Quang Ngọc | 23001542 | [@ngocq6867-png](https://github.com/ngocq6867-png) | Trưởng nhóm |
| 2 | Hoàng Phi Hùng | 23001522 | [@Hoanghung1008](https://github.com/Hoanghung1008) | Thành viên |
| 3 | Lê Thái Hùng Anh | 23001494 | [@r3ijun](https://github.com/r3ijun) | Thành viên |
| 4 | Nguyễn Văn Bách | 23001499 | [@I34cH](https://github.com/I34cH) | Thành viên |

---

## Công nghệ sử dụng

- **Backend:** Python, FastAPI (`>=0.115`), Pydantic, SQLAlchemy (`>=2.0`) + `psycopg` (v3), Uvicorn
- **Frontend:** React (`18.2.0`), Vite (`7.1.7`), CSS thuần (`styles.css`)
- **Database:** PostgreSQL (schema & migration bằng SQL thuần trong `database/`)
- **Testing:** `pytest` (Backend), `node --test` (Frontend), Swagger UI (`/docs`) hoặc Postman Collections (`postman/`, *tùy chọn*)

---

## Cấu trúc thư mục

```text
.
├── backend/                     # Ứng dụng Backend (FastAPI + SQLAlchemy 2.0 + psycopg v3)
│   ├── app/
│   │   ├── main.py              # Điểm khởi chạy FastAPI, cấu hình CORS, endpoint /health
│   │   ├── core/                # Cấu hình lõi toàn hệ thống
│   │   │   ├── config.py        # Đọc biến môi trường từ backend/.env
│   │   │   └── database.py      # Tạo engine SQLAlchemy, session & hàm get_db()
│   │   ├── api/
│   │   │   └── router.py        # Gom router của tất cả module dưới prefix /api/v1
│   │   ├── shared/
│   │   │   └── schemas.py       # Pydantic schemas & tiện ích dùng chung giữa nhiều module
│   │   └── modules/             # Code nghiệp vụ — mỗi thành viên phụ trách module riêng
│   │       ├── auth/            # Đăng nhập, đăng xuất, phân quyền (SV / GV / Thủ thư / Admin)
│   │       ├── users/           # Quản lý tài khoản, hồ sơ người dùng, thẻ thư viện
│   │       ├── catalog/         # Quản lý danh mục tài liệu, khoa, ngành, tác giả, từ khóa
│   │       ├── documents/       # Tài liệu số (metadata, upload/xem/tải file PDF/ebook)
│   │       └── borrowing/       # Nghiệp vụ mượn/trả, đặt trước, lịch sử (nếu áp dụng)
│   ├── tests/                   # Kiểm thử tự động Backend bằng pytest
│   ├── requirements.txt         # Thư viện chạy ứng dụng (FastAPI, Uvicorn, SQLAlchemy, psycopg)
│   ├── requirements-dev.txt     # Thư viện phục vụ phát triển & test (pytest, httpx)
│   ├── pytest.ini               # Cấu hình đường dẫn chạy pytest
│   └── .env.example             # Mẫu biến môi trường cho Backend (copy sang backend/.env)
│
├── frontend/                    # Ứng dụng Frontend (React 18 + Vite 7 + CSS thuần)
│   ├── public/                  # File tĩnh giữ nguyên đường dẫn (favicon, ảnh logo...)
│   ├── src/
│   │   ├── main.jsx             # Điểm mount ứng dụng React vào index.html
│   │   ├── App.jsx              # Component gốc & định tuyến chính
│   │   ├── styles.css           # CSS thuần cho toàn bộ giao diện (không dùng CSS framework)
│   │   ├── core/
│   │   │   └── apiClient.js     # Hàm gọi REST API thống nhất tới Backend
│   │   ├── shared/              # Thành phần giao diện tái sử dụng ở nhiều trang
│   │   │   ├── components/      # Button, Modal, Table, SearchBar, Pagination...
│   │   │   └── layouts/         # Khung trang dùng chung (Header, Sidebar, Footer...)
│   │   └── features/            # Tách giao diện theo tính năng (tương ứng Backend modules)
│   │       ├── auth/            # Màn hình đăng nhập / đăng ký / thông tin tài khoản
│   │       ├── catalog/         # Danh sách, tìm kiếm & lọc tài liệu theo khoa/ngành
│   │       ├── reader/          # Trang xem chi tiết & đọc/tải tài liệu số
│   │       └── borrowing/       # Trang mượn/trả, theo dõi phiếu mượn
│   ├── tests/                   # Kiểm thử Frontend bằng Node.js built-in test runner (node --test)
│   ├── index.html               # File HTML gốc của Vite
│   ├── package.json             # Khai báo dependencies & scripts (dev, build, test)
│   ├── vite.config.js           # Cấu hình Vite dev server & proxy /api -> localhost:8000
│   └── .env.example             # Mẫu biến môi trường cho Frontend (copy sang frontend/.env)
│
├── database/                    # Quản lý CSDL PostgreSQL bằng SQL thuần
│   ├── README.md                # Quy ước đánh số & chạy migration SQL
│   ├── schema.sql               # Bản tổng hợp schema hiện tại để tra cứu nhanh
│   ├── migrations/              # Các file SQL tạo/sửa bảng theo thứ tự (001_init.sql, 002_...)
│   └── seeds/                   # Dữ liệu mẫu sạch (không chứa thông tin nhạy cảm) để dev/demo
│
├── docs/                        # Tài liệu thiết kế & trao đổi chung của nhóm
│   ├── architecture.md          # Mô tả kiến trúc & quy ước code Backend/Frontend
│   ├── database-erd.md          # Thiết kế CSDL, danh sách bảng và sơ đồ ERD
│   └── api-contract.md          # Danh sách API thống nhất giữa nhóm làm FE và BE
│
├── postman/                     # (Tùy chọn) Lưu file *.postman_collection.json — không bắt buộc, có thể test trực tiếp trên Swagger (/docs)
│
├── .github/                     # Cấu hình tự động hóa & mẫu chuẩn trên GitHub
│   ├── pull_request_template.md # Mẫu mô tả tự điền khi tạo Pull Request
│   ├── ISSUE_TEMPLATE/          # Mẫu tạo task tính năng (feature_task) và báo lỗi (bug_report)
│   └── workflows/ci.yml         # GitHub Actions tự chạy pytest, node --test & build khi mở PR
│
├── docker-compose.yml           # Khởi chạy PostgreSQL 16 đồng nhất trên mọi máy thành viên
├── .env.example                 # Mẫu biến môi trường cho Docker/PostgreSQL ở root
├── .gitignore                   # Danh sách file/thư mục bị Git bỏ qua (secrets, node_modules, AI config cá nhân...)
├── .editorconfig                # Thống nhất định dạng code (UTF-8, LF, indent) giữa Windows/macOS
├── CONTRIBUTING.md              # Hướng dẫn quy trình tạo branch, commit, mở PR & review code
└── README.md                    # Tài liệu giới thiệu dự án và hướng dẫn cài đặt
```

### Tóm tắt: Viết cái gì thì đặt vào đâu?

| Nhu cầu công việc | Đặt vào đâu |
| --- | --- |
| Viết API, logic xử lý, truy vấn DB cho 1 chức năng | `backend/app/modules/<ten_module>/` rồi gắn router vào `backend/app/api/router.py` |
| Viết test cho API Backend | `backend/tests/` (chạy bằng `pytest`) |
| Làm giao diện 1 màn hình/chức năng | `frontend/src/features/<ten_feature>/` |
| Tạo component UI dùng lại ở nhiều nơi | `frontend/src/shared/components/` hoặc `frontend/src/shared/layouts/` |
| Tạo hoặc chỉnh sửa bảng PostgreSQL | Thêm file mới đánh số tăng dần trong `database/migrations/` (không sửa file cũ đã merge) |
| Thêm dữ liệu mẫu để test/demo | `database/seeds/` |
| Thống nhất API hoặc sơ đồ bảng giữa FE & BE | `docs/api-contract.md` và `docs/database-erd.md` |
| Lưu file riêng trên máy (file `.xlsx`/`.docx` gốc, ghi chú, cấu hình AI cá nhân) | Thư mục `local/` hoặc các file bị `.gitignore` chặn — **không push lên Git** |

---

## Hướng dẫn cài đặt & chạy local

### 1. Clone repo và tạo file biến môi trường

```bash
git clone <url-repo>
cd <ten-thu-muc-repo>

# Copy file mẫu (tuyệt đối không commit file .env thật lên Git)
cp .env.example .env
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env
```

### 2. Chạy PostgreSQL

Cách nhanh nhất bằng Docker:

```bash
docker compose up -d
```

*(Hoặc dùng PostgreSQL cài sẵn trên máy và cập nhật `DATABASE_URL` trong `backend/.env`, sau đó chạy các file SQL trong `database/migrations/`.)*

### 3. Chạy Backend (FastAPI)

```bash
cd backend
python -m venv .venv

# Windows (PowerShell)
.\.venv\Scripts\Activate.ps1
# macOS / Linux
# source .venv/bin/activate

pip install -r requirements-dev.txt
uvicorn app.main:app --reload --port 8000
```

- API docs (Swagger): `http://localhost:8000/docs`
- Chạy test backend: `pytest`

### 4. Chạy Frontend (React + Vite)

```bash
cd frontend
npm install
npm run dev
```

- Ứng dụng chạy tại: `http://localhost:5173`
- Chạy test frontend: `npm test`

---

## Quy trình làm việc nhóm (Pull, Branch, Commit, PR)

**Không code và không push trực tiếp lên nhánh `main`.** Mỗi nhiệm vụ làm nhanh theo 5 bước:

```bash
git checkout main && git pull origin main      # 1. Lấy code mới nhất
git checkout -b feat/<ten-nhiem-vu>            # 2. Tạo nhánh riêng cho task
# ... code & chạy pytest / npm test ...
git add <files> && git commit -m "feat(...): mô tả"   # 3. Commit
git push -u origin feat/<ten-nhiem-vu>         # 4. Đẩy nhánh lên GitHub
# 5. Mở Pull Request vào main -> gắn 1 thành viên review -> CI pass & Approve -> Merge
```

Xem hướng dẫn chi tiết từng bước (cách đồng bộ code mới, xử lý conflict, cứu lỗi khi lỡ code nhầm nhánh `main`, quy ước commit và SQL migration) tại **[CONTRIBUTING.md](./CONTRIBUTING.md)**.
