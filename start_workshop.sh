#!/usr/bin/env bash
function main
{
  check_command_exists "git" "Git command line tool is not installed in your computer. You need to install it."

  set -o errexit
  set -o pipefail
  set -o nounset
  set -o errtrace

  rm -rf .git
  git clone https://github.com/jcraftsman/pictures-analyzer.git
  cd pictures-analyzer
  git checkout workshop-it1
  echo ""
  echo ""
  echo "****************************************************************************************"
  echo ""
  echo "You're all set! Have fun with 'Real world Evolutionary Design with Python' workshop! ;-)"
  echo ""
  echo "****************************************************************************************"
  echo ""
}

function check_command_exists
{
  command=$1
  message=$2
  command -v ${command} >/dev/null 2>&1 || { echo >&2 ${message}; exit 1; }
}

main "$@"
