#!/usr/bin/env sh

uninstall() {
  if [ "${PRE_COMMIT_GRYPE_CLEAN_CACHE}" = "true" ]; then
    fabasoad_log "debug" "${CONFIG_TEMP_DIR} directory has been removed"
    rm -rf "${CONFIG_TEMP_DIR}"
  else
    fabasoad_log "debug" "${CONFIG_TEMP_DIR} directory was not removed"
  fi
}
