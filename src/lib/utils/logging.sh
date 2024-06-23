#!/usr/bin/env sh

log() {
  prefix="[pre-commit-grype]"
  level=$1
  msg=$2

  printf "%s %s level=%s %s\n" "$prefix" "$(date +'%Y-%m-%d %T')" "$level" "$msg" >&2
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
  if [ "${GLOB_LOG_LEVEL}" = "debug" ]; then
    echo "true"
  else
    echo "false"
  fi
}

is_info_ok() {
  # ok: debug, info
  # not ok: off, warning, error
  if [ "${GLOB_LOG_LEVEL}" = "debug" ] || [ "${GLOB_LOG_LEVEL}" = "info" ]; then
    echo "true"
  else
    echo "false"
  fi
}

is_warning_ok() {
  # ok: debug, info, warning
  # not ok: off, error
  if [ "${GLOB_LOG_LEVEL}" != "error" ] && [ "${GLOB_LOG_LEVEL}" != "off" ]; then
    echo "true"
  else
    echo "false"
  fi
}

is_error_ok() {
  # ok: debug, info, warning, error
  # not ok: off
  if [ "${GLOB_LOG_LEVEL}" != "off" ]; then
    echo "true"
  else
    echo "false"
  fi
}
