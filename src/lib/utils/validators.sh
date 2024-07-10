#!/usr/bin/env sh

validate_enum() {
  local -n logs_map_ref=$1
  shift

  param_key="$1"
  param_val="$2"
  enum_opts="$3,"
  log_level="${4:-warning}"
  case ",${enum_opts}" in
    *",${param_val},"*)
      echo "true"
      ;;
    *)
      logs_map_ref["${log_level}"]="\"${param_key}\" parameter is invalid. Possible values: $(echo "${enum_opts%,}" | sed 's/,/, /g')."
      echo "false"
      ;;
  esac
}

_validate_log_level() {
  local -n logs_map_ref=$1
  shift

  param_key="${1}"
  param_val="${2}"
  log_level="${3:-warning}"
  validate_enum logs_map_ref "${param_key}" "${param_val}" "${CONFIG_LOG_LEVEL_OPTIONS}" "${log_level}"
}

validate_log_level_param() {
  local -n logs_map_ref=$1
  shift

  param_val="${1}"
  log_level="${2:-warning}"
  _validate_log_level logs_map_ref "${CONFIG_LOG_LEVEL_ARG_NAME}" "${param_val}" "${log_level}"
}

validate_log_level_global_var() {
  local -n logs_map_ref=$1
  shift

  param_val="${1}"
  log_level="${2:-warning}"
  _validate_log_level logs_map_ref "PRE_COMMIT_GRYPE_LOG_LEVEL" "${param_val}" "${log_level}"
}
