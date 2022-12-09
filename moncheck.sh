#!/bin/bash
#check for classrooms script running
ps -ef | grep classrooms.sh| grep -v grep|grep -v /bin/bash
#error check of 0 means the script is running and 1 means it is not running
if [ "$?" == "1" ]; then
	#script is not running and an email needs to be sent to notify someone
	sendemail -f sjuit@sju.ca -t tait.kelly@uwaterloo.ca -u Monitoring Server script is not running -m "It appears the classroom monitoring script is not currently running. Please investigate ASAP." -s mail2.nettrac.net:2500 -xu sjuit@sju.ca -xp "?Mm&FdfU"
	echo "I just emailed as the script is not running" >> /home/sysadmin/Documents/moncheck.txt 
fi
ps -ef | grep SERVICES.sh| grep -v grep|grep -v /bin/bash
#error check of 0 means the script is running and 1 means it is not running
if [ "$?" == "1" ]; then
	#script is not running and an email needs to be sent to notify someone
	sendemail -f sjuit@sju.ca -t tait.kelly@uwaterloo.ca -u SERVICES Monitoring Server script is not running -m "It appears the services monitoring script is not currently running. Please investigate ASAP." -s mail2.nettrac.net:2500 -xu sjuit@sju.ca -xp "?Mm&FdfU"
	echo "I just emailed as the services script is not running" >> /home/sysadmin/Documents/moncheck.txt
fi
ps -ef | grep ADHOCS.sh| grep -v grep|grep -v /bin/bash
#error check of 0 means the script is running and 1 means it is not running
if [ "$?" == "1" ]; then
	#script is not running and an email needs to be sent to notify someone
	sendemail -f sjuit@sju.ca -t tait.kelly@uwaterloo.ca -u ADHOC Monitoring Server script is not running -m "It appears the ADHOC monitoring script is not currently running. Please investigate ASAP." -s mail2.nettrac.net:2500 -xu sjuit@sju.ca -xp "?Mm&FdfU"
	echo "I just emailed as the services script is not running" >> /home/sysadmin/Documents/moncheck.txt
fi
