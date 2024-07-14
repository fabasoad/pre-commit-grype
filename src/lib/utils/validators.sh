#!/usr/bin/env sh

validate_enum() {
  set +e
  err_msg=$(fabasoad_validate_enum $@ 2>&1 >/dev/null)
  exit_code=$?
  if [ "${exit_code}" -ne 0 ]; then
    fabasoad_log "error" "${err_msg}"
    exit ${exit_code}
  fi
  set -e
}
