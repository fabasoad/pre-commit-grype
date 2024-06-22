#!/usr/bin/env sh
set -u

SCRIPT_PATH=$(realpath "$0")
HOOKS_DIR_PATH=$(dirname "${SCRIPT_PATH}")

prefix="[pre-commit-grype]"

cleanup() {
  bin_dir="$1"
  echo "${prefix} Removing ${bin_dir} directory."
  rm -rf "${bin_dir}"
}

main() {
  res=$(${HOOKS_DIR_PATH}/util-install.sh)
  cleanup=$(echo "${res}" | cut -d ':' -f 1)
  grype_path=$(echo "${res}" | cut -d ':' -f 2)
  grype_version=$(${grype_path} --version | cut -d ' ' -f 2)
  echo "${prefix} Grype path: ${grype_path}. Grype version: ${grype_version}. Remove after complete: ${cleanup}."

  grype_args=("dir:.")
  for arg in "$@"; do
    if [ "${arg#-}" != "$arg" ]; then
      grype_args+=("$arg")
    fi
  done

  set +e
  ${grype_path} "${grype_args[*]}"
  grype_exit_code=$?
  set -e
  echo "${prefix} Grype exit code: ${grype_exit_code}"

  if [ "${cleanup}" = "true" ]; then
    cleanup "$(dirname ${grype_path})"
  fi
  exit "${grype_exit_code}"
}

main "$@"
