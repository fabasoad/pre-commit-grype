#!/usr/bin/env sh

TESTS_DIR=$(dirname $(realpath "$0"))
ROOT_DIR=$(dirname "${TESTS_DIR}")

test_log_level() {
  command="$1"
  log_level_cmd="$2"
  log_level_env_var="$3"
  debug_expected="$4"

  test_name="test_log_level: ${command}, ${log_level_cmd}, ${log_level_env_var}, ${debug_expected}"

  output=$(PRE_COMMIT_GRYPE_LOG_LEVEL="${log_level_env_var}" \
    ${ROOT_DIR}/entrypoint.sh "${command}" \
    "--hook-args=--log-level=${log_level_cmd}" \
    2>&1 >/dev/null)

  actual=$(echo "${output}" | grep "debug")
  if [ -z "${actual}" ] && [ "${debug_expected}" = "true" ]; then
    echo "[FAIL] ${test_name} - debug logs are expected to be present"
    echo "\n${output}"
    exit 1
  elif [ -n "${actual}" ] && [ "${debug_expected}" = "false" ]; then
    echo "[FAIL] ${test_name} - debug logs are not expected to be present"
    echo "\n${output}"
    exit 1
  fi

  echo "[PASS] ${test_name}"
}

main() {
  test_log_level "grype-dir" "info" "debug" "false"
  test_log_level "grype-dir" "debug" "info" "true"

  printf "=%.0s" {1..45}
  printf "\n[PASS] test-log-level.sh - total 2 tests passed\n"
}

main "$@"
