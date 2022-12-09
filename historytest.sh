ENTITYID=2
HELP="START OF HELP"
sudo mysql drupal --batch -u root -p"A+C247srv" -e "SELECT delta FROM node__field_history WHERE entity_id='$ENTITYID' ORDER BY delta DESC LIMIT 1" >> lastdelta.txt
while read -r delta
do
	DELTA=$delta
done <lastdelta.txt
DELTA=$((DELTA+1))
HELP="${HELP} MORE TROUBLESHOOTING"
sudo mysql drupal --batch -u root -p"A+C247srv" -e "SELECT revision_id FROM node__field_history WHERE entity_id='$ENTITYID' ORDER BY delta DESC LIMIT 1" >> lastrev.txt
while read -r revid
do
	REVID=$revid
done <lastrev.txt
echo delta is $DELTA and Revisionid is $REVID
echo $HELP
