#!/usr/bin/env sh
set -eu

bin_dir="$(pwd)/.pre-commit/pre-commit-grype"
if [ -d "${bin_dir}" ] && [ -f "${bin_dir}/grype" ]; then
  grype --version
  exit 0
fi

curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b "${bin_dir}"
