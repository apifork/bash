#!/bin/bash
PROJECT_LIST=$1
[ -z "$PROJECT_LIST" ] && PROJECT_LIST="projects.txt"
while IFS= read -r git_repo; do
  repo=( $git_repo )
  echo "UPDATE PROJECT: ${repo[1]}/  FROM REPO:  (${repo[0]})"
  cd ${repo[1]} && git pull
  cd ..
done <"$PROJECT_LIST"

