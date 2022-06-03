#!/bin/bash

# CONTRIBUTION
## Author: Tom Sapletta
## Created Date: 26.05.2022

## EXAMPLE
# ./apifork.sh install
# ./apifork.sh update
# ./apifork.sh remove

# CONFIG
CMD=$1
[ -z "$CMD" ] && CMD="install"
#
DSL_HASH="#"
CONFIG_FILE=".apifork"
CONFIG_DEFAULT="apifork.txt"
CONFIG_DEV="apifork.dev.txt"
CONFIG_TEST="apifork.test.txt"
if [ "$CMD" == "-h" ] || [ "$CMD" == "--help" ]; then
  echo "set config for:"
  echo "init - the default config, for customers"
  echo "dev - development packages, for contributors and developers"
  echo "test - for testing the project"
  echo ""
  echo "git repositories:"
  echo "install"
  echo "update"
  echo "remove"
  echo ""
  exit
fi
if [ "$CMD" == "init" ]; then
  echo -n "$CONFIG_DEFAULT" > "$CONFIG_FILE"
  exit
fi
if [ "$CMD" == "dev" ]; then
  echo -n "$CONFIG_DEV" > "$CONFIG_FILE"
  exit
fi
if [ "$CMD" == "test" ]; then
  echo -n "$CONFIG_TEST" > "$CONFIG_FILE"
  exit
fi
#
PROJECT_LIST=$2
[ -z "$PROJECT_LIST" ] && [ -f "$CONFIG_FILE" ] && PROJECT_LIST=$(cat "$CONFIG_FILE")
[ -z "$PROJECT_LIST" ] && PROJECT_LIST="$CONFIG_DEFAULT"

PROJECT_PATH=$(pwd)
echo $PROJECT_PATH
BUILD="pwd"
APIBUILD="./apibuild"
APIFORK_BUILD="pwd"
APIFORK_BUILD="./apifork install"
APIFORK_UPDATE="./apifork update"
BUILD_PHP="composer update"
BUILD_NODEJS="npm update"
BUILD_PYTHON="python"
BUILD_JAVA="mvn clean package"
# START
# If the last line of your file has no newline on the end
while git_repo=; IFS=$' \t\r\n' read -r git_repo || [[ $git_repo ]]; do
  repo=($git_repo)
  [ "${repo:0:1}" == "${DSL_HASH}" ] && continue
  echo "$CMD PROJECT: ${repo[1]}/  FROM REPO:  (${repo[0]})"
  if [ "$CMD" == "install" ]; then
    echo "${repo[1]}" >>.gitignore
    git clone ${git_repo}
  elif [ "$CMD" == "update" ]; then
    cd ${repo[1]} && git pull
    [ "$(pwd)" == "${PROJECT_PATH}" ] && echo "!!! PROJECT ${repo[1]} NOT EXIST, PLEASE INSTALL FIRST " && continue
    [ -f "composer.json" ] && ${BUILD_PHP}
    [ -f "package.json" ] && ${BUILD_NODEJS}
    #${APIFORK_UPDATE}
  elif [ "$CMD" == "remove" ]; then
    rm -rf ${repo[1]}
  else
    echo "Command $CMD is not recognized"
  fi
  cd ${PROJECT_PATH}
done <"$PROJECT_LIST"
