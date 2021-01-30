#!/bin/bash

function git_current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function git_current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

BRANCH=$(git_current_branch)
REPO=$(git_current_repository)
DATE=$(date +"%Y-%m-%d %T")
MSG="> Gitignore updated at $DATE"

echo "> Removing cached from $REPO ..."
git rm -rf --cached .  
echo "> Running git add . ..."
git add .  
echo "> Running git commit -m ..."
git commit -m "$MSG"  
echo "> Running git push origin $BRANCH ..."
git push origin "$BRANCH"  
echo "$MSG"