import test from "node:test";
import assert from "node:assert/strict";
import { buildApiUrl } from "../src/core/apiClient.js";

test("buildApiUrl joins base URL and path without double slashes", () => {
  assert.equal(
    buildApiUrl("/api/v1/documents", "http://127.0.0.1:8000/"),
    "http://127.0.0.1:8000/api/v1/documents"
  );
  assert.equal(buildApiUrl("health", "/api"), "/api/health");
  assert.equal(buildApiUrl("health", ""), "/health");
});
