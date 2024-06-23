#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
HOOKS_DIR_PATH=$(dirname "${SCRIPT_PATH}")
SRC_DIR_PATH=$(dirname "${HOOKS_DIR_PATH}")
UTILS_DIR_PATH="${SRC_DIR_PATH}/utils"

. "${UTILS_DIR_PATH}/logging.sh"

log_debug_installed() {
  grype_path="$1"
  if [ "$2" = "false" ]; then
    word="found"
  else
    word="installed"
  fi
  log_debug "Grype $(${grype_path} --version | cut -d ' ' -f 2) is ${word} at ${grype_path}"
}

install() {
  log_debug "Grype installation started"
  cleanup="false"
  if command -v grype &> /dev/null; then
    grype_path="$(which grype)"
  else
    cleanup="true"
    bin_dir="$(pwd)/.pre-commit-grype"
    grype_path="${bin_dir}/grype"
    mkdir -p "${bin_dir}"
    if [ ! -d "${bin_dir}" ] || [ ! -f "${grype_path}" ]; then
      log_debug "Grype is not found. Downloading latest version..."
      curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b "${bin_dir}"
    fi
  fi
  log_debug_installed "{$grype_path}" "${cleanup}"
  echo "${cleanup}:${grype_path}"
  log_debug "Grype installation completed"
}
