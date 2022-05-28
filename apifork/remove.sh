#!/bin/bash
PROJECT_LIST=$1
[ -z "$PROJECT_LIST" ] && PROJECT_LIST="projects.txt"
while IFS= read -r git_repo; do
  repo=( $git_repo )
  echo "REMOVE PROJECT: ${repo[1]}/  FROM REPO:  (${repo[0]})"
  rm -rf ${repo[1]}
done <"$PROJECT_LIST"

