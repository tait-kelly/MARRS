#!/bin/bash
PATH=/opt/someApp/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
IP=$1
echo "<!DOCTYPE html>" > $IP.ping.html
echo "<HTML>" >> $IP.ping.html
echo "<body>" >> $IP.ping.html
TODAY="$(date +%Y%m%d%H%M%S)"
STATUS=0
#FIRST LETS DETERMINE WHICH CLASSROOM THIS IS FOR.
if [ "$IP" == "172.17.6.116" ]; then
	ROOM="JRF-0001"
elif [ "$IP" == "172.17.6.117" ]; then
	ROOM="JRF-0002"
fi
FAILED="0"
ping -c 1 $IP|grep 'errors'
if [ "$?" == "0" ]; then
	echo "<body bgcolor="RED">">> $IP.ping.html
	FAILED="1"
	echo "PING FAILED ON DEICE $IP in room $ROOM at $TODAY" >> /home/sysadmin/Documents/errors/$IP.ping.log
fi
if [ "$FAILED" == "0" ]; then
	echo "<body bgcolor="GREEN">">> $IP.ping.html
elif [ "$FAILED" == "1" ]; then
	echo "<body bgcolor="RED">">> $IP.ping.html
	echo "PING FAILED ON DEICE $IP in room $ROOM at $TODAY" >> /home/sysadmin/Documents/errors/$IP.ping.log	
fi		
echo "<br/>" >> $IP.ping.html	
echo "</body>" >> $IP.ping.html
echo "</HTML>" >> $IP.ping.html
#on the server after this script is completed I will need to move the html file to the public files directory of the webserver
#cp $IP.ping.html /var/www/html/sites/default/files/$IP.ping.html
#echo "now the removal from the var folder"
echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/$IP.ping.html
#echo "now the copy"
echo "A+C247srv" | sudo cp $IP.ping.html /var/www/html/sites/default/files/$IP.ping.html
echo "A+C247srv" | sudo cp $IP.ping.html /var/www/html/sites/default/files/$IP.ping.log
rm $IP.ping.html
#clear
