#!/usr/bin/env bash
# Exit non-zero if any tracked file exceeds 1MB
set -euo pipefail
max=$((1*1024*1024))
found=0
while IFS= read -r -d '' file; do
  size=$(wc -c <"$file")
  if [ "$size" -gt "$max" ]; then
    echo "LARGE FILE: $file ($size bytes)"
    found=1
  fi
done < <(git ls-files -z)
if [ "$found" -ne 0 ]; then
  echo "One or more tracked files exceed 1MB. Consider optimizing or using LFS."
  exit 2
fi
exit 0
