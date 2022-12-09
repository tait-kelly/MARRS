#!/bin/bash
PATH=/opt/someApp/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#AVStatus IP
#This will check for the controller being up then the uptime then the program uptime then get the IP table and the Threads running

#Imporvements: separate and set background based on conditions of IPT offiline devices and Threadpool too high
IP=$1
echo "<!DOCTYPE html>" > $IP.ping.html
echo "<HTML>" >> $IP.ping.html
echo "<body>" >> $IP.ping.html
TODAY="$(date +%Y-%m-%d.%H:%M:%S)"


#FIRST LETS DETERMINE WHICH CLASSROOM THIS IS FOR.
if [ "${IP:(-3)}" == ".40" ]; then
	ROOM="SJ2-1002"
elif [ "${IP:(-3)}" == ".50" ]; then
	ROOM="SJ2-2002"
elif [ "${IP:(-3)}" == ".60" ]; then
	ROOM="SJ2-2007"
elif [ "${IP:(-3)}" == ".70" ]; then
	ROOM="SJ2-2003"
elif [ "${IP:(-3)}" == ".80" ]; then
	ROOM="SJ2-2001"
elif [ "${IP:(-3)}" == ".90" ]; then
	ROOM="SJ2-1004"
elif [ "${IP:(-3)}" == "120" ]; then
	ROOM="SH-Board"
elif [ "${IP:(-3)}" == "130" ]; then
	ROOM="SJ1-CHAPEL"
elif [ "${IP:(-3)}" == "140" ]; then
	ROOM="SJ1-2009"
elif [ "${IP:(-3)}" == "160" ]; then
	ROOM="SJ1-2011"
elif [ "${IP:(-3)}" == "170" ]; then
	ROOM="SJ1-LAB"
elif [ "${IP:(-3)}" == "180" ]; then
	ROOM="SJ1-3012"
elif [ "${IP:(-3)}" == "190" ]; then
	ROOM="SJ1-3013"
elif [ "${IP:(-3)}" == "200" ]; then
	ROOM="SJ1-3014"
elif [ "${IP:(-3)}" == "210" ]; then
	ROOM="SJ1-3015"
elif [ "${IP:(-3)}" == "220" ]; then
	ROOM="SJ1-3016"
elif [ "${IP:(-3)}" == "230" ]; then
	ROOM="SJ1-3020"
elif [ "${IP:(-3)}" == "240" ]; then
	ROOM="SJ1-3027"
elif [ "${IP:(-3)}" == ".30" ]; then
        ROOM="SJ3-0001"
elif [ "${IP:(-3)}" == "110" ]; then
        ROOM="SJ3-0003"
fi
FAILED="0"
ping -c 1 $IP|grep 'errors'
if [ "$?" == "1" ]; then
	SPECIAL=0
	PRJCOUNT=1	
	IPLEN=$(echo -n $IP | wc -m)
	if [ "$IPLEN" == "11" ]; then
		if [ "${IP:(-2)}" == "90" ]; then
			SPECIAL=1		
		fi
		if [ "${IP:(-2)}" == "40" ]; then
			PRJCOUNT=2		
		fi
		if [ "${IP:(-2)}" == "50" ]; then
			PRJCOUNT=2		
		fi
		#echo "Looks like this is a SJ2 room"
		BUILDING=2
		if [ "${IP:(-2)}" == "30" ]; then
			BUILDING=3
		fi
	fi
	if [ "$IPLEN" == "12" ]; then
		if [ "${IP:(-3)}" == "120" ]; then
			SPECIAL=1		
		fi
		if [ "${IP:(-3)}" == "130" ]; then
			SPECIAL=1		
		fi
		if [ "${IP:(-3)}" == "160" ]; then
			SPECIAL=1		
		fi
		if [ "${IP:(-3)}" == "200" ]; then
			PRJCOUNT=2		
		fi
		#echo "Looks like this is a SJ1 room"
		BUILDING=1
	fi
	if [ "$SPECIAL" == "0" ]; then
		#echo "I am in the standard classroom configuration"
		TSW1="${IP%?}1"		
		PC1="${IP%?}8"
		PRJ1="${IP%?}4"
		NPSU="${IP%?}9"
		ping -c 1 $PC1
		if [ "$?" == "1" ]; then
			FAILED="1"
		fi	
		ping -c 1 $PRJ1
		if [ "$?" == "1" ]; then
			FAILED="1"
		fi	
		ping -c 1 $NPSU
		if [ "$?" == "1" ]; then
			FAILED="1"
		fi	
		if [ "$BUILDING" == "2" ]; then
			DIP31="${IP%?}3"
			ping -c 1 $DIP31
			if [ "$?" == "1" ]; then
				FAILED="1"
			fi			
		fi
		if [ "$PRJCOUNT" == "2" ]; then
			PRJ2="${IP%?}5"
			ping -c 1 $PRJ2
			if [ "$?" == "1" ]; then
				FAILED="1"
			fi	
		fi
	fi		
	if [ "$ROOM" == "SJ2-1004" ]; then
		# need to check all IP table entries for the room.
		PC1="${IP%?}9"
		PC2="${IP%??}101"
		TSW1="${IP%?}3"
		TSW2="${IP%?}7"
		PRJ1="${IP%?}4"
		PRJ2="${IP%?}5"
		NPSU="${IP%?}8"
		#echo the IP of the controller should still be $IP
		ping -c 1 $PC1|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $PC2|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $TSW1|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $TSW2|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $PRJ1|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $PRJ2|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $NPSU|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
	fi
	if [ "${IP:(-3)}" == "120" ]; then
		#echo "I am in the boardroom check now"		
		#This is for the Boardroom checks Need to check IPID's 7-DSP, 9-Prj, 8-TV,6-201,14-SCALER,F9-BOSCH
		PC1="${IP%?}8"
		PRJ1="${IP%?}4"
		TSW1="${IP%?}1"
		TV1="${IP%?}5"
		NPSU="${IP%?}9"
		DSP="${IP%?}3"
		ping -c 1 $PC1|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $TSW1|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $PRJ1|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $TV1|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $NPSU|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi
		ping -c 1 $DSP|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
	fi
	if [ "${IP:(-3)}" == "130" ]; then
		#This is for the Chapel Checks 26-MP-B10,25-MD6x4,21-TV1,22-TV2,23-TV3,24-DSP,5-RMC-100,6-RMC-100,14-RMC-100
		PC1="${IP%?}8"
		TV1="${IP%?}4"
		TV2="${IP%?}5"
		#TV3="${IP%?}6"
		VIA1="172.25.52.36"
		DMMD="${IP%?}3"
		DSP="${IP%?}7"
		ping -c 1 $PC1|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $TV1|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $TV2|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $VIA1|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi
		ping -c 1 $DMMD|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi
		ping -c 1 $DSP|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi

	fi	
	if [ "${IP:(-3)}" == "160" ]; then
		#This is for the 2011 check 5-MD6x6,12-TV1,11-Projector,13-TV2,14-TV3,15-TV4,OF-DSP,16-ViaCampus,17-ViaConnect1,18-ViaConnect2,19-ViaConnect3,1A-ViaConnect4
		PC1="${IP%?}8"
		TV1="${IP%?}3"
		TV2="${IP%?}5"
		TV3="${IP%?}6"
		TV4="${IP%?}7"
		PRJ1="${IP%?}4"
		NPSU="${IP%???}151"
		VIA0="129.97.122.60"
		VIA1="129.97.122.61"
		VIA2="129.97.122.62"
		VIA3="129.97.122.63"
		VIA4="129.97.122.64"
		#DSP="${IP%?}2"
		DMMD="${IP%?}2"
		TSW="${IP%?}1"
		ping -c 1 $PC1|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $TV1|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $TV2|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $TV3|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $TV4|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi
		ping -c 1 $PRJ1|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $NPSU|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi	
		ping -c 1 $VIA0|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi
		ping -c 1 $VIA1|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi
		ping -c 1 $VIA2|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi
		ping -c 1 $VIA3|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi
		ping -c 1 $VIA4|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi
		#Removing DSP as it was eliminated with Controller change
		#ping -c 1 $DSP|grep 'errors'
		#if [ "$?" == "0" ]; then
		#	FAILED="1"
		#fi
		ping -c 1 $DMMD|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi
		ping -c 1 $TSW|grep 'errors'
		if [ "$?" == "0" ]; then
			FAILED="1"
		fi

				
	fi

		

else
	echo "<body bgcolor="RED">">> $IP.ping.html
	FAILED="1"
	./wolallclassrooms.sh
	echo "PING FAILED ON DEICE $IP in room $ROOM at $TODAY" >> /home/sysadmin/Documents/errors/$IP.ping.log
fi
ls /home/sysadmin/Documents/errors |grep $IP.txt
if [ "$?" == "0" ]; then
	FAILED="1"
	./wolallclassrooms.sh
	echo "A Preexisting communications error from a full scan was found for room $ROOM at $TODAY" >> /home/sysadmin/Documents/errors/$IP.ping.log
fi
if [ "$FAILED" == "0" ]; then
	echo "<body bgcolor="GREEN">">> $IP.ping.html
elif [ "$FAILED" == "1" ]; then
	echo "<body bgcolor="RED">">> $IP.ping.html
	./wolallclassrooms.sh
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
