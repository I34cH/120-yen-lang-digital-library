import { useEffect, useState } from "react";
import { apiRequest } from "./core/apiClient.js";

export default function App() {
  const [apiStatus, setApiStatus] = useState("checking");

  useEffect(() => {
    apiRequest("/health")
      .then((data) => setApiStatus(data.status || "ok"))
      .catch(() => setApiStatus("offline"));
  }, []);

  return (
    <main className="container">
      <header className="hero">
        <h1>Hệ thống Quản lý Thư viện Số</h1>
        <p>Nhóm 120 YÊN LÃNG — Cơ sở dữ liệu Web và Hệ thống thông tin</p>
        <span className={`status-badge status-${apiStatus}`}>
          Backend API: {apiStatus}
        </span>
      </header>
    </main>
  );
}
