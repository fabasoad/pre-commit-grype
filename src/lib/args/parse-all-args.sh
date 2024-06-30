#!/usr/bin/env bash

parse_all_args() {
  local -n map_ref=$1
  shift

  map_ref["grype-args"]=""
  map_ref["hook-args"]=""

  curr_flag=""

  args="$@"

  # Loop through all the arguments
  while [[ -n "${args}" ]]; do
    case "$(echo "${args}" | cut -d '=' -f 1)" in
      --hook-args)
        args="${args#*=}"
        curr_flag="hook"
        ;;
      --grype-args)
        args="${args#*=}"
        curr_flag="grype"
        ;;
      *)
        arg=$(echo "${args}" | cut -d ' ' -f 1)
        if [ "${curr_flag}" = "hook" ]; then
          map_ref["hook-args"]="${map_ref["hook-args"]} ${arg}"
        elif [ "${curr_flag}" = "grype" ]; then
          map_ref["grype-args"]="${map_ref["grype-args"]} ${arg}"
        else
          msg="Invalid format of the following argument: \"${arg}\". Please use"
          msg="${msg} --hook-args to pass args to pre-commit hook or --grype-args"
          msg="${msg} to pass args to grype. For more information go to https://github.com/fabasoad/pre-commit-grype?tab=readme-ov-file"
          log_error "${msg}"
          exit 1
        fi

        args=$(echo "${args}" | cut -d ' ' -f 2-)
        if [ "${arg}" = "${args}" ]; then
          args=""
        fi
        ;;
    esac
  done

  map_ref["hook-args"]=$(echo "${map_ref["hook-args"]}" | sed 's/^ *//')
  map_ref["grype-args"]=$(echo "${map_ref["grype-args"]}" | sed 's/^ *//')
}
