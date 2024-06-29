#!/usr/bin/env sh

CONFIG_LOG_LEVEL_DEFAULT_VAL="info"
CONFIG_LOG_LEVEL_OPTIONS="off,debug,info,warning,error"
CONFIG_TEMP_DIR_NAME=".pre-commit-grype"
CONFIG_TEMP_DIR="$(pwd)/${CONFIG_TEMP_DIR_NAME}"
CONFIG_TEMP_BIN_DIR="${CONFIG_TEMP_DIR}/bin"
CONFIG_TEMP_PROPS_DIR="${CONFIG_TEMP_DIR}/props"

save_prop() {
  mkdir -p "${CONFIG_TEMP_PROPS_DIR}"
  echo "$2" > "${CONFIG_TEMP_PROPS_DIR}/$1"
}

get_prop() {
  prop_file_path="${CONFIG_TEMP_PROPS_DIR}/$1"
  default_val="${2:-""}"
  if [ -f "${prop_file_path}" ]; then
    cat "${prop_file_path}"
  else
    echo "${default_val}"
  fi
}
