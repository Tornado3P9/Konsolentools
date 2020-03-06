#!/bin/bash
FILE="$(dirname "$(readlink -f "$0")")/Youtube-Video-Playlist.txt"
awk '0 == (NR + 1) % 2' $FILE
echo ""
read -p "Enter Playlist Number: "  line
if [ "$line" -eq "$line" ] 2> /dev/null
  then
  ytformat='bestvideo[height<=1080][fps<=30][vcodec!=vp9]+bestaudio/best'
  line=$(( line*2 ))
  filepath=$(head -n $line $FILE | tail -1)
  echo "--press ENTER to ignore questions--"
  echo ""
  read -p "Playlist Start At Last Stop? [Y/n]: " plresume
  if [ "$plresume" == "n" ]; then
    read -p "List all Playlist Items? [Y/n]: " printplaylist
    if [ "$printplaylist" != "n" ]; then
      #echo ${string:position:length}
      if [ "${filepath:0:6}" == "https:" ]; then
        echo ""
        youtube-dl -j --flat-playlist "$filepath" | jq -r '.title + "\nhttps://youtu.be/" + .id'
      else
        cat $filepath && echo ""
      fi
    fi
    echo ""
    read -p "Playlist Start At Video Nr.: " plstart
    echo ""
    if [ "$plstart" -eq "$plstart" ] 2> /dev/null
    then
      mpv --fs --ytdl-format=$ytformat --no-resume-playback --save-position-on-quit --playlist-start=$((plstart-1)) "$filepath" --screenshot-template="%F:%p"
    else
      mpv --fs --ytdl-format=$ytformat --no-resume-playback --save-position-on-quit "$filepath" --screenshot-template="%F:%p"
    fi
  else
    echo ""
    read -p "Playlist Start At Video Nr.: " plstart
    echo ""
    if [ "$plstart" -eq "$plstart" ] 2> /dev/null
    then
      mpv --fs --ytdl-format=$ytformat --save-position-on-quit --playlist-start=$((plstart-1)) "$filepath" --screenshot-template="%F:%p"
    else
      mpv --fs --ytdl-format=$ytformat --save-position-on-quit "$filepath" --screenshot-template="%F:%p"
    fi
  fi
fi
exit