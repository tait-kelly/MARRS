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
                                mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT * from node__field_adhocip" > /home/sysadmin/Documents/adhocs.txt
                                mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT * from node__field_adhocpollingint" > /home/sysadmin/Documents/adhocpolling.txt
				mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT * from node__field_adhocemail" > /home/sysadmin/Documents/adhocemails.txt                        
				#echo "At the counter check"			
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
                                MATCHING=$(grep "$MATCH" adhocpolling.txt)
                                EMAILS1=$(grep "$MATCH	0" adhocemails.txt)
				EMAILS2=$(grep "$MATCH	1" adhocemails.txt)
				EMAILS3=$(grep "$MATCH	2" adhocemails.txt)
				EMAILS4=$(grep "$MATCH	3" adhocemails.txt)
				#echo "the results of the email search is $EMAILS1"
				#echo "The matching is $MATCHING:"
                                POLLING=$(echo "$MATCHING" | cut -d '	' -f 7)
				EMAIL1=$(echo "$EMAILS1	0" | cut -d '	' -f 7)
				EMAIL2=$(echo "$EMAILS2	1" | cut -d '	' -f 7)
                                EMAIL3=$(echo "$EMAILS3	2" | cut -d '	' -f 7)
				EMAIL4=$(echo "$EMAILS4	3" | cut -d '	' -f 7)
				#echo "I now have an IP of $IP and a polling frequency of $POLLING and emails to notify of $EMAIL1 and $EMAIL2 and $EMAIL3 and $EMAIL4"
  		                if (( $COUNTER % $POLLING == 0 )); then
        	                        #echo "LOOKS LIKE $COUNTER is divisible by $POLLING I should take action here"
		                        ./ADHOCCHECK.sh $IP $EMAIL1 $EMAIL2 $EMAIL3 $EMAIL4
                                #else
                                        #echo "LOOKS LIKE $COUNTER is NOT divisible by $POLLING so I will move on"
					clear					                        
				fi
                        done <adhocs.txt
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