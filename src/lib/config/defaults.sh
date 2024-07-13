#!/usr/bin/env sh

# System
CONSUMER_ROOT_DIR="$(pwd)"

# Logging
CONFIG_LOG_LEVEL_ARG_NAME="--log-level"
CONFIG_LOG_LEVEL_DEFAULT_VAL="info"
CONFIG_LOG_LEVEL_OPTIONS="debug,info,warning,error"

CONFIG_LOG_HEADER_DEFAULT_VAL="pre-commit-grype"
CONFIG_LOG_TEXT_COLOR_DEFAULT_VAL="true"
CONFIG_LOG_DATE_FORMAT_DEFAULT_VAL="%Y-%m-%d %T"
CONFIG_LOG_OUTPUT_FORMAT_DEFAULT_VAL="text"

# Temp dir
CONFIG_TEMP_DIR_NAME=".pre-commit-grype"
CONFIG_TEMP_DIR="${CONSUMER_ROOT_DIR}/${CONFIG_TEMP_DIR_NAME}"
CONFIG_TEMP_BIN_DIR="${CONFIG_TEMP_DIR}/bin"
