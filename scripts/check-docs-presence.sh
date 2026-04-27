#!/usr/bin/env bash
# Copyright IBM Corp. 2025
# SPDX-License-Identifier: BUSL-1.1
set -euo pipefail
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"
hcl="sentinel.hcl"
[[ -f "$hcl" ]] || { echo "sentinel.hcl not found" >&2; exit 1; }
missing=()
while IFS= read -r name; do
  [[ -z "$name" ]] && continue
  doc="docs/policies/${name}.md"
  [[ -f "$doc" ]] || missing+=("policy '$name' -> expected $doc")
done < <(grep -E '^[[:space:]]*policy[[:space:]]+"' "$hcl" \
  | sed -E 's/^[[:space:]]*policy[[:space:]]+"([^"]+)".*/\1/')
if (( ${#missing[@]} > 0 )); then
  printf 'Missing per-policy documentation:\n'; printf '  %s\n' "${missing[@]}"; exit 1
fi
echo "OK: every sentinel.hcl policy has a matching doc under docs/policies/."
