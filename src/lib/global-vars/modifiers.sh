#!/usr/bin/env sh

get_global_log_level() {
  set +u
  if [ -z "${PRE_COMMIT_GRYPE_LOG_LEVEL}" ]; then
    get_prop "PRE_COMMIT_GRYPE_LOG_LEVEL" "${CONFIG_LOG_LEVEL_DEFAULT_VAL}" | sed 's/^ *//'
  else
    echo "${PRE_COMMIT_GRYPE_LOG_LEVEL}"
  fi
  set -u
}

set_global_log_level() {
  log_level="$1"
  is_valid=$(validate_log_level_param "${log_level}")
  if [ "${is_valid}" = "true" ]; then
    save_prop "PRE_COMMIT_GRYPE_LOG_LEVEL" "${log_level}"
  fi
}

reset_global_log_level() {
  set_global_log_level "${CONFIG_LOG_LEVEL_DEFAULT_VAL}"
}
