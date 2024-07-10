#!/usr/bin/env sh

uninstall() {
  fabasoad_log "debug" "${CONFIG_TEMP_DIR} directory has been removed"
  rm -rf "${CONFIG_TEMP_DIR}"
}
