#!/usr/bin/env bash
set -u

SCRIPT_PATH=$(realpath "$0")
HOOKS_DIR_PATH=$(dirname "${SCRIPT_PATH}")
SRC_DIR_PATH=$(dirname "${HOOKS_DIR_PATH}")
UTILS_DIR_PATH="${SRC_DIR_PATH}/utils"

. "${UTILS_DIR_PATH}/cleanup.sh"
. "${UTILS_DIR_PATH}/install.sh"
. "${UTILS_DIR_PATH}/logging.sh"
. "${UTILS_DIR_PATH}/parse-args.sh"

main() {
  declare -A args_map

  args_map["grype-args"]="dir:."
  args_map["hook-args"]=""
  args_map["unknown-args"]=""

  parse_args "args_map" "$@"

  if [ "${args_map["unknown-args"]}" != "" ]; then
    log_warning "The following unknown args have been passed to pre-commit-grype hook: ${args_map["unknown-args"]}"
  fi

  res=$(install)
  cleanup=$(echo "${res}" | cut -d ':' -f 1)
  grype_path=$(echo "${res}" | cut -d ':' -f 2)
  grype_version=$(${grype_path} --version | cut -d ' ' -f 2)
  log_info "Grype path: ${grype_path}"
  log_info "Grype version: ${grype_version}"
  log_info "Remove after complete: ${cleanup}"

  set +e
  ${grype_path} ${map_ref["grype-args"]}
  grype_exit_code=$?
  set -e
  msg="Grype exit code: ${grype_exit_code}"
  if [ "${grype_exit_code}" = "0" ]; then
    log_info "Grype exit code: ${grype_exit_code}"
  else
    log_warning "Grype exit code: ${grype_exit_code}"
  fi

  if [ "${cleanup}" = "true" ]; then
    cleanup "$(dirname ${grype_path})"
  fi
  exit "${grype_exit_code}"
}

main "$@"
