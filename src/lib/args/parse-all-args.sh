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

parse_all_args() {
  grype_args=""
  hook_args=""
  curr_flag=""

  args="$@"

  # Loop through all the arguments
  while [[ -n "${args}" ]]; do
    case "$(echo "${args}" | cut -d '=' -f 1)" in
      --hook-args)
        args="${args#*=}"
        curr_flag="hook"
        ;;
      --grype-args)
        args="${args#*=}"
        curr_flag="grype"
        ;;
      *)
        arg=$(echo "${args}" | cut -d ' ' -f 1)
        if [ "${curr_flag}" = "hook" ]; then
          hook_args="${hook_args} ${arg}"
        elif [ "${curr_flag}" = "grype" ]; then
          grype_args="${grype_args} ${arg}"
        else
          msg="Invalid format of the following argument: \"${arg}\". Please use"
          msg="${msg} --hook-args to pass args to pre-commit hook or --grype-args"
          msg="${msg} to pass args to grype. For more information go to https://github.com/fabasoad/pre-commit-grype?tab=readme-ov-file"
          log_error "${msg}"
          exit 1
        fi

        args=$(echo "${args}" | cut -d ' ' -f 2-)
        if [ "${arg}" = "${args}" ]; then
          args=""
        fi
        ;;
    esac
  done

  hook_args=$(echo "${hook_args}" | sed 's/^ *//')
  grype_args=$(echo "${grype_args}" | sed 's/^ *//')
  log_debug "Hook arguments: ${hook_args}"
  echo "${grype_args}"
}
