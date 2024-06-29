#!/usr/bin/env bash
set -u

grype_common() {
  grype_args="$@ --exclude=${CONFIG_TEMP_DIR}"

  grype_path=$(install)
  grype_version=$(${grype_path} --version | cut -d ' ' -f 2)
  log_info "Grype path: ${grype_path}"
  log_info "Grype version: ${grype_version}"
  log_info "Grype arguments: ${grype_args}"

  set +e
  ${grype_path} ${grype_args}
  grype_exit_code=$?
  set -e
  msg="Grype exit code: ${grype_exit_code}"
  if [ "${grype_exit_code}" = "0" ]; then
    log_info "${msg}"
  else
    log_warning "${msg}"
  fi

  uninstall "${CONFIG_TEMP_DIR}"
  exit "${grype_exit_code}"
}
