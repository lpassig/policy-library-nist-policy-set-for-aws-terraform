#!/usr/bin/env bash
# Copyright IBM Corp. 2025
# SPDX-License-Identifier: BUSL-1.1
set -euo pipefail
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"
hcl="sentinel.hcl"
[[ -f "$hcl" ]] || { echo "sentinel.hcl not found" >&2; exit 1; }
missing=()
while IFS= read -r rel; do
  [[ -z "$rel" ]] && continue
  [[ -f "$rel" ]] || missing+=("$rel")
done < <(grep -E '^[[:space:]]*source[[:space:]]*=[[:space:]]*"\./' "$hcl" \
  | sed -E 's/^[[:space:]]*source[[:space:]]*=[[:space:]]*"(\.\/[^"]+)".*/\1/')
if (( ${#missing[@]} > 0 )); then
  printf 'sentinel.hcl references files that do not exist:\n'; printf '  %s\n' "${missing[@]}"; exit 1
fi
echo "OK: every source path referenced by sentinel.hcl exists."
