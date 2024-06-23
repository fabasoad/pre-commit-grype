#!/usr/bin/env bash
set -u

SCRIPT_PATH=$(realpath "$0")
HOOKS_DIR_PATH=$(dirname "${SCRIPT_PATH}")
SRC_DIR_PATH=$(dirname "${HOOKS_DIR_PATH}")
UTILS_DIR_PATH="${SRC_DIR_PATH}/utils"

. "${UTILS_DIR_PATH}/install.sh"
. "${UTILS_DIR_PATH}/logging.sh"
. "${UTILS_DIR_PATH}/parse-args.sh"
. "${UTILS_DIR_PATH}/uninstall.sh"

main() {
  declare -A args_map

  grype_args="dir:. $(parse_args_grype "$@")"
  hook_args=$(parse_args_hook "$@")
  unknown_args=$(parse_args_unknown "$@")

  if [ "${unknown_args}" != "" ]; then
    log_warning "The following unknown args have been passed to pre-commit-grype hook: ${unknown_args}"
  fi

  res=$(install)
  to_uninstall=$(echo "${res}" | cut -d ':' -f 1)
  grype_path=$(echo "${res}" | cut -d ':' -f 2)
  grype_version=$(${grype_path} --version | cut -d ' ' -f 2)
  log_info "Grype path: ${grype_path}"
  log_info "Grype version: ${grype_version}"
  log_info "Grype will$([[ "${to_uninstall}" = "true" ]] && echo "" || echo " not") be uninstalled after scanning completed"

  set +e
  ${grype_path} ${grype_args}
  grype_exit_code=$?
  set -e
  msg="Grype exit code: ${grype_exit_code}"
  if [ "${grype_exit_code}" = "0" ]; then
    log_info "Grype exit code: ${grype_exit_code}"
  else
    log_warning "Grype exit code: ${grype_exit_code}"
  fi

  try_uninstall "$(dirname ${grype_path})" "${to_uninstall}"
  exit "${grype_exit_code}"
}

main "$@"
