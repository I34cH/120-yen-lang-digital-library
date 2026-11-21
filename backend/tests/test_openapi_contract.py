from backend.app.main import app

# Cập nhật danh sách endpoint bắt buộc khi nhóm triển khai thêm các luồng nghiệp vụ.
REQUIRED_PATHS = {
    "/health",
}


def test_required_paths_are_registered() -> None:
    paths = set(app.openapi()["paths"])
    missing = REQUIRED_PATHS - paths
    assert not missing, f"Missing API paths: {sorted(missing)}"


def test_health_method_is_registered() -> None:
    paths = app.openapi()["paths"]
    assert "get" in paths["/health"]
