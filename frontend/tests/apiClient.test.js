import test from "node:test";
import assert from "node:assert/strict";
import { buildApiUrl } from "../src/core/apiClient.js";

test("buildApiUrl joins base URL and path without double slashes", () => {
  assert.equal(
    buildApiUrl("/api/v1/documents", "http://localhost:8000/"),
    "http://localhost:8000/api/v1/documents"
  );
  assert.equal(buildApiUrl("health", ""), "/health");
});
