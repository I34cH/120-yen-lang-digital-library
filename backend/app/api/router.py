from fastapi import APIRouter

api_router = APIRouter(prefix="/api/v1")

# Đăng ký router của từng module tại đây khi phát triển:
# from app.modules.auth.router import router as auth_router
# api_router.include_router(auth_router)
