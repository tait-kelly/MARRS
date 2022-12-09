#!/bin/bash
IP=$1
FAILED="0"
TODAY="$(date +%Y-%m-%d.%H:%M:%S)"
echo "Checking IP $IP" >> adhoclog.log
sudo mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT entity_id from node__field_adhocip WHERE field_adhocip_value='$IP'" >adhocentity.txt
FAILED=0
while read -r adhoc
do
	echo "ADHOC IS $adhoc"
	ADHOC=$adhoc
done <adhocentity.txt
ping -c 2 $IP|grep '100% packet loss'
if [ "$?" == "0" ]; then
	FAILED="1"
fi
#echo "Failed is $FAILED"
if [ "$FAILED" == "1" ]; then
	ls /home/sysadmin/Documents/errors |grep $IP.txt
	if [ "$?" == "0" ]; then
		echo "file is there already"	
	fi
	ls /home/sysadmin/Documents/errors |grep $IP.txt
	if [ "$?" == "1" ]; then
		#echo "I am going to send an email now"
		sendemail -f sjuit@sju.ca -t tait.kelly@uwaterloo.ca -u Communications failure on Device:$IP -m "PING CHECK HAS FAILED ON DEVICE WITH IP $IP. PLEASE INVESITGATE" -s mail2.nettrac.net:2500 -xu sjuit@sju.ca -xp "?Mm&FdfU"
		echo "$TODAY:There is an error on Device $IP." >> /home/sysadmin/Documents/errors/$IP.log
		echo "$TODAY:There is an error on Device $IP." >> /home/sysadmin/Documents/errors/$IP.txt
		sudo mysql drupal --batch -u root -p"A+C247srv" -e "UPDATE node__field_status SET field_status_value= '0' WHERE entity_id='$ADHOC'"
	fi
fi	
if [ "$FAILED" == "0" ]; then
	ls /home/sysadmin/Documents/errors |grep $IP.txt
	if [ "$?" == "0" ]; then
		rm /home/sysadmin/Documents/errors/$IP.txt
		sudo mysql drupal --batch -u root -p"A+C247srv" -e "UPDATE node__field_status SET field_status_value= '1' WHERE entity_id='$adhoc'"
	fi
fi
sudo mysql drupal --batch -u root -p"A+C247srv" -e "TRUNCATE cache_entity"
sudo mysql drupal --batch -u root -p"A+C247srv" -e "TRUNCATE cache_render"
