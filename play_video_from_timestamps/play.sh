#!/bin/bash
# While being inside this folder type into your Terminal:
# ./play.sh videofilename.mp4
FILE="$(dirname "$(readlink -f "$0")")/timestamps.txt"
VIDEO=$1
x=1
while true
do
  read -p "play: " x
  if [ $x -eq 0 ]
  then 
    break
  elif [ $x -lt 0 ]
  then
    cat $FILE
  else
    filepath=$(head -n $x $FILE | tail -1)
    mpv --fs "$1" --start=$filepath
  fi
  printf "\n"
done
