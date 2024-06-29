#!/usr/bin/env sh

get_global_log_level() {
  echo "${PRE_COMMIT_GRYPE_LOG_LEVEL:-${CONFIG_LOG_LEVEL_DEFAULT_VAL}}"
}

set_global_log_level() {
  log_level="$1"
  is_valid=$(validate_log_level_param "${log_level}")
  if [ "${is_valid}" = "true" ]; then
    export PRE_COMMIT_GRYPE_LOG_LEVEL="${log_level}"
  fi
}

reset_global_log_level() {
  set_global_log_level "${CONFIG_LOG_LEVEL_DEFAULT_VAL}"
}
