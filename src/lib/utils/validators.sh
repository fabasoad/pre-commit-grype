#!/usr/bin/env sh

validate_enum() {
  param_key="$1"
  param_val="$2"
  enum_opts="$3,"
  log_level="${4:-warning}"
  case ",${enum_opts}" in
    *",${param_val},"*)
      echo "true"
      ;;
    *)
      log_${log_level} "\"${param_key}\" parameter is invalid. Possible values: $(echo "${enum_opts%,}" | sed 's/,/, /g')."
      echo "false"
      ;;
  esac
}

validate_log_level() {
  param_val="${1}"
  log_level="${2:warning}"
  validate_enum "--log-level" "${param_val}" "off,debug,info,warning,error" "${log_level}"
}
