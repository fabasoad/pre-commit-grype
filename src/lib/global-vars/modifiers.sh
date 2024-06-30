#!/usr/bin/env sh

# Gets log level. Precedence:
# (1) Parameter defined via --hook-args, i.e. value saved to temporary directory
# (2) Environment variable
# (3) Default value
get_global_log_level() {
  set +u
  get_prop "PRE_COMMIT_GRYPE_LOG_LEVEL" \
    "${PRE_COMMIT_GRYPE_LOG_LEVEL:-${CONFIG_LOG_LEVEL_DEFAULT_VAL}}" \
    | sed 's/^ *//'
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
