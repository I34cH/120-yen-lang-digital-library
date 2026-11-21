# Database Scripts (Demo, Dữ liệu lớn 10k/100k & Đo hiệu năng)

Theo yêu cầu Project cuối kỳ (Mục III):
- **Không commit file SQL dump lớn lên repository.**
- Đặt các script tái tạo dữ liệu tại đây:
  - Script sinh bộ **dữ liệu lớn** (tối thiểu 3 bảng nghiệp vụ `>= 10.000` dòng, ít nhất 1 bảng `>= 100.000` dòng).
  - Script chạy **8 truy vấn nghiệp vụ** và **EXPLAIN (ANALYZE, BUFFERS)** trước/sau khi tạo 2 chỉ mục (Index).
  - Script truy vấn thống kê số dòng từng bảng để lấy minh chứng nộp bài.
