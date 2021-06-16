#!/bin/bash
# All files need to be in the same folder!
# While being inside this folder type into your Terminal:
# ./play.sh videofilename.mp4
#
# To show the list, type -1
# To go with the first item in your list, type 1
# To go with the third item in your list, type 3
# To exit the program, type 0
# 
# If you want the timestamp.txt to be more simple, say you want to have the timestamps only
# and no comments, then you can do that, but you also have to delete the code line
# "line=$(( line*2 ))" from this script because it ignores every second line.
FILE="$(dirname "$(readlink -f "$0")")/timestamp_list.txt"
VIDEO=$1
line=1
while true
do
  read -p "play: " line
  line=$(( line*2 ))
  if [ $line -eq 0 ]
  then 
    break
  elif [ $line -lt 0 ]
  then
    cat $FILE
  else
    timestamp=$(head -n $line $FILE | tail -1)
    mpv --fs "$1" --start=$timestamp
  fi
  printf "\n"
done
