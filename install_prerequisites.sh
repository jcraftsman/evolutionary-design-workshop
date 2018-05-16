#!/usr/bin/env bash

readonly SCRIPT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd );
readonly OSX_INSTALL_BREW_CMD='/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
readonly OSX_INSTALL_PYTHON_CMD='brew install python3.6'
readonly OSX_INSTALL_VENV_CMD='pip3 install virtualenv'
readonly OSX_INSTALL_TESSERACT_CMD='brew install tesseract'
readonly LINUX_INSTALL_VENV_CMD='pip3 install virtualenv'
readonly LINUX_INSTALL_TESSERACT_CMD='sudo apt-get install tesseract-ocr'

function main
{
  set -o errexit
  set -o pipefail
  set -o nounset
  set -o errtrace

  install_prerequisites_on_mac_os
  
  create_python_symlink_if_needed

}
function install_prerequisites_depending_on_os
{
  unameOut="$(uname -s)"
  case "${unameOut}" in
      Linux*)     install_prerequisites_on_linux;;
      Darwin*)    install_prerequisites_on_mac_os;;
      *)          echo "Your OS is not supported by this script. Take a look to the prerequiste section: https://github.com/jcraftsman/evolutionary-design-workshop#need-help"
  esac
echo ${machine}
}

function install_prerequisites_on_mac_os
{
  install_using_single_cmd "brew" ${OSX_INSTALL_BREW_CMD}
  brew update
  install_using_single_cmd "python3.6" ${OSX_INSTALL_PYTHON_CMD}
  install_using_single_cmd "virtualenv" ${OSX_INSTALL_VENV_CMD}
  install_using_single_cmd "tesseract" ${OSX_INSTALL_TESSERACT_CMD}
}

function install_prerequisites_on_linux
{
  install_python3_on_linux
  install_using_single_cmd "virtualenv" ${LINUX_INSTALL_VENV_CMD}
  install_using_single_cmd "tesseract" ${LINUX_INSTALL_TESSERACT_CMD}
}

function install_using_single_cmd
{
  command_name=${1}
  single_cmd=${2}
  if check_command_exists ${command_name}; then
      echo ${command_name} is already installed
  else
      echo ${command_name} is not installed. We will take care of it.
      eval ${single_cmd}
  fi
}

function install_python3_on_linux
{
  command_name="python3.6"
  if check_command_exists ${command_name}; then
      echo ${command_name} is already installed
  else
      echo ${command_name} is not installed. We will take care of it.
      sudo apt-get install software-properties-common python-software-properties
      sudo add-apt-repository -y add-apt-repository ppa:jonathonf/python-3.6
      sudo apt-get update
      sudo apt-get -y upgrade

      sudo apt-get install python3.6
      sudo apt-get install -y python3-pip
  fi
}

function check_command_exists
{
  command=$1
  message="You need to install it"
  command -v ${command} &> /dev/null 2>&1;
}

function create_python_symlink_if_needed
{
  if [ ! -f /usr/local/bin/python3 ]; then
    echo "A symlink pointing to python3.6 will be created in /usr/local/bin/python3"
    ln -s `which -a python3.6 | grep -v conda` /usr/local/bin/python3
  else
    echo "python3 is already in the expected path: /usr/local/bin/python3"
  fi
}

main "$@"
