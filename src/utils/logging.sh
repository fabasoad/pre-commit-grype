#!/usr/bin/env sh

log() {
  prefix="[pre-commit-grype]"
  level=$1
  msg=$2

  printf "%s %s level=%s %s\n" "$prefix" "$(date +'%Y-%m-%d %T')" "$level" "$msg" >&2
}

log_info() {
  log "info" "$1"
}

log_debug() {
  log "debug" "$1"
}

log_warning() {
  log "warning" "$1"
}
