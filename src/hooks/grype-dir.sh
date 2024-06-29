#!/usr/bin/env bash
set -u

#MAIN_SCRIPT_PATH=$(realpath "$0")
#SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
#LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
#BASE_DIR_PATH="${LIB_DIR_PATH}/base"
#
#. "${BASE_DIR_PATH}/grype-common.sh"

grype_dir() {
  grype_common "dir:. $@"
}
