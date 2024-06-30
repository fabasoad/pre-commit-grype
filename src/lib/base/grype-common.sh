#!/usr/bin/env sh
set -u

grype_common() {
  # Removing trailing space (sed command) is needed here in case there were no
  # --grype-args passed, so that $1 in this case is "dir:. "
  grype_args="$(echo "$1" | sed 's/ *$//') --exclude=**/${CONFIG_TEMP_DIR_NAME}"

  grype_path=$(install)
  grype_version=$(${grype_path} --version | cut -d ' ' -f 2)
  log_info "Grype path: ${grype_path}"
  log_info "Grype version: ${grype_version}"
  log_info "Grype arguments: ${grype_args}"

  log_debug "Run Grype scanning:"
  set +e
  ${grype_path} ${grype_args}
  grype_exit_code=$?
  set -e
  log_debug "Grype scanning completed"
  msg="Grype exit code: ${grype_exit_code}"
  if [ "${grype_exit_code}" = "0" ]; then
    log_info "${msg}"
  else
    log_warning "${msg}"
  fi

  uninstall "${CONFIG_TEMP_DIR}"
  exit ${grype_exit_code}
}
