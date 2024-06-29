#!/usr/bin/env sh

try_uninstall() {
  bin_dir="$1"
  to_uninstall="$2"
  if [ "${to_uninstall}" = "true" ]; then
    log_debug "Uninstalling ${bin_dir} directory started"
    rm -rf "${bin_dir}"
    log_debug "Uninstalling ${bin_dir} directory completed"
  fi
}
