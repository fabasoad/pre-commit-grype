#!/usr/bin/env sh

install() {
  fabasoad_log "debug" "Verifying Grype installation"
  if command -v grype &> /dev/null; then
    grype_path="$(which grype)"
    fabasoad_log "debug" "Grype is found at ${grype_path}. Installation skipped"
  else
    if [ -f "${CONFIG_CACHE_APP_BIN_DIR}" ]; then
      err_msg="${CONFIG_CACHE_APP_BIN_DIR} existing file prevents from creating"
      err_msg="${err_msg} a cache directory with the same name. Please either"
      err_msg="${err_msg} remove this file or install grype globally manually."
      fabasoad_log "error" "${err_msg}"
      exit 1
    fi
    grype_path="${CONFIG_CACHE_APP_BIN_DIR}/grype"
    mkdir -p "${CONFIG_CACHE_APP_BIN_DIR}"
    if [ -f "${grype_path}" ]; then
      fabasoad_log "debug" "Grype is found at ${grype_path}. Installation skipped"
    else
      fabasoad_log "debug" "Grype is not found. Downloading ${PRE_COMMIT_GRYPE_GRYPE_VERSION} version:"
      if [ "${PRE_COMMIT_GRYPE_GRYPE_VERSION}" = "latest" ]; then
        curl -sSfL "https://raw.githubusercontent.com/${_UPSTREAM_FULL_REPO_NAME}/main/install.sh" | sh -s -- -b "${CONFIG_CACHE_APP_BIN_DIR}"
      else
        curl -sSfL "https://raw.githubusercontent.com/${_UPSTREAM_FULL_REPO_NAME}/main/install.sh" | sh -s -- -b "${CONFIG_CACHE_APP_BIN_DIR}" "v${PRE_COMMIT_GRYPE_GRYPE_VERSION}"
      fi
      fabasoad_log "debug" "Downloading completed"
    fi
  fi
  echo "${grype_path}"
}
