#!/usr/bin/env bash
# Copyright IBM Corp. 2025
# SPDX-License-Identifier: BUSL-1.1
set -euo pipefail
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"
map="docs/nist-control-mapping.md"
hcl="sentinel.hcl"
[[ -f "$map" ]] || { echo "missing $map" >&2; exit 1; }
missing=()
while IFS= read -r name; do
  [[ -z "$name" ]] && continue
  grep -qF "| \`${name}\` |" "$map" || missing+=("policy '$name' not in mapping as | \`$name\` |")
done < <(grep -E '^[[:space:]]*policy[[:space:]]+"' "$hcl" \
  | sed -E 's/^[[:space:]]*policy[[:space:]]+"([^"]+)".*/\1/')
if (( ${#missing[@]} > 0 )); then
  printf 'NIST mapping table missing policy rows:\n'; printf '  %s\n' "${missing[@]}"; exit 1
fi
for ctrl in AC-1 AT-2 IR-4 PS-3 CA-2; do
  grep -qF "| ${ctrl} |" "$map" || { echo "missing plan-only row for ${ctrl}" >&2; exit 1; }
done
echo "OK: nist-control-mapping.md is complete for sentinel.hcl policies and plan-only rows."
