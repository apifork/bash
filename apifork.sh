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
PROJECT_LIST=$2
[ -z "$PROJECT_LIST" ] && [ ! -f ".apifork" ] && PROJECT_LIST=$(cat ".apifork")
[ -z "$PROJECT_LIST" ] && PROJECT_LIST="apifork.txt"
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
