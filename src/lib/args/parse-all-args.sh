#!/usr/bin/env bash

parse_all_args() {
  grype_args=""
  hook_args=""
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
          hook_args="${hook_args} ${arg}"
        elif [ "${curr_flag}" = "grype" ]; then
          grype_args="${grype_args} ${arg}"
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

  hook_args=$(echo "${hook_args}" | sed 's/^ *//')
  parse_hook_args "${hook_args}"

  grype_args=$(echo "${grype_args}" | sed 's/^ *//')
  echo "${grype_args}"
}
