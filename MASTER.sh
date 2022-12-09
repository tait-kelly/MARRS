#!/bin/bash
PATH=/opt/someApp/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#This Script will be the master script that will restart the monitoring scripts Between 11:30PM and 11:45PM M-F
#Versioning
#1.0 
#Initial script this will restart the master scripts between 11:30PM and 11:45PM on week Nights
#kill the gnome-shell as well to release the resoursed on Tuesday nights

NEVER_QUIT=NO
while [ "$NEVER_QUIT" == "NO" ]
do
	HOUR=$(date +%H)
	MIN=$(date +%M)
	DAY=$(date +%u)
	if [ "$DAY" -lt "6" ]; then
		if [ "$HOUR" == "23" ]; then
			if [ "$MIN" -gt "30" -a "$MIN" -lt "45" ]; then
				if [ "$DAY" == "2" ]; then
					killall -3 gnome-shell
				fi
				#This is when I need to restart the scripts
				#First I need to kill the existing ones
				killall -3 classrooms.sh
				killall -3 SERVICES.sh
				killall -3 ADHOCS.sh
				#Next I need to start the new ones in a new window
				#I need to determine if I need to run this in a new window or not but I believe I will need to
				/home/sysadmin/Documents/EXACQCLEANUP.sh & /home/sysadmin/Documents/classrooms.sh & /home/sysadmin/Documents/SERVICES.sh & /home/sysadmin/Documents/ADHOCS.sh
				sleep 7h
			fi		
		fi
		sleep 55
	fi
	if [ "$DAY" -gt "0" ]; then
		if [ "$HOUR" == "22" ]; then
			if [ "$MIN" -gt "30" -a "$MIN" -gt "45" ]; then
				/home/sysadmin/Documents/EXACQCLEANUP.sh
				sleep 1000
			fi
		fi
	fi
done
