#!/usr/bin/env sh

uninstall() {
  if [ "${PRE_COMMIT_GRYPE_CLEAN_CACHE}" = "true" ]; then
    rm -rf "${CONFIG_CACHE_APP_DIR}"
    fabasoad_log "debug" "${CONFIG_CACHE_APP_DIR} directory has been removed"
    if [ -z "$(ls -A "${CONFIG_CACHE_ROOT_DIR}")" ]; then
      rm -rf "${CONFIG_CACHE_ROOT_DIR}"
      fabasoad_log "debug" "${CONFIG_CACHE_ROOT_DIR} directory has been removed since it is empty"
    fi
  else
    fabasoad_log "debug" "${CONFIG_CACHE_APP_DIR} directory was not removed"
  fi
}
