#!/usr/bin/env sh
set -u

grype_dir() {
  grype_common "dir:. $@"
}
