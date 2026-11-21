const DEFAULT_BASE_URL = (
  import.meta.env?.VITE_API_BASE_URL || "http://127.0.0.1:8000"
).replace(/\/+$/, "");

export function buildApiUrl(path, baseUrl = DEFAULT_BASE_URL) {
  const normalizedBase = baseUrl.replace(/\/+$/, "");
  const normalizedPath = path.startsWith("/") ? path : `/${path}`;
  return `${normalizedBase}${normalizedPath}`;
}

export async function apiRequest(path, { method = "GET", body, signal, headers = {} } = {}) {
  const url = buildApiUrl(path);
  let response;
  try {
    response = await fetch(url, {
      method,
      signal,
      headers:
        body === undefined
          ? headers
          : { "Content-Type": "application/json", ...headers },
      body: body === undefined ? undefined : JSON.stringify(body),
    });
  } catch (error) {
    if (error.name === "AbortError") throw error;
    throw new Error("Không nhận được phản hồi API. Kiểm tra Backend/CORS và thử lại.");
  }

  if (response.status === 204) return null;

  const raw = await response.text();
  let data;
  try {
    data = raw ? JSON.parse(raw) : null;
  } catch {
    throw new Error(`HTTP ${response.status}: phản hồi không phải JSON.`);
  }

  if (!response.ok) {
    const detail = data?.detail;
    const message = Array.isArray(detail)
      ? detail.map((item) => item.msg).join("; ")
      : typeof detail === "string"
        ? detail
        : "Yêu cầu không thành công.";
    const error = new Error(`HTTP ${response.status}: ${message}`);
    error.status = response.status;
    throw error;
  }

  return data;
}
