#!/usr/bin/env sh

MAIN_SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
GLOBAL_VARS_DIR_PATH="${LIB_DIR_PATH}/global-vars"

. "${GLOBAL_VARS_DIR_PATH}/modifiers.sh"

log() {
  prefix="[pre-commit-grype]"
  level=$1
  msg=$2

  printf "%s %s level=%s %s\n" "$prefix" "$(date +'%Y-%m-%d %T')" "$level" "$msg" >&2
}

log_off() {
  :
}

log_debug() {
  if [ "$(is_debug_ok)" = "true" ]; then
    log "debug" "$1"
  fi
}

log_info() {
  if [ "$(is_info_ok)" = "true" ]; then
    log "info" "$1"
  fi
}

log_warning() {
  if [ "$(is_warning_ok)" = "true" ]; then
    log "warning" "$1"
  fi
}

log_error() {
  if [ "$(is_error_ok)" = "true" ]; then
    log "error" "$1"
  fi
}

is_debug_ok() {
  # ok: debug
  # not ok: off, info, warning, error
  if [ "$(get_global_log_level)" = "debug" ]; then
    echo "true"
  else
    echo "false"
  fi
}

is_info_ok() {
  # ok: debug, info
  # not ok: off, warning, error
  if [ "$(get_global_log_level)" = "debug" ] || [ "$(get_global_log_level)" = "info" ]; then
    echo "true"
  else
    echo "false"
  fi
}

is_warning_ok() {
  # ok: debug, info, warning
  # not ok: off, error
  if [ "$(get_global_log_level)" != "error" ] && [ "$(get_global_log_level)" != "off" ]; then
    echo "true"
  else
    echo "false"
  fi
}

is_error_ok() {
  # ok: debug, info, warning, error
  # not ok: off
  if [ "$(get_global_log_level)" != "off" ]; then
    echo "true"
  else
    echo "false"
  fi
}
