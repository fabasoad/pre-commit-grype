#!/usr/bin/env bash

SCRIPT_PATH=$(realpath "$0")
HOOKS_DIR_PATH=$(dirname "${SCRIPT_PATH}")
SRC_DIR_PATH=$(dirname "${HOOKS_DIR_PATH}")
UTILS_DIR_PATH="${SRC_DIR_PATH}/utils"

. "${UTILS_DIR_PATH}/logging.sh"

parse_args_grype() {
  log_debug "Parsing --grype-args started"

  output=""
  for arg in "$@"; do
    if [ "${arg#--grype-args}" != "$arg" ]; then
      log_debug "Parsing $arg argument"
      arg=$(echo "${arg}" | cut -d '=' -f 2-)
      output="${output} ${arg}"
    fi
  done
  echo "${output}"

  log_debug "Parsing --grype-args completed"
}

parse_args_hook() {
  log_debug "Parsing --hook-args started"

  output=""
  for arg in "$@"; do
    if [ "${arg#--hook-args}" != "$arg" ]; then
      log_debug "Parsing $arg argument"
      arg=$(echo "${arg}" | cut -d '=' -f 2-)
      output="${output} ${arg}"
    fi
  done
  echo "${output}"

  log_debug "Parsing --hook-args completed"
}

parse_args_unknown() {
  log_debug "Parsing unknown args started"

  output=""
  for arg in "$@"; do
    if [ "${arg#--grype-args}" = "$arg" ] && [ "${arg#--hook-args}" = "$arg" ]; then
      log_debug "Parsing $arg argument"
      arg=$(echo "${arg}" | cut -d '=' -f 2-)
      output="${output} ${arg}"
    fi
  done
  echo "${output}"

  log_debug "Parsing unknown args completed"
}
