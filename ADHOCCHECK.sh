#!/bin/bash
PATH=/opt/someApp/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
IP=$1
EMAIL1=$2
EMAIL2=$3
EMAIL3=$4
EMAIL4=$5
TODAY="$(date +%Y-%m-%d.%H:%M:%S)"
#echo "I have emails of $EMAIL1,$EMAIL2,$EMAIL3,$EMAIL4"
echo "Checking IP $IP" >> adhoclog.log
sudo mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT entity_id from node__field_adhoc_ip WHERE field_adhocip_value='$IP'" >adhocentity.txt
FAILED=0
while read -r adhoc
do
        #echo "ADHOC IS $adhoc"
        ADHOC=$adhoc
done <adhocentity.txt
sudo mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT title from node_field_data WHERE nid='$ADHOC'" > title.txt
while read -r title
do
        #echo "ADHOC IS $adhoc"
        TITLE=$title
done <title.txt
#Below 6 Lines where added on September 22nd, 2021
sudo mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT body_value from node__body WHERE entity_id='$ADHOC'" > body.txt
while read -r body
do
        #echo "ADHOC IS $adhoc"
        BODY=$body
done <body.txt
#echo "ADHOC is now $ADHOC"
ping -c 10 $IP|grep "100% packet loss" >NUL
if [ "$?" == "0" ]; then
        FAILED=1
        #echo "Looks like we have a failure at $IP"
fi
if [ "$FAILED" == "1" ]; then
        #echo "Looks like there was a failure at IP $IP"
        ls /home/sysadmin/Documents/errors | grep $IP.txt
        if [ "$?" == "1" ]; then
                #echo "Looks Like I should be sending and email now"
                #Send email notification to all emails that are entered
                if [ "$EMAIL1" != "" ]; then
                        sendemail -f sjuit@sju.ca -t $EMAIL1 -u ADHOC MONITORING OF DEVICE $IP FAILED -m "Monitoring of ADHOC device:$TITLE at ip $IP is down.This device has a description of:$BODY" -s mail2.nettrac.net:2500 -xu sjuit@sju.ca -xp "?Mm&FdfU" #Added Body description in email on September 22, 2021
                fi
                if [ "$EMAIL2" != "" ]; then
                        sendemail -f sjuit@sju.ca -t $EMAIL2 -u ADHOC MONITORING OF DEVICE $IP FAILED -m "Monitoring of ADHOC device:$TITLE at ip $IP is down.This device has a description of:$BODY" -s mail2.nettrac.net:2500 -xu sjuit@sju.ca -xp "?Mm&FdfU" #Added Body description in email on September 22, 2021
                fi
                if [ "$EMAIL3" != "" ]; then
                        sendemail -f sjuit@sju.ca -t $EMAIL3 -u ADHOC MONITORING OF DEVICE $IP FAILED -m "Monitoring of ADHOC device:$TITLE at ip $IP is down.This device has a description of:$BODY" -s mail2.nettrac.net:2500 -xu sjuit@sju.ca -xp "?Mm&FdfU" #Added Body description in email on September 22, 2021
                fi
                if [ "$EMAIL4" != "" ]; then
                        sendemail -f sjuit@sju.ca -t $EMAIL4 -u ADHOC MONITORING OF DEVICE $IP FAILED -m "Monitoring of ADHOC device:$TITLE at ip $IP is down.This device has a description of:$BODY" -s mail2.nettrac.net:2500 -xu sjuit@sju.ca -xp "?Mm&FdfU" #Added Body description in email on September 22, 2021
                fi
                echo "ERROR Logged and notification send at $TODAY" > /home/sysadmin/Documents/errors/$IP.txt
                sudo mysql drupal --batch -u root -p"A+C247srv" -e "UPDATE node__field_status SET field_status_value= '0' WHERE entity_id='$ADHOC'"
                sudo mysql drupal --batch -u root -p"A+C247srv" -e "UPDATE node__field_lastofflinedt SET field_lastofflinedt_value= '$TODAY' WHERE entity_id='$ADHOC'"
        fi
fi
if [ "$FAILED" == "0" ]; then
        #echo "Im going to check for the file $IP.txt now"
        ls /home/sysadmin/Documents/errors |grep $IP.txt
        if [ "$?" == "0" ]; then
                #echo "Im removing the file and updating the DB now"
                rm /home/sysadmin/Documents/errors/$IP.txt
                #echo "the file was just removed now for the database"
                sudo mysql drupal --batch -u root -p"A+C247srv" -e "UPDATE node__field_status SET field_status_value= '1' WHERE entity_id='$ADHOC'"
        fi
fi
sudo mysql drupal --batch -u root -p"A+C247srv" -e "TRUNCATE cache_entity"
sudo mysql drupal --batch -u root -p"A+C247srv" -e "TRUNCATE cache_render"
sudo mysql drupal --batch -u root -p"A+C247srv" -e "TRUNCATE cache_data"
#clear
