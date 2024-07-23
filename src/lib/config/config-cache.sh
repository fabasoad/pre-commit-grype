#!/usr/bin/env sh

apply_cache_config() {
  clean_cache="${1:-${PRE_COMMIT_GRYPE_CLEAN_CACHE:-${CONFIG_CLEAN_CACHE_DEFAULT_VAL}}}"
  validate_enum "${CONFIG_CLEAN_CACHE_ARG_NAME}" "${clean_cache}" "${CONFIG_CLEAN_CACHE_OPTIONS}"
  export PRE_COMMIT_GRYPE_CLEAN_CACHE="${clean_cache}"
}
