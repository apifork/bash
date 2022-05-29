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

# START
# If the last line of your file has no newline on the end
while git_repo=; IFS=$' \t\r\n' read -r git_repo || [[ $git_repo ]]; do
  repo=($git_repo)
  echo "$CMD PROJECT: ${repo[1]}/  FROM REPO:  (${repo[0]})"
  if [ "$CMD" == "install" ]; then
    echo "${repo[1]}" >>.gitignore
    git clone ${git_repo}
  elif [ "$CMD" == "update" ]; then
    cd ${repo[1]} && git pull
    cd ..
  elif [ "$CMD" == "remove" ]; then
    rm -rf ${repo[1]}
  else
    echo "Command $CMD is not recognized"
  fi
done <"$PROJECT_LIST"
