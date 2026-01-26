#!/usr/bin/env sh

TESTS_DIR=$(dirname "$(realpath "$0")")
ROOT_DIR=$(dirname "${TESTS_DIR}")
SRC_DIR="${ROOT_DIR}/src"

test_grype_version_param_precedence() {
  command="${1}"
  grype_version_cmd="${2}"
  grype_version_env_var="${3}"
  version_expected="${4}"

  test_name="${FUNCNAME:-${0##*/}}: $@"

  if command -v grype &> /dev/null; then
    echo "[SKIP] ${test_name} - grype installed globally"
  else
    output=$(PRE_COMMIT_GRYPE_GRYPE_VERSION="${grype_version_env_var}" \
      "${SRC_DIR}/main.sh" "${command}" \
      "--grype-args=--quiet --hook-args=--log-level=info --grype-version=${grype_version_cmd}" \
      2>&1 >/dev/null)

    version_actual=$(echo "${output}" | grep 'Grype version:' | sed 's/.*Grype version: \([0-9.]*\).*/\1/')
    if [ "${version_actual}" != "${version_expected}" ]; then
      echo "[FAIL] ${test_name} - Expected: ${version_expected}. Actual: ${version_actual}"
      printf "\n%s" "${output}"
      exit 1
    fi

    echo "[PASS] ${test_name}"
  fi
}

test_grype_version_env_var() {
  command="${1}"
  grype_version_env_var="${2}"
  version_expected="${grype_version_env_var}"

  test_name="${FUNCNAME:-${0##*/}}: $@"

  if command -v grype &> /dev/null; then
    echo "[SKIP] ${test_name} - grype installed globally"
  else
    output=$(PRE_COMMIT_GRYPE_GRYPE_VERSION="${grype_version_env_var}" \
      "${SRC_DIR}/main.sh" "${command}" \
      "--grype-args=--quiet --hook-args=--log-level=info" \
      2>&1 >/dev/null)

    version_actual=$(echo "${output}" | grep 'Grype version:' | sed 's/.*Grype version: \([0-9.]*\).*/\1/')
    if [ "${version_actual}" != "${version_expected}" ]; then
      echo "[FAIL] ${test_name} - Expected: ${version_expected}. Actual: ${version_actual}"
      printf "\n%s" "${output}"
      exit 1
    fi

    echo "[PASS] ${test_name}"
  fi
}

main() {
  printf "\nTesting %s...\n" "$(basename "$0")"
  test_grype_version_param_precedence "grype-dir" "0.79.2" "0.79.3" "0.79.2"
  test_grype_version_param_precedence "grype-dir" "0.79.3" "0.79.2" "0.79.3"
  test_grype_version_env_var "grype-dir" "0.79.2"
  printf "[PASS] Total 3 tests passed\n"
}

main "$@"
