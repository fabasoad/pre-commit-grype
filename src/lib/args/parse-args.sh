#!/usr/bin/env bash

MAIN_SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
ARGS_DIR_PATH="${LIB_DIR_PATH}/args"
UTILS_DIR_PATH="${LIB_DIR_PATH}/utils"

. "${ARGS_DIR_PATH}/apply-hook-arg.sh"
. "${UTILS_DIR_PATH}/logging.sh"

_parse_argument() {
  arg=$(echo "$1" | cut -d '=' -f 2-)
  echo "${arg}"
}

parse_args_grype() {
  output=""
  for arg in "$@"; do
    if [ "${arg#--grype-args}" != "$arg" ]; then
      output="${output} $(_parse_argument "${arg}")"
    fi
  done
  echo "${output}"
}

parse_args_hook() {
  args_str=""
  for arg in "$@"; do
    if [ "${arg#--hook-args}" != "$arg" ]; then
      sanitized_arg=$(_parse_argument "${arg}")
      apply_hook_arg "${sanitized_arg}"
      args_str="${args_str} ${sanitized_arg}"
    fi
  done
  echo "${args_str}"
}

parse_args_unknown() {
  output=""
  for arg in "$@"; do
    if [ "${arg#--grype-args}" = "$arg" ] && [ "${arg#--hook-args}" = "$arg" ]; then
      output="${output} $(_parse_argument "${arg}")"
    fi
  done
  echo "${output}"
}

parse_args() {
  grype_args=""

  # Loop through all the arguments
  while [[ "$#" -gt 0 ]]; do
    case $1 in
      --hook-args=*)
        # Extract the value after --hook-arg= and append it to var1
        arg="${1#*=}"
        apply_hook_arg "${arg}"
        ;;
      --grype-args=*)
        # Extract the value after --tool-arg= and append it to var2
        arg="${1#*=}"
        grype_args="${grype_args} ${arg}"
        ;;
      *)
        arg="${1#*=}"
        log_warning "The following unknown arg has been passed to pre-commit-grype hook: \"${arg}\""
        ;;
    esac
    shift
  done

  echo ${grype_args} | sed 's/^ *//'
}
