#!/usr/bin/env sh

install() {
  fabasoad_log "debug" "Verifying Grype installation"
  if command -v grype &> /dev/null; then
    grype_path="$(which grype)"
    fabasoad_log "debug" "Grype is found at ${grype_path}. Installation skipped"
  else
    grype_path="${CONFIG_TEMP_BIN_DIR}/grype"
    mkdir -p "${CONFIG_TEMP_BIN_DIR}"
    if [ ! -d "${CONFIG_TEMP_BIN_DIR}" ] || [ ! -f "${grype_path}" ]; then
      fabasoad_log "debug" "Grype is not found. Downloading latest version:"
      curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b "${CONFIG_TEMP_BIN_DIR}"
      fabasoad_log "debug" "Downloading completed"
    else
      fabasoad_log "debug" "Grype is found at ${grype_path}. Installation skipped"
    fi
  fi
  echo "${grype_path}"
}
