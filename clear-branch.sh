#!/usr/bin/env bash

git_is_merged () {
  merge_destination_branch=$1
  merge_source_branch=$2

  merge_base=$(git merge-base $merge_destination_branch $merge_source_branch)
  merge_source_current_commit=$(git rev-parse $merge_source_branch)
  if [[ $merge_base = $merge_source_current_commit ]]
  then
    echo $merge_source_branch is merged into $merge_destination_branch
    return 0
  else
    echo $merge_source_branch is not merged into $merge_destination_branch
    return 1
  fi
}

clear_branch() {
  result=$(git_is_merged)
  for k in $(git branch | sed /\*/d); do
    if [ -z "$(git log -1 --since='1 minutes ago' -s $k)" ] && [[ $result ]]
    then
      git branch -D $k
      git push origin -d $k
    fi
  done
}

clear_branch

