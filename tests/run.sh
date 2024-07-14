#!/usr/bin/env sh

TESTS_DIR=$(dirname $(realpath "$0"))

main() {
  current_file=$(realpath "$0")
  test_files=$(find "${TESTS_DIR}" -type f \( -perm -u=x -o -perm -g=x -o -perm -o=x \))
  for test_file in $test_files; do
    if [ "${test_file}" != "${current_file}" ]; then
      ${test_file}
    fi
  done
}

main $@
