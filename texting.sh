COUNTER=0
NEVER_QUIT=NO
while [ "$NEVER_QUIT" == "NO" ]
do
	COUNTER=$((COUNTER+1))
	HOUR=$(date +%H)
	MIN=$(date +%M)
	DAY=$(date +%u)
	if [ "$DAY" -lt "6" ]; then	
		if [ "$HOUR" -gt "5" -a "$HOUR" -lt "23" ]; then
			#echo "Counter is $COUNTER"
			if (($COUNTER % 60 == 0 )); then
				mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT * from node__field_serviceip" > /home/sysadmin/Documents/services.txt
				mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT * from node__field_service_polling_frequency" > /home/sysadmin/Documents/polling.txt
			fi
			while read -r line; do
				#echo "the line is $line"
				IP=$(echo "$line" | cut -d '	' -f 7)
				#echo "IP is $IP"
				MATCH=$(echo "$line" | cut -d '	' -f 1,2,3,4,5,6) 
				#echo "Match is $MATCH"
				#echo "Line is now $line"
				#echo "$MATCH" |grep select polling.txt
				#echo "above was the seach for the matching string"
				MATCHING=$(grep "$MATCH" polling.txt)
				#echo "The matching is $MATCHING:"
				POLLING=$(echo "$MATCHING" | cut -d '	' -f 7)
				#echo "I now have an IP of $IP and a polling frequency of $POLLING."
				if (( $COUNTER % $POLLING == 0 )); then
					#echo "LOOKS LIKE $COUNTER is divisible by $POLLING I should take action here"
					./SERVICESPING.sh $IP
				else
					#echo "LOOKS LIKE $COUNTER is NOT divisible by $POLLING so I will move on"
				fi
			done <services.txt
		sleep 55 
		fi
	fi
	if [ "$DAY" -gt "5" ]; then
		#echo "Sleeping for 6 hours"		
		sleep 6h	
	fi
	clear
done
