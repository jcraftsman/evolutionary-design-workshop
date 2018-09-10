#!/usr/bin/env bash

readonly SCRIPT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd );
readonly CODE_DIR_PREFIX="pictures-analyzer"
readonly PYTHON_CODE_DIR="${SCRIPT_DIR}/${CODE_DIR_PREFIX}"
readonly CODE_DIR_PATTERN="${SCRIPT_DIR}/${CODE_DIR_PREFIX}*"

function main
{
  selected_language=$(select_language)
  workshop_starter_script="${SCRIPT_DIR}/${selected_language}/start_workshop.sh"
  bash ${workshop_starter_script} "$@"
}

function select_language
{
  select_language=""
  if [ -d ${PYTHON_CODE_DIR} ]; then
    selected_language="python"
  elif ls ${CODE_DIR_PATTERN} 1> /dev/null 2>&1 ; then
    selected_language=$(determine_language_from_code_dir)
  else
    selected_language=$(ask_user_for_language)
  fi
  echo ${selected_language}
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

function determine_language_from_code_dir
{
  echo $(ls ${SCRIPT_DIR} | grep ${CODE_DIR_PREFIX} | cut -d "-" -f 3) 
}

main "$@"
