#!/usr/bin/env bash
set -u

grype_dir() {
  grype_common "dir:. $@"
}
