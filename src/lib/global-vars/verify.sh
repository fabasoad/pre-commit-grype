#!/usr/bin/env sh

_verify_log_level() {
  env_var_name="PRE_COMMIT_GRYPE_LOG_LEVEL"
  env_var_val="$(get_global_log_level)"
  is_valid=$(validate_log_level_global_var "${env_var_val}" "off")
  if [ "${is_valid}" = "false" ]; then
    reset_global_log_level
  fi
}

verify_global_vars() {
  _verify_log_level
}
