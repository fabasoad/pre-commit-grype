#!/usr/bin/env bash
set -u

grype_common() {
  grype_args="$@"

  res=$(install)
  to_uninstall=$(echo "${res}" | cut -d ':' -f 1)
  grype_path=$(echo "${res}" | cut -d ':' -f 2)
  grype_version=$(${grype_path} --version | cut -d ' ' -f 2)
  log_info "Grype path: ${grype_path}"
  log_info "Grype version: ${grype_version}"
  log_info "Grype will$([[ "${to_uninstall}" = "true" ]] && echo "" || echo " not") be uninstalled after scanning completed"
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

  try_uninstall "${CONFIG_TEMP_DIR}" "${to_uninstall}"
  exit "${grype_exit_code}"
}
