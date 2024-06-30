#!/usr/bin/env sh

_set_param() {
  set_param_func_name="set_global_$1"
  args_str="$2"
  delimiter="$3"
  # Removing param key, such as "--log-level"
  args_str=$(echo "${args_str}" | cut -d "${delimiter}" -f 2-)
  # Taking param value, such as "debug"
  param_val=$(echo "${args_str}" | cut -d ' ' -f 1 | sed 's/^ *//')
  # Saving leftover
  args_str=$(echo "${args_str}" | cut -d ' ' -f 2- | sed 's/^ *//')
  ${set_param_func_name} "${param_val}"
  if [ "${param_val}" = "${args_str}" ]; then
    echo ""
  else
    echo "${args_str}"
  fi
}

parse_hook_args() {
  args_str="$1"
  if [ -n "${args_str}" ]; then
    orig_str="${args_str}"
    while [ ${#args_str} -gt 0 ]; do
      case "${args_str}" in
        "${CONFIG_LOG_LEVEL_ARG_NAME}="*)
          args_str=$(_set_param "log_level" "${args_str}" "=")
          ;;
        "${CONFIG_LOG_LEVEL_ARG_NAME} "*)
          args_str=$(_set_param "log_level" "${args_str}" " ")
          ;;
        *)
          log_warning "Unknown ${args_str} argument has been passed as --hook-args"
          ;;
      esac
      shift
    done
    log_info "Pre-commit hook arguments: ${orig_str}"
  fi
}
