#!/bin/bash
COUNTER=59
NEVER_QUIT=NO
while [ "$NEVER_QUIT" == "NO" ]
do
	COUNTER=$((COUNTER+1))
	clear	
	HOUR=$(date +%H)
    MIN=$(date +%M)
    DAY=$(date +%u)
    if [ "$DAY" -lt "6" ]; then
		if [ "$HOUR" -gt "5" -a "$HOUR" -lt "23" ]; then
			#echo "Counter is $COUNTER"
            if (($COUNTER % 5  == 0 )); then
                echo time to grab the ADHOCS
				sudo mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT * from node__field_adhoc_ip" > /home/sysadmin/Documents/adhocs.txt
                sudo mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT * from node__field_adhoc_scan_interval" > /home/sysadmin/Documents/adhocpolling.txt
				sudo mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT * from node__field_adhoc_email_notification_1" > /home/sysadmin/Documents/adhocemails.txt
				sudo mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT * from node__field_adhoc_email_notification_2" >> /home/sysadmin/Documents/adhocemails.txt
				sudo mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT * from node__field_adhoc_email_notification_3" >> /home/sysadmin/Documents/adhocemails.txt				
				#echo "At the counter check"
				read -p "Press enter to continue"
			fi
            while read -r line; do
				clear                                
				#echo "the line is $line"
				IP=$(echo "$line" | cut -d '	' -f 7)
	            #echo "IP is $IP"
                MATCH=$(echo "$line" | cut -d '	' -f 1,2,3,4,5)
                #echo "Match is $MATCH"
	            #echo "Line is now $line"
                #echo "$MATCH" |grep select adhocpolling.txt
	            #echo "above was the seach for the matching string"
                MATCHING=$(grep "$MATCH" /home/sysadmin/Documents/adhocpolling.txt)
                EMAILS1=$(grep "$MATCH	0" /home/sysadmin/Documents/adhocemails.txt)
				EMAILS2=$(grep "$MATCH	1" /home/sysadmin/Documents/adhocemails.txt)
				EMAILS3=$(grep "$MATCH	2" /home/sysadmin/Documents/adhocemails.txt)
				#echo "the results of the email search is $EMAILS1"
				#echo "The matching is $MATCHING:"
				POLLING=$(echo "$MATCHING" | cut -d '	' -f 7)
				EMAIL1=$(echo "$EMAILS1	0" | cut -d '	' -f 7)
				EMAIL2=$(echo "$EMAILS2	1" | cut -d '	' -f 7)
				EMAIL3=$(echo "$EMAILS3	2" | cut -d '	' -f 7)
				#echo "I now have an IP of $IP and a polling frequency of $POLLING and emails to notify of $EMAIL1 and $EMAIL2 and $EMAIL3 and $EMAIL4"
  		        if (( $COUNTER % $POLLING == 0 )); then
					#echo "LOOKS LIKE $COUNTER is divisible by $POLLING I should take action here"
		            echo time to call the check for the ADHOC with parameters $IP $EMAIL1 $EMAIL2 $EMAIL3
					read -p "Press enter to continue"
					./ADHOCCHECK.sh $IP $EMAIL1 $EMAIL2 $EMAIL3
                #else
						#echo "LOOKS LIKE $COUNTER is NOT divisible by $POLLING so I will move on"
					clear					                        
				fi
            done </home/sysadmin/Documents/adhocs.txt
			clear                
			sleep 55
        fi
    fi
    if [ "$DAY" -gt "5" ]; then
		#echo "Sleeping for 6 hours"
        sleep 6h
    fi
    clear
	COUNTER=$((COUNTER+1))
done
