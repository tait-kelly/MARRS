IP=$1
FAILED="0"
TODAY="$(date +%Y%m%d%H%M%S)"
ping -c 2 $IP|grep 'errors'
if [ "$?" == "0" ]; then
	FAILED="1"
fi
if [ "$FAILED" == "1" ]; then
	s /home/sysadmin/Documents/errors |grep $IP.txt
	if [ "$?" == "0" ]; then
		#m /home/sysadmin/Documents/errors/$IP.txt
	fi
	ls /home/sysadmin/Documents/errors |grep $IP.txt
	if [ "$?" == "1" ]; then
		sendemail -f sjuit@sju.ca -t tait.kelly@uwaterloo.ca -u Communications failure on Device:$IP -m "PING CHECK HAS FAILED ON DEVICE WITH IP $IP. PLEASE INVESITGATE" -s mail2.nettrac.net:2500 -xu sjuit@sju.ca -xp "?Mm&FdfU"
		echo "$TODAY:There is an error on Device $IP." >> /home/sysadmin/Documents/errors/$IP.log
		echo "$TODAY:There is an error on Device $IP." >> /home/sysadmin/Documents/errors/$IP.txt
	fi
fi	
if [ "$FAILED" == "0" ]; then
	ls /home/sysadmin/Documents/errors |grep $IP.txt
	if [ "$?" == "0" ]; then
		rm /home/sysadmin/Documents/errors/$IP.txt
	fi
fi

