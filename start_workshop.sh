#!/usr/bin/env bash

readonly SCRIPT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd );

function main
{
  selected_language=$(ask_language)
  workshop_starter_script="${SCRIPT_DIR}/${selected_language}/start_workshop.sh"
  $(bash ${workshop_starter_script} $1)
}

function ask_language() {
  selected_language=""
  while true; do
    read -p "Language (java, python) ?  " response
    case "$response" in
    "java")
      selected_language=$response
      break
      ;;
    "python")
      selected_language=$response
      break
      ;;
    esac
  done
  echo ${selected_language}
}

main "$@"
