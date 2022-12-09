#!/bin/bash
PATH=/opt/someApp/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
IP=$1
echo "<!DOCTYPE html>" > $IP.status.html
echo "<HTML>" >> $IP.status.html
echo "<body>" >> $IP.status.html
TODAY="$(date +%Y%m%d%H%M%S)" > $IP.status.txt
STATUS=0
if [ "$IP" == "172.17.6.116" ]; then
	ROOM="JRF-0001"
elif [ "$IP" == "172.17.6.117" ]; then
	ROOM="JRF-0002"
fi
FAILED="ERRORS:"
ping -c 1 $IP|grep 'errors'
if [ "$?" == "0" ]; then
	echo "<body bgcolor="RED">">> $IP.status.html
	echo "The Projector is offline" >> $IP.status.html
	echo "<br/>" >> $IP.status.html	
	STATUS=1
fi
if [ "$STATUS" == "0" ]; then
	echo "<body bgcolor="GREEN">">> $IP.status.html
	echo "The Projector is online" >> $IP.status.html
	echo "<br/>" >> $IP.status.html
	ls /home/sysadmin/Documents/errors |grep $IP.txt
	if [ "$?" == "0" ]; then
		echo "$TODAY:The Previous error(s) have now been resolved" >> /home/sysadmin/Documents/errors/$IP.log		
		rm /home/sysadmin/Documents/errors/$IP.txt
		#echo "now the removal from the var folder"
		echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/$IP.log
		#echo "now the copy"
		echo "A+C247srv" | sudo cp $IP.log /var/www/html/sites/default/files/$IP.log
		sendemail -f sjuit@sju.ca -t tait.kelly@uwaterloo.ca -u Communications Restored in room:$ROOM -m "A Previous issues found in room $ROOM was resolved" -s mail2.nettrac.net:2500 -xu sjuit@sju.ca -xp "?Mm&FdfU" 
	fi
	elif [ "$STATUS" == "1" ]; then
		echo "<body bgcolor="RED">">> $IP.status.html
		ls /home/sysadmin/Documents/errors |grep $IP.txt
		if [ "$?" == "1" ]; then
			sendemail -f sjuit@sju.ca -t tait.kelly@uwaterloo.ca -u Communications failure in room:$ROOM -m "Last AVStatus colection appears to have found an issue in room $ROOM please investigate.$FAILED." -s mail2.nettrac.net:2500 -xu sjuit@sju.ca -xp "?Mm&FdfU"
			echo "$TODAY:There is an error in room $ROOM of:$FAILED" > /home/sysadmin/Documents/errors/$IP.txt	
			echo "$TODAY:There is an error in room $ROOM of:$FAILED" >> /home/sysadmin/Documents/errors/$IP.log
		fi
	fi	
#echo "next is removing the text file"
rm $IP.status.txt
echo "Status report generated:$TODAY" >> $IP.status.html
echo "<br/>" >> $IP.status.html	
echo "</body>" >> $IP.status.html
echo "</HTML>" >> $IP.status.html
#on the server after this script is completed I will need to move the html file to the public files directory of the webserver
#echo "now the removal from the var folder"
echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/$IP.status.html
#echo "now the copy"
echo "A+C247srv" | sudo cp $IP.status.html /var/www/html/sites/default/files/$IP.status.html
rm $IP.status.html
clear
