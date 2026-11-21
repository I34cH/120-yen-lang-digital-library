# Hướng dẫn làm việc nhóm trên Git & GitHub

Tài liệu này hướng dẫn từng bước cách **clone, pull code, tạo branch, commit, mở Pull Request (PR) và review** cho 4 thành viên nhóm **120 YÊN LÃNG** để tránh ghi đè code nhau và giữ nhánh `main` luôn chạy ổn định.

---

## 1. Thiết lập lần đầu (chỉ làm 1 lần trên mỗi máy)

```bash
# 1. Clone repo về máy
git clone <url-repo>
cd <ten-thu-muc-repo>

# 2. Cấu hình tên & email Git (trùng với tài khoản GitHub của bạn)
git config user.name "Ten Cua Ban"
git config user.email "email-github@example.com"

# 3. Tạo file .env local từ file mẫu (KHÔNG commit file .env)
cp .env.example .env
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env
```

---

## 2. Quy tắc đặt tên nhánh (Branching)

- **`main`**: Nhánh chính, luôn chạy được để demo/nộp bài. **Tuyệt đối không code/push trực tiếp lên `main`**.
- **Nhánh nhiệm vụ**: Mỗi nhiệm vụ tạo **1 nhánh riêng** từ `main` theo mẫu:
  - `feat/<ten-tinh-nang>` — tính năng mới (VD: `feat/auth-login`, `feat/catalog-search`)
  - `fix/<ten-loi>` — sửa lỗi (VD: `fix/pdf-download-header`)
  - `db/<ten-thay-doi>` — thêm migration/seed SQL (VD: `db/add-books-table`)
  - `docs/<ten-tai-lieu>` — cập nhật tài liệu, Postman collection (VD: `docs/api-contract-v1`)
  - `chore/<ten-viec>` — cấu hình dự án, CI, dependency (VD: `chore/update-gitignore`)

---

## 3. Quy trình 6 bước cho mỗi nhiệm vụ

### Bước 1: Chuyển về `main` và kéo code mới nhất về máy
```bash
git checkout main
git pull origin main
```

### Bước 2: Tạo nhánh riêng cho nhiệm vụ của bạn
```bash
git checkout -b feat/catalog-search
```
*(Kiểm tra xem đã đúng nhánh chưa bằng `git branch` — dấu `*` phải nằm ở nhánh mới tạo.)*

### Bước 3: Code, chạy thử & chạy test
- Sửa/viết code trong đúng module được giao (`backend/app/modules/...`, `frontend/src/features/...`, `database/migrations/...`).
- Chạy test trước khi commit:
  - Backend: `cd backend && pytest`
  - Frontend: `cd frontend && npm test`

### Bước 4: Kiểm tra file thay đổi & Commit
```bash
# Xem những file nào đã thay đổi (kiểm tra kỹ để không add nhầm file rác)
git status

# Stage file muốn commit
git add backend/app/modules/catalog backend/tests/test_catalog.py

# Commit theo quy ước
git commit -m "feat(catalog): add search endpoint by title and faculty"
```

### Bước 5: Push nhánh lên GitHub
```bash
# Lần đầu push nhánh này
git push -u origin feat/catalog-search

# Những lần push tiếp theo trên cùng nhánh chỉ cần:
git push
```

### Bước 6: Tạo Pull Request (PR), Review & Merge
1. Vào GitHub → bấm **Compare & pull request** (từ nhánh của bạn → `main`).
2. Điền đầy đủ nội dung theo mẫu PR (mô tả đã làm gì, gắn `Closes #<số-issue>` nếu có, ảnh chụp nếu sửa UI).
3. Ở cột **Reviewers** bên phải, gắn ít nhất **1 thành viên khác** trong nhóm để review.
   - **Quy định bắt buộc của môn học (Mục IV.2):** Người review **phải mở tab `Files changed`**, nêu nhận xét kỹ thuật hoặc ghi rõ kết quả đã chạy thử (API/UI/SQL) — **không chỉ ghi `"OK"`** rồi bấm Approve.
4. Nếu người review góp ý cần sửa: cứ sửa code ngay trên nhánh cũ, `git commit` rồi `git push` — **PR sẽ tự động cập nhật**, không cần mở PR mới.
5. Khi GitHub Actions CI báo xanh (`backend`, `frontend`, `docker`) và đã có **Approve** → bấm **Squash and merge** (hoặc **Merge pull request**) → bấm **Delete branch** trên GitHub.
6. Dọn nhánh cũ ở máy local để chuẩn bị làm task mới:
   ```bash
   git checkout main
   git pull origin main
   git branch -d feat/catalog-search
   ```

---

## 4. Đồng bộ code mới khi đang làm dở (tránh Merge Conflict)

Nếu bạn đang làm trên nhánh `feat/catalog-search` được vài ngày và trong lúc đó bạn khác đã merge code mới lên `main`, hãy kéo `main` vào nhánh của bạn:

```bash
git fetch origin
git merge origin/main
```

- Nếu không có xung đột → chạy lại test rồi `git push`.
- Nếu Git báo **CONFLICT**: mở các file bị đánh dấu `<<<<<<<`, chọn giữ lại phần code đúng (hỏi lại người viết phần kia nếu chưa rõ), sau đó:
  ```bash
  git add <file-da-sua-conflict>
  git commit -m "chore: resolve merge conflict with main"
  git push
  ```

---

## 5. Xử lý nhanh tình huống hay gặp

- **Lỡ code nhầm trên nhánh `main` (chưa commit):**
  ```bash
  # Tạo nhánh mới ngay — toàn bộ thay đổi chưa commit sẽ đi theo sang nhánh mới
  git checkout -b feat/ten-nhiem-vu
  ```
- **Kiểm tra mình đang đứng ở nhánh nào & trạng thái file:**
  ```bash
  git branch
  git status
  ```
- **Chuyển sang làm thử nhánh của thành viên khác để review/test:**
  ```bash
  git fetch origin
  git checkout <ten-nhanh-cua-ban-khac>
  git pull
  ```

---

## 6. Quy ước Commit Message

Theo chuẩn Conventional Commits: `<type>(<scope>): <mô tả ngắn gọn>`

- `feat(auth): add jwt login endpoint`
- `fix(reader): handle missing pdf url`
- `db(migrations): add 002_create_documents.sql`
- `test(catalog): add unit tests for search filter`
- `docs(readme): update local setup steps`
- `chore(deps): add python-multipart to requirements`

---

## 7. File KHÔNG được commit & Quy tắc Database Migration

### File KHÔNG được push lên Git
`.gitignore` đã tự động chặn — tuyệt đối không dùng `git add -f`:
- File bí mật: `.env`, `.env.local`, mật khẩu DB, API key.
- Thư mục cài đặt/build: `node_modules/`, `.venv/`, `__pycache__/`, `dist/`.
- Cấu hình AI cá nhân trên từng máy: `.ai/`, `.claude/`, `.agent/`, `.cursor/`, `AGENTS.md`, `CLAUDE.md`...
- File nháp/dữ liệu riêng cá nhân: đặt vào thư mục `local/` hoặc `scratch/` (đã được ignore sẵn).

### Quy tắc với Database SQL Migration (`database/migrations/`)
- Đánh số tăng dần: `001_init.sql`, `002_create_users.sql`, `003_create_documents.sql`...
- **Không sửa file migration đã merge lên `main`** — nếu cần chỉnh bảng, tạo file migration mới với số tiếp theo.
- Thông báo trong nhóm khi có migration mới để mọi người chạy đồng bộ trên DB local.
