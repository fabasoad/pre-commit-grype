#!/usr/bin/env sh

_verify_log_level() {
  local -n logs_map_ref=$1
  shift

  env_var_name="PRE_COMMIT_GRYPE_LOG_LEVEL"
  env_var_val="$(get_global_log_level)"
  is_valid=$(validate_log_level_global_var logs_map_ref "${env_var_val}" "off")
  if [ "${is_valid}" = "false" ]; then
    msg="\"${env_var_name}\" environment variable is invalid (\"${env_var_val}\")."
    msg="${msg} Possible values: $(echo "${CONFIG_LOG_LEVEL_OPTIONS%,}" | sed 's/,/, /g')."
    msg="${msg} Resetting to default value: \"${CONFIG_LOG_LEVEL_DEFAULT_VAL}\"."
    logs_map_ref["warning"]="${msg}"
    reset_global_log_level logs_map_ref
  fi
}

verify_global_vars() {
  _verify_log_level "$@"
}
