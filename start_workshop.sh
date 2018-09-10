#!/usr/bin/env bash

readonly SCRIPT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd );

function main
{
  if [ -z "$(ls ${SCRIPT_DIR}/pictures-analyzer*)" ]; then
    selected_language=$(ask_user_for_language)
  elif [ -d ${SCRIPT_DIR}/pictures-analyzer ]; then
    selected_language="python"
  else
    selected_language=$(ls ${SCRIPT_DIR} | grep "pictures-analyzer" | cut -d "-" -f 3)
  fi
  workshop_starter_script="${SCRIPT_DIR}/${selected_language}/start_workshop.sh"
  bash ${workshop_starter_script} "$@"
}

function ask_user_for_language
{
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
