#!/usr/bin/env bash
set -u

#MAIN_SCRIPT_PATH=$(realpath "$0")
#SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
#LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
#ARGS_DIR_PATH="${LIB_DIR_PATH}/args"
#INSTALLATION_DIR_PATH="${LIB_DIR_PATH}/installation"
#UTILS_DIR_PATH="${LIB_DIR_PATH}/utils"
#
#. "${ARGS_DIR_PATH}/parse-all-args.sh"
#. "${INSTALLATION_DIR_PATH}/install.sh"
#. "${INSTALLATION_DIR_PATH}/uninstall.sh"
#. "${UTILS_DIR_PATH}/logging.sh"

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

  try_uninstall "$(dirname ${grype_path})" "${to_uninstall}"
  exit "${grype_exit_code}"
}
