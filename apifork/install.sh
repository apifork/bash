#!/bin/bash
PROJECT_LIST=$1
[ -z "$PROJECT_LIST" ] && PROJECT_LIST="projects.txt"
while IFS= read -r git_repo; do
  repo=( $git_repo )
  echo "INSTALL PROJECT: ${repo[1]}/  FROM REPO:  (${repo[0]})"
  echo "${repo[1]}" >> .gitignore
  git clone ${git_repo}
done <"$PROJECT_LIST"
