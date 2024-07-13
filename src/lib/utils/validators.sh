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
