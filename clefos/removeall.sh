#!/bin/sh
cd clefos
original_path=$(pwd)

declare -a blacklist=(base/ origin/ AMHub_Files/)

containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

for x in $(ls -d */)
do
    if [ $(containsElement $x "${blacklist[@]}" ; echo $?) == 1 ]
    then
        echo $x
        cd $x ; make clean ; cd $original_path
    fi
done