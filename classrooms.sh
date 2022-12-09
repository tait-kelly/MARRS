#!/bin/bash
# Classroom Automation 
# File requirments:
#		plink.exe
#		ninitepro.exe
#		wol.exe
#		psinfo.exe
#		psexec.exe
#
#
#
#
#
#	ERROR CODING
#		->ERR[0-30] Each value represents a function as outlined below
#			->0 Success - GREEN
#			->1 FAILED UNSPECIFIED - RED
#			->2 FAILED COMMUNICATIONS ISSUE -ORANGE
#			->3 FAILED COMMAND ISSUE - BLUE
#			->4 FAILED IN FUNCTION CALL - PURPLE
#			->5 FAILED THREADCOUNT - YELLOW
#			->6 WARNING UPTIME TOO LONG - SILVER
#			->7 FAILED
#			->8 RESERVED
#			->9 NA
#




NEVER_QUIT=NO
while [ "$NEVER_QUIT" == "NO" ]
do
	HOUR=$(date +%H)
	MIN=$(date +%M)
	DAY=$(date +%u)
	if [ "$DAY" -lt "6" ]; then	
		if [ "$HOUR" -eq "5" ]; then
			if [ "$MIN" -gt "10" -a "$MIN" -lt "12" ]; then
				echo "I made it into the terminal restart if statement at $HOUR:$MIN." >> terminallogs.txt 
				. AVTerrestart.sh 172.17.6.41 
				. AVTerrestart.sh 172.17.6.51 
				. AVTerrestart.sh 172.17.6.61 
				. AVTerrestart.sh 172.17.6.71 
				. AVTerrestart.sh 172.17.6.81 
				. AVTerrestart.sh 172.17.6.93 
				. AVTerrestart.sh 172.17.6.97 
				. AVTerrestart.sh 172.17.6.121 
				. AVTerrestart.sh 172.17.6.131 
				. AVTerrestart.sh 172.17.6.141 
				. AVTerrestart.sh 172.17.6.161 
				. AVTerrestart.sh 172.17.6.171 
				. AVTerrestart.sh 172.17.6.181 
				. AVTerrestart.sh 172.17.6.191 
				. AVTerrestart.sh 172.17.6.201 
				. AVTerrestart.sh 172.17.6.211 
				. AVTerrestart.sh 172.17.6.221 
				. AVTerrestart.sh 172.17.6.231 
				. AVTerrestart.sh 172.17.6.241
			        #. AVTerrestart.sh 172.17.6.31
				#. AVTerrestart.sh 172.17.6.111	
			fi
		fi
		if [ "$HOUR" -gt "5" -a "$HOUR" -lt "23" ]; then
			if [ "$MIN" == "15" ]; then
				. AVStatus.sh 172.17.6.40 &&
				. AVStatus.sh 172.17.6.50 &&
				. AVStatus.sh 172.17.6.60 &&
				. AVStatus.sh 172.17.6.70 &&
				. AVStatus.sh 172.17.6.80 && 
				. AVStatus.sh 172.17.6.90 && 
				. AVStatus.sh 172.17.6.120 && 
				. AVStatus.sh 172.17.6.130 && 
				. AVStatus.sh 172.17.6.140 && 
				. AVStatus.sh 172.17.6.160 &&
				. AVStatus.sh 172.17.6.170 && 
				. AVStatus.sh 172.17.6.180 && 
				. AVStatus.sh 172.17.6.190 && 
				. AVStatus.sh 172.17.6.200 && 
				. AVStatus.sh 172.17.6.210 && 
				. AVStatus.sh 172.17.6.220 && 
				. AVStatus.sh 172.17.6.230 && 
				. AVStatus.sh 172.17.6.240 &&
				#. AVStatus.sh 172.17.6.30 &&
				#. AVStatus.sh 172.17.6.110	
				echo "<!DOCTYPE html>" > ping.html
				echo "<HTML>" >> ping.html
				echo "<body>" >> ping.html
				TODAY="$(date +%Y-%m-%d.%H:%M:%S)"
				echo Last check was at $TODAY >> ping.html
				echo "<br/>" >> ping.html	
				echo "</body>" >> ping.html
				echo "</HTML>" >> ping.html
				echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/ping.html
				echo "A+C247srv" | sudo cp ping.html /var/www/html/sites/default/files/ping.html
				rm ping.html
				. AVPING.sh 172.17.6.40 &&
				. AVPING.sh 172.17.6.50 &&
				. AVPING.sh 172.17.6.60 &&
				. AVPING.sh 172.17.6.70 &&
				. AVPING.sh 172.17.6.80 && 
				. AVPING.sh 172.17.6.90 && 
				. AVPING.sh 172.17.6.120 && 
				. AVPING.sh 172.17.6.130 && 
				. AVPING.sh 172.17.6.140 && 
				. AVPING.sh 172.17.6.160 &&
				. AVPING.sh 172.17.6.170 && 
				. AVPING.sh 172.17.6.180 && 
				. AVPING.sh 172.17.6.190 && 
				. AVPING.sh 172.17.6.200 && 
				. AVPING.sh 172.17.6.210 && 
				. AVPING.sh 172.17.6.220 && 
				. AVPING.sh 172.17.6.230 && 
				. AVPING.sh 172.17.6.240 
				#. AVPING.sh 172.17.6.30 &&
			        #. AVPING.sh 172.17.6.110	
			fi
			if [ "$MIN" == "45" ]; then
				. AVStatus.sh 172.17.6.40 &&
				. AVStatus.sh 172.17.6.50 &&
				. AVStatus.sh 172.17.6.60 &&
				. AVStatus.sh 172.17.6.70 &&
				. AVStatus.sh 172.17.6.80 && 
				. AVStatus.sh 172.17.6.90 && 
				. AVStatus.sh 172.17.6.120 && 
				. AVStatus.sh 172.17.6.130 && 
				. AVStatus.sh 172.17.6.140 && 
				. AVStatus.sh 172.17.6.160 &&
				. AVStatus.sh 172.17.6.170 && 
				. AVStatus.sh 172.17.6.180 && 
				. AVStatus.sh 172.17.6.190 && 
				. AVStatus.sh 172.17.6.200 && 
				. AVStatus.sh 172.17.6.210 && 
				. AVStatus.sh 172.17.6.220 && 
				. AVStatus.sh 172.17.6.230 && 
				. AVStatus.sh 172.17.6.240 
				#. AVStatus.sh 172.17.6.30 &&
				#. AVStatus.sh 172.17.6.110 	
				. AVPING.sh 172.17.6.40 &&
				. AVPING.sh 172.17.6.50 &&
				. AVPING.sh 172.17.6.60 &&
				. AVPING.sh 172.17.6.70 &&
				. AVPING.sh 172.17.6.80 && 
				. AVPING.sh 172.17.6.90 && 
				. AVPING.sh 172.17.6.120 && 
				. AVPING.sh 172.17.6.130 && 
				. AVPING.sh 172.17.6.140 && 
				. AVPING.sh 172.17.6.160 &&
				. AVPING.sh 172.17.6.170 && 
				. AVPING.sh 172.17.6.180 && 
				. AVPING.sh 172.17.6.190 && 
				. AVPING.sh 172.17.6.200 && 
				. AVPING.sh 172.17.6.210 && 
				. AVPING.sh 172.17.6.220 && 
				. AVPING.sh 172.17.6.230 && 
				. AVPING.sh 172.17.6.240 
				#. AVPING.sh 172.17.6.30 &&
				#. AVPING.sh 172.17.6.110	
				echo "<!DOCTYPE html>" > ping.html
				echo "<HTML>" >> ping.html
				echo "<body>" >> ping.html
				TODAY="$(date +%Y-%m-%d.%H:%M:%S)"
				echo Last check was at $TODAY >> ping.html
				echo "<br/>" >> ping.html	
				echo "</body>" >> ping.html
				echo "</HTML>" >> ping.html
				echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/ping.html
				echo "A+C247srv" | sudo cp ping.html /var/www/html/sites/default/files/ping.html
				rm ping.html
			fi
			if [ "$MIN" == "00" ]; then
				. downcheck.sh &&				
				. AVPING.sh 172.17.6.40 &&
				. AVPING.sh 172.17.6.50 &&
				. AVPING.sh 172.17.6.60 &&
				. AVPING.sh 172.17.6.70 &&
				. AVPING.sh 172.17.6.80 && 
				. AVPING.sh 172.17.6.90 && 
				. AVPING.sh 172.17.6.120 && 
				. AVPING.sh 172.17.6.130 && 
				. AVPING.sh 172.17.6.140 && 
				. AVPING.sh 172.17.6.160 &&
				. AVPING.sh 172.17.6.170 && 
				. AVPING.sh 172.17.6.180 && 
				. AVPING.sh 172.17.6.190 && 
				. AVPING.sh 172.17.6.200 && 
				. AVPING.sh 172.17.6.210 && 
				. AVPING.sh 172.17.6.220 && 
				. AVPING.sh 172.17.6.230 && 
				. AVPING.sh 172.17.6.240 
				#. AVPING.sh 172.17.6.30 &&
			        #. AVPING.sh 172.17.6.110	      
				echo "<!DOCTYPE html>" > ping.html
				echo "<HTML>" >> ping.html
				echo "<body>" >> ping.html
				TODAY="$(date +%Y-%m-%d.%H:%M:%S)"
				echo Last check was at $TODAY >> ping.html
				echo "<br/>" >> ping.html	
				echo "</body>" >> ping.html
				echo "</HTML>" >> ping.html
				echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/ping.html
				echo "A+C247srv" | sudo cp ping.html /var/www/html/sites/default/files/ping.html
				rm ping.html
			fi
			if [ "$MIN" == "05" ]; then
				. downcheck.sh &&				
				. AVPING.sh 172.17.6.40 &&
				. AVPING.sh 172.17.6.50 &&
				. AVPING.sh 172.17.6.60 &&
				. AVPING.sh 172.17.6.70 &&
				. AVPING.sh 172.17.6.80 && 
				. AVPING.sh 172.17.6.90 && 
				. AVPING.sh 172.17.6.120 && 
				. AVPING.sh 172.17.6.130 && 
				. AVPING.sh 172.17.6.140 && 
				. AVPING.sh 172.17.6.160 &&
				. AVPING.sh 172.17.6.170 && 
				. AVPING.sh 172.17.6.180 && 
				. AVPING.sh 172.17.6.190 && 
				. AVPING.sh 172.17.6.200 && 
				. AVPING.sh 172.17.6.210 && 
				. AVPING.sh 172.17.6.220 && 
				. AVPING.sh 172.17.6.230 && 
				. AVPING.sh 172.17.6.240 
				#. AVPING.sh 172.17.6.30 &&
			        #. AVPING.sh 172.17.6.110	       
				echo "<!DOCTYPE html>" > ping.html
				echo "<HTML>" >> ping.html
				echo "<body>" >> ping.html
				TODAY="$(date +%Y-%m-%d.%H:%M:%S)"
				echo Last check was at $TODAY >> ping.html
				echo "<br/>" >> ping.html	
				echo "</body>" >> ping.html
				echo "</HTML>" >> ping.html
				echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/ping.html
				echo "A+C247srv" | sudo cp ping.html /var/www/html/sites/default/files/ping.html
				rm ping.html
			fi
			if [ "$MIN" == "10" ]; then
				. downcheck.sh &&				
				. AVPING.sh 172.17.6.40 &&
				. AVPING.sh 172.17.6.50 &&
				. AVPING.sh 172.17.6.60 &&
				. AVPING.sh 172.17.6.70 &&
				. AVPING.sh 172.17.6.80 && 
				. AVPING.sh 172.17.6.90 && 
				. AVPING.sh 172.17.6.120 && 
				. AVPING.sh 172.17.6.130 && 
				. AVPING.sh 172.17.6.140 && 
				. AVPING.sh 172.17.6.160 &&
				. AVPING.sh 172.17.6.170 && 
				. AVPING.sh 172.17.6.180 && 
				. AVPING.sh 172.17.6.190 && 
				. AVPING.sh 172.17.6.200 && 
				. AVPING.sh 172.17.6.210 && 
				. AVPING.sh 172.17.6.220 && 
				. AVPING.sh 172.17.6.230 && 
				. AVPING.sh 172.17.6.240 
				#. AVPING.sh 172.17.6.30 &&
			        #. AVPING.sh 172.17.6.110	      
				echo "<!DOCTYPE html>" > ping.html
				echo "<HTML>" >> ping.html
				echo "<body>" >> ping.html
				TODAY="$(date +%Y-%m-%d.%H:%M:%S)"
				echo Last check was at $TODAY >> ping.html
				echo "<br/>" >> ping.html	
				echo "</body>" >> ping.html
				echo "</HTML>" >> ping.html
				echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/ping.html
				echo "A+C247srv" | sudo cp ping.html /var/www/html/sites/default/files/ping.html
				rm ping.html
			fi
			if [ "$MIN" == "20" ]; then
				. downcheck.sh &&				
				. AVPING.sh 172.17.6.40 &&
				. AVPING.sh 172.17.6.50 &&
				. AVPING.sh 172.17.6.60 &&
				. AVPING.sh 172.17.6.70 &&
				. AVPING.sh 172.17.6.80 && 
				. AVPING.sh 172.17.6.90 && 
				. AVPING.sh 172.17.6.120 && 
				. AVPING.sh 172.17.6.130 && 
				. AVPING.sh 172.17.6.140 && 
				. AVPING.sh 172.17.6.160 &&
				. AVPING.sh 172.17.6.170 && 
				. AVPING.sh 172.17.6.180 && 
				. AVPING.sh 172.17.6.190 && 
				. AVPING.sh 172.17.6.200 && 
				. AVPING.sh 172.17.6.210 && 
				. AVPING.sh 172.17.6.220 && 
				. AVPING.sh 172.17.6.230 && 
				. AVPING.sh 172.17.6.240 
				#. AVPING.sh 172.17.6.30 &&
				#. AVPING.sh 172.17.6.110
				echo "<!DOCTYPE html>" > ping.html
				echo "<HTML>" >> ping.html
				echo "<body>" >> ping.html
				TODAY="$(date +%Y-%m-%d.%H:%M:%S)"
				echo Last check was at $TODAY >> ping.html
				echo "<br/>" >> ping.html	
				echo "</body>" >> ping.html
				echo "</HTML>" >> ping.html
				echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/ping.html
				echo "A+C247srv" | sudo cp ping.html /var/www/html/sites/default/files/ping.html
				rm ping.html
			fi
			if [ "$MIN" == "25" ]; then
				. downcheck.sh &&				
				. AVPING.sh 172.17.6.40 &&
				. AVPING.sh 172.17.6.50 &&
				. AVPING.sh 172.17.6.60 &&
				. AVPING.sh 172.17.6.70 &&
				. AVPING.sh 172.17.6.80 && 
				. AVPING.sh 172.17.6.90 && 
				. AVPING.sh 172.17.6.120 && 
				. AVPING.sh 172.17.6.130 && 
				. AVPING.sh 172.17.6.140 && 
				. AVPING.sh 172.17.6.160 &&
				. AVPING.sh 172.17.6.170 && 
				. AVPING.sh 172.17.6.180 && 
				. AVPING.sh 172.17.6.190 && 
				. AVPING.sh 172.17.6.200 && 
				. AVPING.sh 172.17.6.210 && 
				. AVPING.sh 172.17.6.220 && 
				. AVPING.sh 172.17.6.230 && 
				. AVPING.sh 172.17.6.240 
				#. AVPING.sh 172.17.6.30 &&
				#. AVPING.sh 172.17.6.110
				echo "<!DOCTYPE html>" > ping.html
				echo "<HTML>" >> ping.html
				echo "<body>" >> ping.html
				TODAY="$(date +%Y-%m-%d.%H:%M:%S)"
				echo Last check was at $TODAY >> ping.html
				echo "<br/>" >> ping.html	
				echo "</body>" >> ping.html
				echo "</HTML>" >> ping.html
				echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/ping.html
				echo "A+C247srv" | sudo cp ping.html /var/www/html/sites/default/files/ping.html
				rm ping.html
			fi
			if [ "$MIN" == "30" ]; then
				. downcheck.sh &&				
				. AVPING.sh 172.17.6.40 &&
				. AVPING.sh 172.17.6.50 &&
				. AVPING.sh 172.17.6.60 &&
				. AVPING.sh 172.17.6.70 &&
				. AVPING.sh 172.17.6.80 && 
				. AVPING.sh 172.17.6.90 && 
				. AVPING.sh 172.17.6.120 && 
				. AVPING.sh 172.17.6.130 && 
				. AVPING.sh 172.17.6.140 && 
				. AVPING.sh 172.17.6.160 &&
				. AVPING.sh 172.17.6.170 && 
				. AVPING.sh 172.17.6.180 && 
				. AVPING.sh 172.17.6.190 && 
				. AVPING.sh 172.17.6.200 && 
				. AVPING.sh 172.17.6.210 && 
				. AVPING.sh 172.17.6.220 && 
				. AVPING.sh 172.17.6.230 && 
				. AVPING.sh 172.17.6.240 
				#. AVPING.sh 172.17.6.30 &&
				#. AVPING.sh 172.17.6.110
				echo "<!DOCTYPE html>" > ping.html
				echo "<HTML>" >> ping.html
				echo "<body>" >> ping.html
				TODAY="$(date +%Y-%m-%d.%H:%M:%S)"
				echo Last check was at $TODAY >> ping.html
				echo "<br/>" >> ping.html	
				echo "</body>" >> ping.html
				echo "</HTML>" >> ping.html
				echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/ping.html
				echo "A+C247srv" | sudo cp ping.html /var/www/html/sites/default/files/ping.html
				rm ping.html
			fi
			if [ "$MIN" == "35" ]; then
				. downcheck.sh &&				
				. AVPING.sh 172.17.6.40 &&
				. AVPING.sh 172.17.6.50 &&
				. AVPING.sh 172.17.6.60 &&
				. AVPING.sh 172.17.6.70 &&
				. AVPING.sh 172.17.6.80 && 
				. AVPING.sh 172.17.6.90 && 
				. AVPING.sh 172.17.6.120 && 
				. AVPING.sh 172.17.6.130 && 
				. AVPING.sh 172.17.6.140 && 
				. AVPING.sh 172.17.6.160 &&
				. AVPING.sh 172.17.6.170 && 
				. AVPING.sh 172.17.6.180 && 
				. AVPING.sh 172.17.6.190 && 
				. AVPING.sh 172.17.6.200 && 
				. AVPING.sh 172.17.6.210 && 
				. AVPING.sh 172.17.6.220 && 
				. AVPING.sh 172.17.6.230 && 
				. AVPING.sh 172.17.6.240 
				#. AVPING.sh 172.17.6.30 &&
				#. AVPING.sh 172.17.6.110
				echo "<!DOCTYPE html>" > ping.html
				echo "<HTML>" >> ping.html
				echo "<body>" >> ping.html
				TODAY="$(date +%Y-%m-%d.%H:%M:%S)"
				echo Last check was at $TODAY >> ping.html
				echo "<br/>" >> ping.html	
				echo "</body>" >> ping.html
				echo "</HTML>" >> ping.html
				echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/ping.html
				echo "A+C247srv" | sudo cp ping.html /var/www/html/sites/default/files/ping.html
				rm ping.html
			fi
			if [ "$MIN" == "40" ]; then
				. downcheck.sh &&				
				. AVPING.sh 172.17.6.40 &&
				. AVPING.sh 172.17.6.50 &&
				. AVPING.sh 172.17.6.60 &&
				. AVPING.sh 172.17.6.70 &&
				. AVPING.sh 172.17.6.80 && 
				. AVPING.sh 172.17.6.90 && 
				. AVPING.sh 172.17.6.120 && 
				. AVPING.sh 172.17.6.130 && 
				. AVPING.sh 172.17.6.140 && 
				. AVPING.sh 172.17.6.160 &&
				. AVPING.sh 172.17.6.170 && 
				. AVPING.sh 172.17.6.180 && 
				. AVPING.sh 172.17.6.190 && 
				. AVPING.sh 172.17.6.200 && 
				. AVPING.sh 172.17.6.210 && 
				. AVPING.sh 172.17.6.220 && 
				. AVPING.sh 172.17.6.230 && 
				. AVPING.sh 172.17.6.240 
				#. AVPING.sh 172.17.6.30 &&
				#. AVPING.sh 172.17.6.110
				echo "<!DOCTYPE html>" > ping.html
				echo "<HTML>" >> ping.html
				echo "<body>" >> ping.html
				TODAY="$(date +%Y-%m-%d.%H:%M:%S)"
				echo Last check was at $TODAY >> ping.html
				echo "<br/>" >> ping.html	
				echo "</body>" >> ping.html
				echo "</HTML>" >> ping.html
				echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/ping.html
				echo "A+C247srv" | sudo cp ping.html /var/www/html/sites/default/files/ping.html
				rm ping.html
			fi
			if [ "$MIN" == "50" ]; then
				. downcheck.sh &&				
				. AVPING.sh 172.17.6.40 &&
				. AVPING.sh 172.17.6.50 &&
				. AVPING.sh 172.17.6.60 &&
				. AVPING.sh 172.17.6.70 &&
				. AVPING.sh 172.17.6.80 && 
				. AVPING.sh 172.17.6.90 && 
				. AVPING.sh 172.17.6.120 && 
				. AVPING.sh 172.17.6.130 && 
				. AVPING.sh 172.17.6.140 && 
				. AVPING.sh 172.17.6.160 &&
				. AVPING.sh 172.17.6.170 && 
				. AVPING.sh 172.17.6.180 && 
				. AVPING.sh 172.17.6.190 && 
				. AVPING.sh 172.17.6.200 && 
				. AVPING.sh 172.17.6.210 && 
				. AVPING.sh 172.17.6.220 && 
				. AVPING.sh 172.17.6.230 && 
				. AVPING.sh 172.17.6.240 
				#. AVPING.sh 172.17.6.30 &&
				#. AVPING.sh 172.17.6.110
				echo "<!DOCTYPE html>" > ping.html
				echo "<HTML>" >> ping.html
				echo "<body>" >> ping.html
				TODAY="$(date +%Y-%m-%d.%H:%M:%S)"
				echo Last check was at $TODAY >> ping.html
				echo "<br/>" >> ping.html	
				echo "</body>" >> ping.html
				echo "</HTML>" >> ping.html
				echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/ping.html
				echo "A+C247srv" | sudo cp ping.html /var/www/html/sites/default/files/ping.html
				rm ping.html
			fi
			if [ "$MIN" == "55" ]; then
				. downcheck.sh &&				
				. AVPING.sh 172.17.6.40 &&
				. AVPING.sh 172.17.6.50 &&
				. AVPING.sh 172.17.6.60 &&
				. AVPING.sh 172.17.6.70 &&
				. AVPING.sh 172.17.6.80 && 
				. AVPING.sh 172.17.6.90 && 
				. AVPING.sh 172.17.6.120 && 
				. AVPING.sh 172.17.6.130 && 
				. AVPING.sh 172.17.6.140 && 
				. AVPING.sh 172.17.6.160 &&
				. AVPING.sh 172.17.6.170 && 
				. AVPING.sh 172.17.6.180 && 
				. AVPING.sh 172.17.6.190 && 
				. AVPING.sh 172.17.6.200 && 
				. AVPING.sh 172.17.6.210 && 
				. AVPING.sh 172.17.6.220 && 
				. AVPING.sh 172.17.6.230 && 
				. AVPING.sh 172.17.6.240 
				#. AVPING.sh 172.17.6.30 &&
				#. AVPING.sh 172.17.6.110
				echo "<!DOCTYPE html>" > ping.html
				echo "<HTML>" >> ping.html
				echo "<body>" >> ping.html
				TODAY="$(date +%Y-%m-%d.%H:%M:%S)"
				echo Last check was at $TODAY >> ping.html
				echo "<br/>" >> ping.html	
				echo "</body>" >> ping.html
				echo "</HTML>" >> ping.html
				echo "A+C247srv" | sudo rm -f /var/www/html/sites/default/files/ping.html
				echo "A+C247srv" | sudo cp ping.html /var/www/html/sites/default/files/ping.html
				rm ping.html
			fi

		fi
		#echo "Right Hour Range wrong Minute Time:$HOUR:$MIN"
		sleep 55
	fi
	if [ "$DAY" -gt "5" ]; then
		echo "Sleeping for 6 hours"		
		sleep 6h	
	fi
done


