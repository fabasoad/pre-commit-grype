#!/usr/bin/env sh

log_debug_installed() {
  grype_path="$1"
  if [ "$2" = "false" ]; then
    word="found"
  else
    word="installed"
  fi
  log_debug "Grype $($grype_path --version | cut -d ' ' -f 2) is ${word} at ${grype_path}"
}

install() {
  log_debug "Grype installation started"
  to_uninstall="false"
  if command -v grype &> /dev/null; then
    grype_path="$(which grype)"
  else
    grype_path="${CONFIG_TEMP_BIN_DIR}/grype"
    mkdir -p "${CONFIG_TEMP_BIN_DIR}"
    if [ ! -d "${CONFIG_TEMP_BIN_DIR}" ] || [ ! -f "${grype_path}" ]; then
      log_debug "Grype is not found. Downloading latest version..."
      curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b "${CONFIG_TEMP_BIN_DIR}"
      to_uninstall="true"
    fi
  fi
  log_debug_installed "${grype_path}" "${to_uninstall}"
  echo "${to_uninstall}:${grype_path}"
  log_debug "Grype installation completed"
}
