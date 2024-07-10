#!/usr/bin/env sh

# Gets log level. Precedence:
# (1) Parameter defined via --hook-args, i.e. value saved to temporary directory
# (2) Environment variable
# (3) Default value
get_global_log_level() {
  set +u
  # Removing trailing and leading spaces is needed here to be sure to have a correct
  # value retrieved from environment variable in case user sets it incorrectly
  # (with spaces)
  get_prop "PRE_COMMIT_GRYPE_LOG_LEVEL" \
    "${PRE_COMMIT_GRYPE_LOG_LEVEL:-${CONFIG_LOG_LEVEL_DEFAULT_VAL}}" \
    | sed 's/^ *//' | sed 's/ *$//'
  set -u
}

# This function is called by the name dynamically also, such as set_global_${str}
set_global_log_level() {
  local -n logs_map_ref=$1
  shift

  log_level="$1"
  is_valid=$(validate_log_level_param logs_map_ref "${log_level}")
  if [ "${is_valid}" = "true" ]; then
    save_prop "PRE_COMMIT_GRYPE_LOG_LEVEL" "${log_level}"
  fi
}

reset_global_log_level() {
  local -n logs_map_ref=$1
  shift

  set_global_log_level logs_map_ref "${CONFIG_LOG_LEVEL_DEFAULT_VAL}"
}
