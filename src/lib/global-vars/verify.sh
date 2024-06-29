#!/usr/bin/env sh

_verify_log_level() {
  env_var_name="PRE_COMMIT_GRYPE_LOG_LEVEL"
  env_var_opts="off,debug,info,warning,error"
  env_var_val="$(get_global_log_level)"
  is_valid=$(validate_enum "${env_var_name}" "${env_var_val}" "${env_var_opts}" "off")
  if [ "${is_valid}" = "false" ]; then
    msg="\"${env_var_name}\" environment variable is invalid (\"${env_var_val}\")."
    msg="${msg} Possible values: $(echo "${env_var_opts%,}" | sed 's/,/, /g')."
    msg="${msg} Setting back to default value: \"$(get_global_log_level_default_value)\"."
    log_warning "${msg}"
    reset_global_log_level
  fi
}

verify_global_vars() {
  _verify_log_level
}
