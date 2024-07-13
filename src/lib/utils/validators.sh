#!/usr/bin/env sh

validate_enum() {
  param_key="$1"
  param_val="$2"
  enum_opts="$3,"
  case ",${enum_opts}" in
    *",${param_val},"*)
      ;;
    *)
      fabasoad_log "error" "\"${param_key}\" parameter is invalid. Possible values: $(echo "${enum_opts%,}" | sed 's/,/, /g')."
      exit 1
      ;;
  esac
}

validate_log_level_param() {
  param_val="${1}"
  log_level="${2:-warning}"
  _validate_log_level "${CONFIG_LOG_LEVEL_ARG_NAME}" "${param_val}" "${log_level}"
}

validate_log_level_global_var() {
  param_val="${1}"
  log_level="${2:-warning}"
  _validate_log_level "PRE_COMMIT_GRYPE_LOG_LEVEL" "${param_val}" "${log_level}"
}
