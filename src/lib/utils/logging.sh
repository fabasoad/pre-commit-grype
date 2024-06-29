#!/usr/bin/env sh

_is_debug_ok() {
  # ok: debug
  # not ok: off, info, warning, error
  if [ "$(get_global_log_level)" = "debug" ]; then
    echo "true"
  else
    echo "false"
  fi
}

_is_info_ok() {
  # ok: debug, info
  # not ok: off, warning, error
  if [ "$(get_global_log_level)" = "debug" ] || [ "$(get_global_log_level)" = "info" ]; then
    echo "true"
  else
    echo "false"
  fi
}

_is_warning_ok() {
  # ok: debug, info, warning
  # not ok: off, error
  if [ "$(get_global_log_level)" != "error" ] && [ "$(get_global_log_level)" != "off" ]; then
    echo "true"
  else
    echo "false"
  fi
}

_is_error_ok() {
  # ok: debug, info, warning, error
  # not ok: off
  if [ "$(get_global_log_level)" != "off" ]; then
    echo "true"
  else
    echo "false"
  fi
}

_log() {
  prefix="[pre-commit-grype]"
  level=$1
  msg=$2

  printf "%s %s level=%s %s\n" "$prefix" "$(date +'%Y-%m-%d %T')" "$level" "$msg" >&2
}

log_off() {
  :
}

log_debug() {
  if [ "$(_is_debug_ok)" = "true" ]; then
    _log "debug" "$1"
  fi
}

log_info() {
  if [ "$(_is_info_ok)" = "true" ]; then
    _log "info" "$1"
  fi
}

log_warning() {
  if [ "$(_is_warning_ok)" = "true" ]; then
    _log "warning" "$1"
  fi
}

log_error() {
  if [ "$(_is_error_ok)" = "true" ]; then
    _log "error" "$1"
  fi
}
