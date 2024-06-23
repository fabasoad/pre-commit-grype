#!/usr/bin/env bash

SCRIPT_PATH=$(realpath "$0")
HOOKS_DIR_PATH=$(dirname "${SCRIPT_PATH}")
SRC_DIR_PATH=$(dirname "${HOOKS_DIR_PATH}")
UTILS_DIR_PATH="${SRC_DIR_PATH}/utils"

. "${UTILS_DIR_PATH}/logging.sh"

parse_args() {
  log_debug "Parsing arguments started"
  local -n map_ref=$1
  args="$2"

  for arg in "${args}"; do
    log_debug "Parsing $arg argument"
    if [ "${arg#--hook-args}" != "$arg" ]; then
      arg=$(echo "${arg}" | cut -d '=' -f 2)
      map_ref["hook-args"]="${map_ref["hook-args"]} ${arg}"
      log_debug "Marking \"$arg\" argument as hook args"
    elif [ "${arg#--grype-args}" != "$arg" ]; then
      arg=$(echo "${arg}" | cut -d '=' -f 2)
      map_ref["grype-args"]="${map_ref["grype-args"]} ${arg}"
      log_debug "Marking \"$arg\" argument as grype args"
    else
      map_ref["unknown-args"]+="${map_ref["unknown-args"]} ${arg}"
      log_debug "Marking \"$arg\" argument as unknown args"
    fi
  done
  log_debug "Parsing arguments completed"
}
