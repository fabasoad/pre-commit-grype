#!/usr/bin/env sh

apply_logging_config() {
  log_level="${1:-${PRE_COMMIT_GRYPE_LOG_LEVEL:-${CONFIG_LOG_LEVEL_DEFAULT_VAL}}}"
  validate_enum "${log_level}" "${CONFIG_LOG_LEVEL_OPTIONS}" "${CONFIG_LOG_LEVEL_ARG_NAME}"
  export FABASOAD_LOG_CONFIG_LOG_LEVEL="${log_level}"

  log_color="${2:-${PRE_COMMIT_GRYPE_LOG_COLOR:-${CONFIG_LOG_COLOR_DEFAULT_VAL}}}"
  validate_enum "${log_color}" "${CONFIG_LOG_COLOR_OPTIONS}" "${CONFIG_LOG_COLOR_ARG_NAME}"
  export FABASOAD_LOG_CONFIG_TEXT_COLOR="${log_color}"

  export FABASOAD_LOG_CONFIG_DATE_FORMAT="${CONFIG_LOG_DATE_FORMAT_DEFAULT_VAL}"
  export FABASOAD_LOG_CONFIG_OUTPUT_FORMAT="${CONFIG_LOG_OUTPUT_FORMAT_DEFAULT_VAL}"
  export FABASOAD_LOG_CONFIG_HEADER="${CONFIG_LOG_HEADER_DEFAULT_VAL}"
}
