#!/usr/bin/env sh

export PREFIX="$(pwd)/src/.bpkg"

main() {
  mkdir -p "${PREFIX}"
  lock_file="./.bpkg.lock"
  while IFS= read -r line; do
    bpkg install "$line"
  done < "${lock_file}"
}

main "$@"
