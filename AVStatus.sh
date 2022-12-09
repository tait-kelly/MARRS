#!/bin/bash
PATH=/opt/someApp/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#AVStatus IP
#This will check for the controller being up then the uptime then the program uptime then get the IP table and the Threads running

#Imporvements: separate and set background based on conditions of IPT offiline devices and Threadpool too high
IP=$1
echo "<!DOCTYPE html>" > $IP.status.html
echo "<HTML>" >> $IP.status.html
echo "<body>" >> $IP.status.html
TODAY="$(date +%Y-%m-%d.%H:%M:%S)" > $IP.status.txt
HELP="Additional troubleshooting:"
#FIRST LETS DETERMINE WHICH CLASSROOM THIS IS FOR.
TSWOFF="TSW Offline: Most time this will require the touchpanel to be power cycled by disconnecting the network connection and then reconnecting"
PRJOFF="Projector Offline:After extended periods of standby the projectors sometimes loose connection with the controller but the web inteface is often still online. Check the web interface and if accessible, turn the projector on then off after it has warmed up and it should reconnect to the controller."
PRJOFF="Projector Offline:After extended periods of standby the projectors sometimes loose connection with the controller but the web inteface is often still online. Check the web interface and if accessible, turn the projector on then off after it has warmed up and it should reconnect to the controller."
DMTX401COFF="DM-TX-401-C Offline:The 401 can be controlled through the NPSU web interface login to the NPSU and then power cycle the device- restart can take about 5 min before it comes online, if it is still not working there could be a physical issue with the device and will need to be investigated."
DMTX201COFF="DM-TX-201-C Offline:The 201 will need to be power cycled- restart can take about 5 min before it comes online, if it is still not working there could be a physical issue with the device and will need to be investigated."
PCOFF="PC Offline:The PC will sometimes goes offline when a shutdown is performed in the classroom or a restart, typically the PC will come back online or automatically start but if the PC is not back online within 5 minutes please investigate."
NPSUOFF="NPSU Offline:This is not a critical component but will need to be physically investigated when the classroom is availible."
DIP31OFF="DIP31 Offline:This is the system that switches between the PC and the DVD player, please check the physical connections and reboot as needed."
RMCOFF="RMC Offline:This is a digital media reciever for the AV signal and is connected to a projector or TV typcially powered by the controller disconnecting the network cable should fix the issue if it does not restart the controller."
DSPOFF="DSP Offline: This is the sound system for the room. You wil need to physically restart the device and may need to restart the Crestron controller after to get communications back online."
TVOFF="TV Offline:TV's have been going offline typcially from a software issue on the TV. If the TV is still availible via PING it may have lost it's connection to the controller start by restarting the controller, if still not resolved the TV will have to be factory reset so see the technote for doing this."
SCALEROFF="Scaler Offline:This is a device that scales images to a standard resolution, if this is offline restarting the controller should resolve the issue."
BOSCHMICSOFF="Bosch Mics Offline: This will need a physical restart to resolve the issue."
MBB10OFF="MPB-B10 Offline:This is an old touchpanel in the Chapel that is not used frequently so it is not critical but when time allows a physical restart should resolve the issue."
VIAOFF="VIA Offline:If the Via is offline with the controller but the web interface is still up a restart of the device should resolve the issue. If not resolved from a restart restarting the controller may be required."
MD6X6OFF="DM-MD6x6 Offline:This is the video router for the room, physically restarting this should resolve the issue but restarting the controller after the DM-MD6x6 is restarted may be required."
MD16X16OFF="DM-MD16x16 Offline:This is the video router for the room, physically restarting this should resolve the issue but restarting the controller after the DM-MD16x16 is restarted may be required."

if [ "${IP:(-3)}" == ".40" ]; then
	ROOM="SJ2-1002"
	ENTITYID=13
elif [ "${IP:(-3)}" == ".50" ]; then
	ROOM="SJ2-2002"
	ENTITYID=16
elif [ "${IP:(-3)}" == ".60" ]; then
	ROOM="SJ2-2007"
	ENTITYID=18
elif [ "${IP:(-3)}" == ".70" ]; then
	ROOM="SJ2-2003"
	ENTITYID=17
elif [ "${IP:(-3)}" == ".80" ]; then
	ROOM="SJ2-2001"
	ENTITYID=15
elif [ "${IP:(-3)}" == ".90" ]; then
	ROOM="SJ2-1004"
	ENTITYID=14
elif [ "${IP:(-3)}" == "120" ]; then
	ROOM="SH-Board"
	ENTITYID=20
elif [ "${IP:(-3)}" == "130" ]; then
	ROOM="SJ1-CHAPEL"
	ENTITYID=19
elif [ "${IP:(-3)}" == "140" ]; then
	ROOM="SJ1-2009"
	ENTITYID=2
elif [ "${IP:(-3)}" == "160" ]; then
	ROOM="SJ1-2011"
	ENTITYID=5
elif [ "${IP:(-3)}" == "170" ]; then
	ROOM="SJ1-LAB"
	ENTITYID=21
elif [ "${IP:(-3)}" == "180" ]; then
	ROOM="SJ1-3012"
	ENTITYID=6
elif [ "${IP:(-3)}" == "190" ]; then
	ROOM="SJ1-3013"
	ENTITYID=7
elif [ "${IP:(-3)}" == "200" ]; then
	ROOM="SJ1-3014"
	ENTITYID=8
elif [ "${IP:(-3)}" == "210" ]; then
	ROOM="SJ1-3015"
	ENTITYID=9
elif [ "${IP:(-3)}" == "220" ]; then
	ROOM="SJ1-3016"
	ENTITYID=10
elif [ "${IP:(-3)}" == "230" ]; then
	ROOM="SJ1-3020"
	ENTITYID=11
elif [ "${IP:(-3)}" == "240" ]; then
	ROOM="SJ1-3027"
	ENTITYID=12
elif [ "${IP:(-3)}" == ".30" ]; then
	ROOM="SJ3-0001"
elif [ "${IP:(-3)}" == "110" ]; then
	ROOM="SJ3-0003"
fi

FAILED="ERRORS:"
ping -c 1 $IP|grep 'errors'
if [ "$?" == "1" ]; then
	sshpass -p 'A+C247av' ssh -o StrictHostKeyChecking=no sysadmin@$IP 'uptime' >> $IP.status.txt
	sshpass -p 'A+C247av' ssh -o StrictHostKeyChecking=no sysadmin@$IP 'Proguptime' >> $IP.status.txt
	sshpass -p 'A+C247av' ssh -o StrictHostKeyChecking=no sysadmin@$IP 'IPT' >> $IP.status.txt
	sshpass -p 'A+C247av' ssh -o StrictHostKeyChecking=no sysadmin@$IP 'ThreadPoolInfo' >> $IP.status.txt
	STATUS=0
	#now that I have got all the data from the controller it's time to parse it for easier ingestion and build the HTML
#	echo "<body bgcolor="GREEN">">> $IP.status.html
	#first check for the system up time by the string 'The system has been running for'
	grep 'The system has been running for' $IP.status.txt >> $IP.status.html
	echo "<br/>" >> $IP.status.html
	#Next check how long the program has been running for by the string 'The program has been running for'
	grep 'The program has been running for' $IP.status.txt >> $IP.status.html
	echo "<br/>" >> $IP.status.html	
	#Next will be checking for the IP table entries This will require identifing if it is classroom with 1 or multiple projectors and 1 or multiple touchpanels I will also need to check for the IP for a status check of 2011 and the Boardroom
	grep '     4  Gway    ONLINE' $IP.status.txt
	if [ "$?" == "0" ]; then
		echo "TSW 1 is online" >> $IP.status.html
		grep '     4  Gway    ONLINE' $IP.status.txt >> $IP.status.html
	else
		echo "TSW 1 is OFFLINE" >> $IP.status.html
		grep '     4  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
		STATUS=1
		FAILED="$FAILED TSW 1 Offline"
		HELP="${HELP} $TSWOFF"
	fi
	echo "<br/>" >> $IP.status.html
	#echo I have a ending IP of :${IP:(-3)}:
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
		PC1="${IP%?}8"
		PRJ1="${IP%?}4"
		NPSU="${IP%?}9"
		ping -c 1 $PC1|grep 'errors'
		if [ "$?" == "0" ]; then
			PC1="OFFLINE"
		fi	
		ping -c 1 $PRJ1|grep 'errors'
		if [ "$?" == "0" ]; then
			PRJ1="OFFLINE"
		fi	
		ping -c 1 $NPSU|grep 'errors'
		if [ "$?" == "0" ]; then
			NPSU="OFFLINE"
		fi	
		grep '    11  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "Projector 1 is online" >> $IP.status.html
			grep '    11  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "Projector 1 is OFFLINE" >> $IP.status.html
			grep '    11  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED PRJ1 Offline"
			HELP="${HELP} $PRJOFF"
			if [ "$PRJ1" != "OFFLINE" ]; then
				./toggleprj %PRJ1% >> $IP.status.html
			fi
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$BUILDING" == "2" ]; then
			grep '    14  Gway    ONLINE' $IP.status.txt
			if [ "$?" == "0" ]; then
				echo "DM-TX-401-C 1 is online" >> $IP.status.html
				grep '    14  Gway    ONLINE' $IP.status.txt >> $IP.status.html
			else
				echo "DM-TX-401-C is OFFLINE" >> $IP.status.html
				grep '    14  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
				STATUS=1
				FAILED="$FAILED DM-TX-401-C Offline"
				HELP="${HELP} $DMTX401COFF"
			fi
			echo "<br/>" >> $IP.status.html
			if [ "${IP:(-2)}" == "40" ]; then
				ping -c 1 172.17.6.42|grep 'errors'
				if [ "$?" == "0" ]; then
					echo "DM-TX-201-C is OFFLINE" >> $IP.status.html
					FAILED="$FAILED DM-TX-201-C Offline"
					HELP="${HELP} $DMTX201COFF"
					STATUS=1
				else
					echo "DM-TX-201-C is ONLINE" >> $IP.status.html
				fi			
				echo "<br/>" >> $IP.status.html			
			else
				grep '    15  Gway    ONLINE' $IP.status.txt
				if [ "$?" == "0" ]; then
					echo "DM-TX-201-C 1 is online" >> $IP.status.html
					grep '    15  Gway    ONLINE' $IP.status.txt >> $IP.status.html
				else
					echo "DM-TX-201-C is OFFLINE" >> $IP.status.html
					grep '    15  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
					STATUS=1
					FAILED="$FAILED DM-TX-201-C Offline"
					HELP="${HELP} $DMTX201COFF"
					
				fi
				echo "<br/>" >> $IP.status.html
			fi
			DIP31="${IP%?}3"
			ping -c 1 $DIP31|grep 'errors'
			if [ "$?" == "0" ]; then
				DIP31="OFFLINE"
			fi	
		fi
		if [ "$PRJCOUNT" == "2" ]; then
			#THIS IF IS FOR WHEN THERE ARE 2 PROJECTORS SO LETS PING PROJECTOR 2 NOW	
			PRJ2="${IP%?}5"
			ping -c 1 $PRJ2|grep 'errors'
			if [ "$?" == "0" ]; then
				PRJ2="OFFLINE"
			fi	
			grep '    12  Gway    ONLINE' $IP.status.txt
			if [ "$?" == "0" ]; then
				echo "Projector 2 is online" >> $IP.status.html
				grep '    12  Gway    ONLINE' $IP.status.txt >> $IP.status.html
			else
				echo "Projector 2 is OFFLINE" >> $IP.status.html
				grep '    12  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
				STATUS=1
				FAILED="$FAILED PRJ2 Offline"
				HELP="${HELP} $PRJOFF"
				if [ "$PRJ2" != "OFFLINE" ]; then
					./toggleprj %PRJ2% >> $IP.status.html
				fi
			fi
			echo "<br/>" >> $IP.status.html
		fi
		if [ "$PC1" == "OFFLINE" ]; then
			echo "PC is OFFLINE" >> $IP.status.html
			STATUS=1
			FAILED="$FAILED PC Offline"
			HELP="${HELP} $PCOFF"
			
		else
			echo "PC is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$PRJ1" == "OFFLINE" ]; then
			echo "PRJ1 is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "Projector 1 is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$PRJCOUNT" == "2" ]; then
			if [ "$PRJ2" == "OFFLINE" ]; then
				echo "PRJ2 is OFFLINE" >> $IP.status.html
				STATUS=1
			else
				echo "projector 2 is ONLINE or NA" >> $IP.status.html
			
			fi
			echo "<br/>" >> $IP.status.html		
		fi
		if [ "$NPSU" == "OFFLINE" ]; then
			echo "NPSU is OFFLINE" >> $IP.status.html
			STATUS=1
			FAILED="$FAILED NPSU Offline"
			HELP="${HELP} $NPSUOFF"
		else
			echo "NPSU is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$BUILDING" == "2" ]; then 
			if [ "$DIP31" == "OFFLINE" ]; then
				echo "DIP31 is OFFLINE" >> $IP.status.html
				STATUS=1
				FAILED="$FAILED DIP31 Offline"
				HELP="${HELP} $DIP31OFF"
			else
				echo "DIP31 is ONLINE" >> $IP.status.html
			
			fi
			echo "<br/>" >> $IP.status.html
		fi
		#echo "$FAILED" >> $IP.status.html
	fi		
	if [ "$ROOM" == "SJ2-1004" ]; then
		# need to check all IP table entries for the room.
		PC2="${IP%?}9"
		PC1="${IP%??}101"
		PRJ1="${IP%?}4"
		PRJ2="${IP%?}5"
		NPSU="${IP%?}8"
		NPSU2="${IP%??}102"
		#echo the IP of the controller should still be $IP
		ping -c 1 $PC1|grep 'errors'
		if [ "$?" == "0" ]; then
			PC1="OFFLINE"
		fi	
		ping -c 1 $PC2|grep 'errors'
		if [ "$?" == "0" ]; then
			PC2="OFFLINE"
		fi	
		ping -c 1 $PRJ1|grep 'errors'
		if [ "$?" == "0" ]; then
			PRJ1="OFFLINE"
		fi	
		ping -c 1 $PRJ2|grep 'errors'
		if [ "$?" == "0" ]; then
			PRJ2="OFFLINE"
		fi	
		ping -c 1 $NPSU|grep 'errors'
		if [ "$?" == "0" ]; then
			NPSU="OFFLINE"
		fi
		ping -c 1 $NPSU2|grep 'errors'
		if [ "$?" == "0" ]; then
			NPSU2="OFFLINE"
		fi	
		grep '     5  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "TSW 2 is online" >> $IP.status.html
			grep '     5  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "TSW 2 is OFFLINE" >> $IP.status.html
			grep '     5  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED TSW  Offline"
			HELP="${HELP} $TSWOFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    19  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "DM-TX-401-C 1 is online" >> $IP.status.html
			grep '    19  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "DM-TX-401-C 1 is OFFLINE" >> $IP.status.html
			grep '    19  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED DM-TX-401-C 1 Offline"
			HELP="${HELP} $DMTX401COFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    1A  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "DM-TX-201-C 1 is online" >> $IP.status.html
			grep '    1A  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "DM-TX-201-C 1 is OFFLINE" >> $IP.status.html
			grep '    1A  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED DM-TX-201-C 1 Offline"
			HELP="${HELP} $DMTX201COFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    1B  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "DM-TX-401-C 2 is online" >> $IP.status.html
			grep '    1B  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "DM-TX-401-C 2 is OFFLINE" >> $IP.status.html
			grep '    1B  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED Dm-TX-401-C 2 Offline"
			HELP="${HELP} $DMTX401COFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    1C  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "DM-TX-201-C 2 is online" >> $IP.status.html
			grep '    1C  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "DM-TX-201-C 2 is OFFLINE" >> $IP.status.html
			grep '    1C  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED DM-TX-201-C 2 Offline"
			HELP="${HELP} $DMTX201COFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    21  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "RMC-RX 1 is online" >> $IP.status.html
			grep '    21  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "RMC-RX 1 is OFFLINE" >> $IP.status.html
			grep '    21  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED RMC-RX 1 Offline"
			HELP="${HELP} $RMCOFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    22  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "RMC-RX 2 is online" >> $IP.status.html
			grep '    22  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "RMC-RX 2 is OFFLINE" >> $IP.status.html
			grep '    22  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED RMC-RX 2 Offline"
			HELP="${HELP} $RMCOFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    23  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "Projector 1 is online" >> $IP.status.html
			grep '    23  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "Projector 1 is OFFLINE" >> $IP.status.html
			grep '    23  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED Projector 1 Offline"
			HELP="${HELP} $PRJOFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    24  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "Projector 2 is online" >> $IP.status.html
			grep '    24  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "Projector 2 is OFFLINE" >> $IP.status.html
			grep '    24  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED Projector 2 Offline"
			HELP="${HELP} $PRJOFF"
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$PC1" == "OFFLINE" ]; then
			echo "PC1 is OFFLINE" >> $IP.status.html
			STATUS=1
			FAILED="$FAILED PC 1 Offline"
			HELP="${HELP} $PCOFF"
		else
			echo "PC1 is ONLINE" >> $IP.status.html
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$PC2" == "OFFLINE" ]; then
			echo "PC2 is OFFLINE" >> $IP.status.html
			STATUS=1
			FAILED="$FAILED PC 2 Offline"
			HELP="${HELP} $PCOFF"
		else
			echo "PC2 is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$PRJ1" == "OFFLINE" ]; then
			echo "PRJ1 is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "Projector 1 is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$PRJ2" == "OFFLINE" ]; then
			echo "PRJ2 is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "Projector 2 is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$NPSU" == "OFFLINE" ]; then
			echo "NPSU is OFFLINE" >> $IP.status.html
			STATUS=1
			FAILED="$FAILED NPSU 1 Offline"
			HELP="${HELP} $NPSUOFF"
		else
			echo "NPSU is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$NPSU2" == "OFFLINE" ]; then
			echo "NPSU2 is OFFLINE" >> $IP.status.html
			STATUS=1
			FAILED="$FAILED NPSU 2 OFFLINE"
			HELP="${HELP} $NPSUOFF"
		else
			echo "NPSU2 is ONLINE" >> $IP.status.html
		fi
		echo "<br/>" >> $IP.status.html
	fi
	if [ "${IP:(-3)}" == "120" ]; then
		#echo "I am in the boardroom check now"		
		#This is for the Boardroom checks Need to check IPID's 7-DSP, 9-Prj, 8-TV,6-201,14-SCALER,F9-BOSCH
		PC1="${IP%?}8"
		PRJ1="${IP%?}4"
		TV1="${IP%?}5"
		NPSU="${IP%?}9"
		ping -c 1 $PC1|grep 'errors'
		if [ "$?" == "0" ]; then
			PC1="OFFLINE"
		fi	
		ping -c 1 $PRJ1|grep 'errors'
		if [ "$?" == "0" ]; then
			PRJ1="OFFLINE"
		fi	
		ping -c 1 $TV1|grep 'errors'
		if [ "$?" == "0" ]; then
			TV1="OFFLINE"
		fi	
		ping -c 1 $NPSU|grep 'errors'
		if [ "$?" == "0" ]; then
			NPSU="OFFLINE"
		fi
		grep '     7  Client  CONNECTED' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "DSP is online" >> $IP.status.html
			grep '     7  Client  CONNECTED' $IP.status.txt >> $IP.status.html
		else
			echo "DSP is OFFLINE" >> $IP.status.html
			grep '     7  Client' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED DSP Offline"
			HELP="${HELP} $DSPOFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    8  Client  CONNECTED' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "TV is Online" >> $IP.status.html
			grep '     8  Client  CONNECTED' $IP.status.txt >> $IP.status.html
		else
			echo "TV is OFFLINE" >> $IP.status.html
			grep '     8  Client' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED TV Offline"
			HELP="${HELP} $TVOFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    9  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "Projector is online" >> $IP.status.html
			grep '    9  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "Projector is OFFLINE" >> $IP.status.html
			grep '    9  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED Projector Offline"
			HELP="${HELP} $PRJOFF"
		fi
		echo "<br/>" >> $IP.status.html
		#grep '     8  Client  CONNECTED' $IP.status.txt
		#if [ "$?" == "0" ]; then
		#	echo "TV is online" >> $IP.status.html
		#	grep '     8  Client  CONNECTED' $IP.status.txt >> $IP.status.html
		#else
		#	echo "TV is OFFLINE" >> $IP.status.html
		#	grep '     8  Client' $IP.status.txt >> $IP.status.html
		#	STATUS=1
		#fi
		#cho "<br/>" >> $IP.status.html
		grep '    6  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "DM_TX-201-C is online" >> $IP.status.html
			grep '    6  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "DM-TX-201-C is OFFLINE" >> $IP.status.html
			grep '    6  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED DM-TX-201-C Offline"
			HELP="${HELP} $DMTX201COFF"
		fi
		echo "<br/>" >> $IP.status.html

		grep '    14  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "DM-RMC-SCALER is online" >> $IP.status.html
			grep '    14  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "DM-RMC-SCALER is OFFLINE" >> $IP.status.html
			grep '    14  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED DM-RMC-SSCALER Offline"
			HELP="${HELP} $SCALEROFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    F9  CIP     ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "BOSCH MIC SYSTEM is online" >> $IP.status.html
			grep '    F9  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "BOSCH MIC SYSTEM is OFFLINE" >> $IP.status.html
			grep '    F9  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED BOSCH MICS Offline"
			HELP="${HELP} $BOSCHMICSOFF"
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$PC1" == "OFFLINE" ]; then
			echo "PC is OFFLINE" >> $IP.status.html
			STATUS=1
			FAILED="$FAILED PC1 Offline"
			HELP="${HELP} $PCOFF"
		else
			echo "PC is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$PRJ1" == "OFFLINE" ]; then
			echo "PRJ1 is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "Projector 1 is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$TV1" == "OFFLINE" ]; then
			echo "TV is OFFLINE" >> $IP.status.html
			STATUS=1
			FAILED="$FAILED TV Offline"
			HELP="${HELP} $TVOFF"
		else
			echo "TV is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$NPSU" == "OFFLINE" ]; then
			echo "NPSU is OFFLINE" >> $IP.status.html
			STATUS=1
			FAILED="$FAILED NPSU Offline"
			HELP="${HELP} $NPSUOFF"
		else
			echo "NPSU is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
	fi
	if [ "${IP:(-3)}" == "130" ]; then
		#This is for the Chapel Checks 26-MP-B10,25-MD6x4,21-TV1,22-TV2,23-TV3,24-DSP,5-RMC-100,6-RMC-100,14-RMC-100
		PC1="${IP%?}8"
		TV1="${IP%?}4"
		TV2="${IP%?}5"
		#TV3="${IP%?}6"
		VIA1="172.25.52.36"
		ping -c 1 $PC1|grep 'errors'
		if [ "$?" == "0" ]; then
			PC1="OFFLINE"
		fi	
		ping -c 1 $TV1|grep 'errors'
		if [ "$?" == "0" ]; then
			TV1="OFFLINE"
		fi	
		ping -c 1 $TV2|grep 'errors'
		if [ "$?" == "0" ]; then
			TV2="OFFLINE"
		fi	
		#ping -c 1 $TV3|grep 'errors'
		#if [ "$?" == "0" ]; then
		#	TV3="OFFLINE"
		#fi	
		ping -c 1 $VIA1|grep 'errors'
		if [ "$?" == "0" ]; then
			VIA1="OFFLINE"
		fi
		grep '    26  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "MP-B10 is online" >> $IP.status.html
			grep '    26  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "MP-B10 is OFFLINE" >> $IP.status.html
			grep '    26  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED MP-B10 Offline"
			HELP="${HELP} $MBB10OFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    25  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "DM-MD6x4 is online" >> $IP.status.html
			grep '    25  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "DM-MD6x4 is OFFLINE" >> $IP.status.html
			grep '    25  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED DM-MD6x4 Offline"
			HELP="${HELP} $MD6X6OFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    21  Client  CONNECTED' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "TV1 is online" >> $IP.status.html
			grep '    21  Client  CONNECTED' $IP.status.txt >> $IP.status.html
		else
			echo "TV1 is OFFLINE" >> $IP.status.html
			grep '    21  Client' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED TV1 Offline"
			HELP="${HELP} $TVOFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    22  Client  CONNECTED' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "TV2 is online" >> $IP.status.html
			grep '    22  Client  CONNECTED' $IP.status.txt >> $IP.status.html
		else
			echo "TV2 is OFFLINE" >> $IP.status.html
			grep '    22  Client' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED TV2 Offline"
			HELP="${HELP} $TVOFF"
		fi
		echo "<br/>" >> $IP.status.html
		#grep '    23  Client  WAITING' $IP.status.txt
		#if [ "$?" == "0" ]; then
		#	echo "TV3 is online" >> $IP.status.html
		#	grep '    23  Client  WAITING' $IP.status.txt >> $IP.status.html
		#else
		#	echo "TV3 is OFFLINE" >> $IP.status.html
		#	grep '    23  Client' $IP.status.txt >> $IP.status.html
		#	STATUS=1
		#fi
		#echo "<br/>" >> $IP.status.html
		grep '    24  Client  CONNECTED' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "DSP is online" >> $IP.status.html
			grep '    24  Client  CONNECTED' $IP.status.txt >> $IP.status.html
		else
			echo "DSP is OFFLINE" >> $IP.status.html
			grep '    24  Client' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED DSP Offline"
			HELP="${HELP} $DSPOFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    5  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "RMC-100 is online" >> $IP.status.html
			grep '    5  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "RMC-100 is OFFLINE" >> $IP.status.html
			grep '    5  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED RMC-100 Offline"
			HELP="${HELP} $RMCOFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    6  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "RMC-100-2 is online" >> $IP.status.html
			grep '    6  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "RMC-100-2 is OFFLINE" >> $IP.status.html
			grep '    6  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED RMC-100 2 Offline"
			HELP="${HELP} $RMCOFF"
		fi
		echo "<br/>" >> $IP.status.html
		grep '    14  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "RMC-100-3 is online" >> $IP.status.html
			grep '    14  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "RMC-100-3 is OFFLINE" >> $IP.status.html
			grep '    14  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED RMC-100 3 Offline"
			HELP="${HELP} $RMCOFF"
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$PC1" == "OFFLINE" ]; then
			echo "PC is OFFLINE" >> $IP.status.html
			STATUS=1
			FAILED="$FAILED PC1 Offline"
			HELP="${HELP} $PCOFF"
		else
			echo "PC is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$TV1" == "OFFLINE" ]; then
			echo "TV1 is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "TV1 is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
		if [ "$TV2" == "OFFLINE" ]; then
			echo "TV2 is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "TV2 is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
		#if [ "$TV3" == "OFFLINE" ]; then
		#	echo "TV3 is OFFLINE" >> $IP.status.html
		#	STATUS=1
		#else
		#	echo "TV3 is ONLINE" >> $IP.status.html
		#
		#fi
		#echo "<br/>" >> $IP.status.html
		if [ "$VIA1" == "OFFLINE" ]; then
			echo "VIA1 is OFFLINE" >> $IP.status.html
			STATUS=1
			FAILED="$FAILED VIA1 Offline"
			HELP="${HELP} $VIAOFF"
		else
			echo "VIA is ONLINE" >> $IP.status.html
		
		fi
		echo "<br/>" >> $IP.status.html
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
				
		ping -c 1 $PC1|grep 'errors'
		if [ "$?" == "0" ]; then
			PC1="OFFLINE"
		fi	
				
		ping -c 1 $TV1|grep 'errors'
		if [ "$?" == "0" ]; then
			TV1="OFFLINE"
		fi	
				
		ping -c 1 $TV2|grep 'errors'
		if [ "$?" == "0" ]; then
			TV2="OFFLINE"
		fi	
				
		ping -c 1 $TV3|grep 'errors'
		if [ "$?" == "0" ]; then
			TV3="OFFLINE"
		fi	
				
		ping -c 1 $TV4|grep 'errors'
		if [ "$?" == "0" ]; then
			TV4="OFFLINE"
		fi
				
		ping -c 1 $PRJ1|grep 'errors'
		if [ "$?" == "0" ]; then
			PRJ1="OFFLINE"
		fi	
				
		ping -c 1 $NPSU|grep 'errors'
		if [ "$?" == "0" ]; then
			NPSU="OFFLINE"
		fi	
				
		ping -c 1 $VIA0
		if [ "$?" != "0" ]; then
			VIA0="OFFLINE"
		fi
				
		ping -c 1 $VIA1
		if [ "$?" != "0" ]; then
			VIA1="OFFLINE"
		fi
				
		ping -c 1 $VIA2
		if [ "$?" != "0" ]; then
			VIA2="OFFLINE"
		fi
				
		ping -c 1 $VIA3
		if [ "$?" != "0" ]; then
			VIA3="OFFLINE"
		fi
				
		ping -c 1 $VIA4
		if [ "$?" != "0" ]; then
			VIA4="OFFLINE"
		fi
				
		grep '    11  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "Projector is online" >> $IP.status.html
			grep '    11  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "Projector is OFFLINE" >> $IP.status.html
			grep '    11  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED Projector 1 Offline"
			HELP="${HELP} $PRJOFF"
			if [ "$PRJ1" != "OFFLINE" ]; then
				./toggleprj %PRJ1% >> $IP.status.html
			fi

		fi
				
		echo "<br/>" >> $IP.status.html
		grep '    5  Gway    ONLINE' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "DM-MD6x6 is online" >> $IP.status.html
			grep '    5  Gway    ONLINE' $IP.status.txt >> $IP.status.html
		else
			echo "DM-MD6x6 is OFFLINE" >> $IP.status.html
			grep '    5  Gway    OFFLINE' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED DM-MD6x6 Offline"
			HELP="${HELP} $MD6X6OFF"
		fi
				
		echo "<br/>" >> $IP.status.html
		grep '    12  Client  CONNECTED' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "TV1 is online" >> $IP.status.html
			grep '    12  Client  CONNECTED' $IP.status.txt >> $IP.status.html
		else
			echo "TV1 is OFFLINE" >> $IP.status.html
			grep '    12  Client' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED TV1 Offline"
			HELP="${HELP} $TVOFF"
		fi
				
		echo "<br/>" >> $IP.status.html
		grep '    13  Client  CONNECTED' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "TV2 is online" >> $IP.status.html
			grep '    13  Client  CONNECTED' $IP.status.txt >> $IP.status.html
		else
			echo "TV2 is OFFLINE" >> $IP.status.html
			grep '    13  Client' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED TV2 Offline"
			HELP="${HELP} $TVOFF"
		fi
				
		echo "<br/>" >> $IP.status.html
		grep '    14  Client  CONNECTED' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "TV3 is online" >> $IP.status.html
			grep '    14  Client  CONNECTED' $IP.status.txt >> $IP.status.html
		else
			echo "TV3 is OFFLINE" >> $IP.status.html
			grep '    14  Client' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED TV3 Offline"
			HELP="${HELP} $TVOFF"
		fi
				
		echo "<br/>" >> $IP.status.html
		grep '    15  Client  CONNECTED' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "TV4 is online" >> $IP.status.html
			grep '    15  Client  CONNECTED' $IP.status.txt >> $IP.status.html
		else
			echo "TV4 is OFFLINE" >> $IP.status.html
			grep '    15  Client' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED TV4 Offline"
			HELP="${HELP} $TVOFF"
		fi
				
		#echo "<br/>" >> $IP.status.html
		#DSP Removed with controller change
		#grep '     F  Client  CONNECTED' $IP.status.txt
		#if [ "$?" == "0" ]; then
		#	echo "DSP is online" >> $IP.status.html
		#	grep '     F  Client  CONNECTED' $IP.status.txt >> $IP.status.html
		#else
		#	echo "DSP is OFFLINE" >> $IP.status.html
		#	grep '     F  Client' $IP.status.txt >> $IP.status.html
		#	STATUS=1
		#	FAILED="$FAILED DSP Offline"
		#fi
				
		echo "<br/>" >> $IP.status.html
		grep '    16  Client  CONNECTED' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "VIA Campus is online" >> $IP.status.html
			grep '    16  Client' $IP.status.txt >> $IP.status.html
		else
			echo "VIA Campus is OFFLINE" >> $IP.status.html
			grep '    16  Client' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED VIA Campus Offline"
			HELP="${HELP} $VIAOFF"
		fi
				
		echo "<br/>" >> $IP.status.html
		grep '    17  Client  CONNECTED' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "Via Connect 1 is online" >> $IP.status.html
			grep '    17  Client' $IP.status.txt >> $IP.status.html
		else
			echo "Via Connect 1 is OFFLINE" >> $IP.status.html
			grep '    17  Client' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED VIA 1 Offline"
			HELP="${HELP} $VIAOFF"
		fi
				
		echo "<br/>" >> $IP.status.html
		grep '    18  Client  CONNECTED' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "Via Connect 2 is online" >> $IP.status.html
			grep '    18  Client' $IP.status.txt >> $IP.status.html
		else
			echo "Via Connect 2 is OFFLINE" >> $IP.status.html
			grep '    18  Client' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED VIA 2 Offline"
			HELP="${HELP} $VIAOFF"
		fi
				
		echo "<br/>" >> $IP.status.html
		grep '    19  Client  CONNECTED' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "Via Connect 3 is online" >> $IP.status.html
			grep '    19  Client' $IP.status.txt >> $IP.status.html
		else
			echo "Via Connect 3 is OFFLINE" >> $IP.status.html
			grep '    19  Client' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED VIA 3 Offline"
			HELP="${HELP} $VIAOFF"
		fi
				
		echo "<br/>" >> $IP.status.html
		grep '    1A  Client  CONNECTED' $IP.status.txt
		if [ "$?" == "0" ]; then
			echo "Via Connect 4 is online" >> $IP.status.html
			grep '    1A  Client' $IP.status.txt >> $IP.status.html
		else
			echo "Via Connect 4 is OFFLINE" >> $IP.status.html
			grep '    1A  Client' $IP.status.txt >> $IP.status.html
			STATUS=1
			FAILED="$FAILED VIA 4 Offline"
			HELP="${HELP} $VIAOFF"
		fi
				
		echo "<br/>" >> $IP.status.html
		if [ "$PC1" == "OFFLINE" ]; then
			echo "PC is OFFLINE" >> $IP.status.html
			STATUS=1
			FAILED="$FAILED PC Offline"
			HELP="${HELP} $PCOFF"
		else
			echo "PC is ONLINE" >> $IP.status.html
		
		fi
				
		echo "<br/>" >> $IP.status.html
		if [ "$TV1" == "OFFLINE" ]; then
			echo "TV1 is OFFLINE" >> $IP.status.html
			STATUS=1
			#FAILED="$FAILED TV1 Offline"
		else
			echo "TV1 is ONLINE" >> $IP.status.html
		
		fi
				
		echo "<br/>" >> $IP.status.html
		if [ "$TV2" == "OFFLINE" ]; then
			echo "TV2 is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "TV2 is ONLINE" >> $IP.status.html
		
		fi
				
		echo "<br/>" >> $IP.status.html
		if [ "$TV3" == "OFFLINE" ]; then
			echo "TV3 is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "TV3 is ONLINE" >> $IP.status.html
		
		fi
				
		echo "<br/>" >> $IP.status.html
		if [ "$TV4" == "OFFLINE" ]; then
			echo "TV4 is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "TV4 is ONLINE" >> $IP.status.html
		
		fi
				
		echo "<br/>" >> $IP.status.html
		if [ "$PRJ1" == "OFFLINE" ]; then
			echo "Projector is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "Projector is ONLINE" >> $IP.status.html
		
		fi
				
		echo "<br/>" >> $IP.status.html
		if [ "$NPSU" == "OFFLINE" ]; then
			echo "NPSU is OFFLINE" >> $IP.status.html
			STATUS=1
			FAILED="$FAILED NPSU Offline"
			HELP="${HELP} $NPSUOFF"
		else
			echo "NPSU is ONLINE" >> $IP.status.html
		
		fi
				
		echo "<br/>" >> $IP.status.html
		if [ "$VIA0" == "OFFLINE" ]; then
			echo "VIA Campus is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "Via Campus is ONLINE" >> $IP.status.html
		
		fi
				
		echo "<br/>" >> $IP.status.html
		if [ "$VIA1" == "OFFLINE" ]; then
			echo "VIA1 is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "Via1 is ONLINE" >> $IP.status.html
		
		fi
				
		echo "<br/>" >> $IP.status.html
		if [ "$VIA2" == "OFFLINE" ]; then
			echo "VIA2 is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "Via2 is ONLINE" >> $IP.status.html
		
		fi
				
		echo "<br/>" >> $IP.status.html
		if [ "$VIA3" == "OFFLINE" ]; then
			echo "VIA3 is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "Via3 is ONLINE" >> $IP.status.html
		
		fi
				
		echo "<br/>" >> $IP.status.html
		if [ "$VIA4" == "OFFLINE" ]; then
			echo "VIA4 is OFFLINE" >> $IP.status.html
			STATUS=1
		else
			echo "Via4 is ONLINE" >> $IP.status.html
		
		fi
				
		echo "<br/>" >> $IP.status.html
	fi

		
else
	echo "<body bgcolor="RED">">> $IP.status.html
	echo "The controller is offline" >> $IP.status.html
	echo "<br/>" >> $IP.status.html	
	STATUS=1
	FAILED="$FAILED Controller is offline"
	HELP="${HELP} $CONTROLLEROFF"
fi

if [ "$STATUS" == "0" ]; then
	echo "<body bgcolor="GREEN">">> $IP.status.html
	ls /home/sysadmin/Documents/errors |grep $IP.txt
	if [ "$?" == "0" ]; then
		#:getmail
		PREVAVID="$(< /home/sysadmin/Documents/errors/$IP.AVID.txt)"
		echo "[AVID#-$PREVAVID] $TODAY:The Previous error(s) have now been resolved" >> /home/sysadmin/Documents/errors/$IP.log		
		rm /home/sysadmin/Documents/errors/$IP.txt
		rm /home/sysadmin/Documents/errors/$IP.AVID.txt
		ls /home/sysadmin/mail/new/*ITAVSRV > /home/sysadmin/mail/new/files.txt
		grep -o "Subject: \[.*]" $(cat /home/sysadmin/mail/new/files.txt) >> /home/sysadmin/mail/new/subjects.txt
		RTSUBJECT=$(grep -o "\[.*] \[AVID#$PREVAVID]" /home/sysadmin/mail/new/subjects.txt)
		sendemail -f sjuit@sju.ca -t tait.kelly@uwaterloo.ca -u $RTSUBJECT [AVID#$PREVAVID] Communications Restored in room:$ROOM -m "$RTSUBJECT [AVID#$PREVAVID] A Previous issue found in room $ROOM was resolved" -s mail2.nettrac.net:2500 -xu sjuit@sju.ca -xp "?Mm&FdfU"
		#echo "now the removal from the var folder"
		echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/$IP.log
		#echo "now the copy"
		echo "A+C247srv" | sudo cp /home/sysadmin/Documents/errors/$IP.log /var/www/html/sites/default/files/$IP.log
		#sendemail -f sjuit@sju.ca -t tait.kelly@uwaterloo.ca -u [AVID#$PREVAVID] Communications Restored in room:$ROOM -m "[AVID#$PREVAVID] A Previous issues found in room $ROOM was resolved" -s mail2.nettrac.net:2500 -xu sjuit@sju.ca -xp "?Mm&FdfU"
	       	sudo mysql drupal --batch -u root -p"A+C247srv" -e "SELECT delta FROM node__field_history WHERE entity_id='$ENTITYID' ORDER BY delta DESC LIMIT 1" > lastdelta.txt
       		while read -r delta
       		do
			DELTA=$delta
		done <lastdelta.txt
		DELTA=$((DELTA+1))
		sudo mysql drupal --batch -u root -p"A+C247srv" -e "SELECT revision_id FROM node__field_history WHERE entity_id='$ENTITYID' ORDER BY delta DESC LIMIT 1" > lastrev.txt
		while read -r revid
		do
			REVID=$revid
		done <lastrev.txt
		sudo mysql drupal --batch -u root -p"A+C247srv" -e "INSERT INTO node__field_history VALUES ('av_status','0','$ENTITYID','$REVID','en','$DELTA','[AVID#-$PREVAVID]$TODAY:The previous issue in room $ROOM was resolved')"
	fi
elif [ "$STATUS" == "1" ]; then
	echo "<body bgcolor="RED">">> $IP.status.html
	ls /home/sysadmin/Documents/errors |grep $IP.txt
	if [ "$?" == "1" ]; then
		AVID=$(<AVUID.txt)
		echo "AV ID currently is $AVID"
		AVID=$(($AVID + 1))
		echo "AV id is:$AVID"
		sendemail -f sjuit@sju.ca -t tait.kelly@uwaterloo.ca -u [AVID#$AVID] Communications failure in room:$ROOM -m "[AVID#$AVID] Last AVStatus collection appears to have found an issue in room $ROOM please investigate.$FAILED. $HELP. For More information go to http://172.17.6.253/node/$ENTITYID." -s mail2.nettrac.net:2500 -xu sjuit@sju.ca -xp "?Mm&FdfU"
		#AVID="$(while read AVUID; done </home/sysadmin/Documents/AVUID.txt)"
		#AVID=$(($AVID + 1))
		echo "$AVID" > /home/sysadmin/Documents/AVUID.txt
		echo "$AVID" > /home/sysadmin/Documents/errors/$IP.AVID.txt
		echo "[AVID#-$AVID] $TODAY:There is an error in room $ROOM of:$FAILED" > /home/sysadmin/Documents/errors/$IP.txt	
		echo "[AVID#-$AVID] $TODAY:There is an error in room $ROOM of:$FAILED" >> /home/sysadmin/Documents/errors/$IP.log
		sudo mysql drupal --batch -u root -p"A+C247srv" -e "SELECT delta FROM node__field_history WHERE entity_id='$ENTITYID' ORDER BY delta DESC LIMIT 1" > lastdelta.txt
		while read -r delta
		do
		        DELTA=$delta
		done <lastdelta.txt
		DELTA=$((DELTA+1))
		sudo mysql drupal --batch -u root -p"A+C247srv" -e "SELECT revision_id FROM node__field_history WHERE entity_id='$ENTITYID' ORDER BY delta DESC LIMIT 1" > lastrev.txt
		while read -r revid
		do
		        REVID=$revid
		done <lastrev.txt
		sudo mysql drupal --batch -u root -p"A+C247srv" -e "INSERT INTO node__field_history VALUES ('av_status','0','$ENTITYID','$REVID','en','$DELTA','[AVID#-$AVID]$TODAY:There is an error in room $ROOM of:$FAILED')"

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
