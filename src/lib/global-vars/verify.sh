#!/usr/bin/env sh

_verify_log_level() {
  env_var_val="$(get_global_log_level)"
  is_valid=$(validate_log_level_global_var "${env_var_val}" "off")
  if [ "${is_valid}" = "false" ]; then
    msg="\"${env_var_name}\" environment variable is invalid (\"${env_var_val}\")."
    msg="${msg} Possible values: $(echo "${CONFIG_LOG_LEVEL_OPTIONS%,}" | sed 's/,/, /g')."
    msg="${msg} Setting back to default value: \"${CONFIG_LOG_LEVEL_DEFAULT_VAL}\"."
    log_warning "${msg}"
    reset_global_log_level
  fi
}

verify_global_vars() {
  _verify_log_level
}
