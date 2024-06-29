#!/usr/bin/env sh

uninstall() {
  log_debug "${CONFIG_TEMP_DIR} directory has been removed"
  rm -rf "${CONFIG_TEMP_DIR}"
}
