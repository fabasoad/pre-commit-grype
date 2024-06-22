#!/usr/bin/env sh
# shellcheck disable=SC2039,SC3020
set -eu

cleanup="false"
if command -v grype &> /dev/null; then
  grype_path="$(which grype)"
else
  cleanup="true"
  bin_dir="$(pwd)/.pre-commit-grype"
  mkdir -p "${bin_dir}"
  if [ ! -d "${bin_dir}" ] || [ ! -f "${bin_dir}/grype" ]; then
    curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b "${bin_dir}"
  fi
  grype_path="${bin_dir}/grype"
fi
echo "${cleanup}:${grype_path}"
