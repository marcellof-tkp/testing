#!/usr/bin/env bash

git_is_merged () {
  merge_destination_branch=$1
  merge_source_branch=$2

  merge_base=$(git merge-base $merge_destination_branch $merge_source_branch)
  merge_source_current_commit=$(git rev-parse $merge_source_branch)
  if [[ $merge_base = $merge_source_current_commit ]]
  then
    echo true
    #echo $merge_source_branch is merged into $merge_destination_branch
  else
    echo false
    #echo $merge_source_branch is not merged into $merge_destination_branch
  fi
}

result=$(git_is_merged main b)
if [[ $result ]]
then
  echo "true"
else
  echo "false"
fi