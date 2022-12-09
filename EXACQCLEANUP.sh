#mount drive on server
sudo mount -t cifs -o username=Security,domain=workgroup,password=nor74%Some%%,vers=3.0 //172.25.122.16/EXACQarchive /EXACQ
#echo "lets change directories to /EXACQ/$(date +%Y/%m -d "120 days ago")"
#cd /EXACQ/$(date +%Y/%m -d "111 days ago")
#Gets year 111 days ago
#cd $(date +%Y -d "111 days ago")
#Change directory to 111 days ago month
#cd $(date +%m -d "111 days ago")
#remove folder and subfolder from 111 days previous
echo "Cleanup for $(date +%Y/%m/%d)" >> EXACQCLEANUP.txt
echo "Deleting /EXACQ/$(date +%Y/%m/%d -d "91 days ago")" >> EXACQCLEANUP.txt
sudo rm -rf /EXACQ/$(date +%Y/%m/%d -d "91 days ago")
#echo "I should have removed the folder with the command sudo rm -rf /EXACQ/$(date +%Y/%m/%d -d "111 days ago")"
#need to add a provision in for if the day 111 days ago is a 01 then need to remove the previous month and then the same for the year

#This will remove the month folder previous of the previous month if it exists
#echo "I am going to compare $(date +%d -d "111 days ago") to 01"
if [ "$(date +%d -d "90 days ago")" -eq "01" ]; then
	if [ -d "/EXACQ/$(date +%Y/%m -d "91 days ago")" ]; then
		echo "I am now be running the command sudo rm -rf $(date +%m -d "91 days ago") to remove the previous month" >> EXACQCLEANUP.txt
		sudo rm -rf $(date +%m -d "91 days ago")
	fi
fi
#This will remove the previous year if the Month is January and the previous year exists
#echo " I am going to compare $(date +%m -d "111 days ago") to 12"
if [ "$(date +%m -d "90 days ago")" -eq "01" ]; then
	if [ -d "/EXACQ/$(date +%Y -d "91 days ago")" ]; then
		echo "I am now be running the command sudo rm -rf $(date +%Y -d "91 days ago") to remove the previous Year" >> EXACQCLEANUP.txt
		sudo rm -rf $(date +%Y -d "91 days ago")
	fi
fi
sudo mysql drupal --batch -u root -p"A+C247srv" -e "UPDATE node__field_monitoring_feedback SET field_monitoring_feedback_value= '<p><b><font color="red">Oldest content on server should be $(date +%Y/%m/%d -d "91 days ago")</font></b></p>\r\n' WHERE entity_id='289'"
sudo mysql drupal --batch -u root -p"A+C247srv" -e "UPDATE node__field_monitoring_feedback SET field_monitoring_feedback_value= '<p><font color="red">Oldest content on server should be $(date +%Y/%m/%d -d "91 days ago")</font></p>\r\n' WHERE entity_id='290'"
#I now should write something out to a file to update on the file server but need to do an error check on all commands to ensure the delete was successful.
umount /EXACQ
sudo mysql drupal --batch -u root -p"A+C247srv" -e "TRUNCATE cache_entity"
sudo mysql drupal --batch -u root -p"A+C247srv" -e "TRUNCATE cache_render"
sudo mysql drupal --batch -u root -p"A+C247srv" -e "TRUNCATE cache_data"
echo "I am done" >> EXACQCLEANUP.txt

