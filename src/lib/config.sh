#!/usr/bin/env sh

CONFIG_LOG_LEVEL_DEFAULT_VAL="info"
CONFIG_LOG_LEVEL_OPTIONS="off,debug,info,warning,error"
CONFIG_TEMP_DIR="$(pwd)/.pre-commit-grype"
CONFIG_TEMP_BIN_DIR="${CONFIG_TEMP_DIR}/bin"
