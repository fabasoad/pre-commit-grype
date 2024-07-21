#!/usr/bin/env sh

apply_grype_config() {
  grype_version="${1:-${PRE_COMMIT_GRYPE_GRYPE_VERSION:-${CONFIG_GRYPE_VERSION_DEFAULT_VAL}}}"
  if [ "${grype_version}" != "latest" ]; then
    validate_semver "${CONFIG_GRYPE_VERSION_ARG_NAME}" "${grype_version}"
  fi
  export PRE_COMMIT_GRYPE_GRYPE_VERSION="${grype_version}"
}
