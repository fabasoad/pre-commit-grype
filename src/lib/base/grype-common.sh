#!/usr/bin/env sh
set -u

grype_common() {
  # Removing trailing space (sed command) is needed here in case there were no
  # --grype-args passed, so that $1 in this case is "dir:. "
  grype_args="$(echo "$1" | sed 's/ *$//') --exclude=**/${CONFIG_TEMP_DIR_NAME}"

  grype_path=$(install)
  grype_version=$(${grype_path} --version | cut -d ' ' -f 2)
  fabasoad_log "info" "Grype path: ${grype_path}"
  fabasoad_log "info" "Grype version: ${grype_version}"
  fabasoad_log "info" "Grype arguments: ${grype_args}"

  fabasoad_log "debug" "Run Grype scanning:"
  set +e
  ${grype_path} ${grype_args}
  grype_exit_code=$?
  set -e
  fabasoad_log "debug" "Grype scanning completed"
  msg="Grype exit code: ${grype_exit_code}"
  if [ "${grype_exit_code}" = "0" ]; then
    fabasoad_log "info" "${msg}"
  else
    fabasoad_log "warning" "${msg}"
  fi

  uninstall "${CONFIG_TEMP_DIR}"
  exit ${grype_exit_code}
}
