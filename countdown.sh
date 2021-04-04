#!/bin/bash 
#https://github.com/tomxue/countdown
#https://linuxconfig.org/time-countdown-bash-script-example
#
#This is a simple skeleton of a bash countdown script.
#The script takes two arguments.
#
#Here are some examples of its usage:
#1. countdown time to 90 minutes from now:
#./bash-countdown.sh -m 90
#2. countdown time to 23.3.2036 from now:
#./bash-countdown.sh -d "Mar 23 2036"
#3. countdown time to 21:06 from now:
#./bash-countdown.sh -d 21:06
#4. countdown time to 21:06:45 from now and play ringtone using mpv-player:
#./bash-countdown.sh -d 21:06:45 && mpv ringtone.mp3
#
#Do not forget to make bash-countdown.sh script executable before execution:
#$ chmod +x countdown.sh
#
#Exectute:
#$ ./countdown.sh -d 08:50
#Output:
#Fri Apr 10 08:47:46 AEST 2015
#----------------------------
#Seconds: 13
#Minutes: 2
#Hours: 0
#Days: 0
#Weeks: 0
#[========>                                         ]12%
 
if [ "$#" -lt "2" ] ; then 
	echo "Incorrect usage ! Example:" 
	echo './countdown.sh -d  "Jun 10 2011 16:06"' 
	echo 'or' 
	echo './countdown.sh -m  90' 
	exit 1 
fi 
 
now=`date +%s` 
 
if [ "$1" = "-d" ] ; then 
	until=`date -d "$2" +%s` 
	sec_rem=`expr $until - $now` 
	echo "-d" 
	if [ $sec_rem -lt 1 ]; then 
		echo "$2 is already history !" 
	fi 
fi 
 
if [ "$1" = "-m" ] ; then 
	until=`expr 60 \* $2` 
	until=`expr $until + $now` 
	sec_rem=`expr $until - $now` 
	echo "-m" 
	if [ $sec_rem -lt 1 ]; then 
		echo "$2 is already history !" 
	fi 
fi 
 
_R=0
_C=7
tmp=0
percent=0
total_time=0
col=`tput cols`
col=$[ $col -5 ]

while [ $sec_rem -gt 0 ]; do 
	clear 
	date 
	let sec_rem=$sec_rem-1 
	interval=$sec_rem 
	seconds=`expr $interval % 60` 
	interval=`expr $interval - $seconds` 
	minutes=`expr $interval % 3600 / 60` 
	interval=`expr $interval - $minutes` 
	hours=`expr $interval % 86400 / 3600` 
	interval=`expr $interval - $hours` 
	days=`expr $interval % 604800 / 86400` 
	interval=`expr $interval - $hours` 
	weeks=`expr $interval / 604800` 
	echo "----------------------------" 
	echo "Seconds: " $seconds 
	echo "Minutes: " $minutes 
	echo "Hours:   " $hours 
	echo "Days:    " $days 
	echo "Weeks:   " $weeks 

	echo -n "["

	progress=$[$progress + 1]
	if [ $total_time -lt 1 ] ; then
		total_time=$[$hours * 3600 + $minutes * 60 + $seconds]
	fi
	
	printf -v f "%$(echo $_R)s>" ; printf "%s\n" "${f// /=}"
	_C=7
	tput cup 7 $col

	tmp=$percent
	percent=$[$progress * 100 / $total_time]
	printf "]%d%%" $percent
	change=$[$percent - $tmp]

	_R=$[ $col * $percent / 100 ]

	sleep 1
done
printf "\n"
