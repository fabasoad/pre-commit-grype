#!/usr/bin/env sh

PRE_COMMIT_GRYPE_LOG_LEVEL_DEFAULT_VAL="info"

get_global_log_level_default_value() {
  echo "${PRE_COMMIT_GRYPE_LOG_LEVEL_DEFAULT_VAL}"
}

get_global_log_level() {
  echo "${PRE_COMMIT_GRYPE_LOG_LEVEL:-${PRE_COMMIT_GRYPE_LOG_LEVEL_DEFAULT_VAL}}"
}

set_global_log_level() {
  log_level="$1"
  is_valid=$(validate_log_level "${log_level}")
  if [ "${is_valid}" = "true" ]; then
    log_info "SET GLOBAL TO $1"
    export PRE_COMMIT_GRYPE_LOG_LEVEL="${log_level}"
  fi
}

reset_global_log_level() {
  set_global_log_level "${PRE_COMMIT_GRYPE_LOG_LEVEL_DEFAULT_VAL}"
}
