#!/bin/bash
MAXNID=$(sudo mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT max(nid) FROM node")
MAXVID=$(sudo mysql drupal --batch -u root -p"A+C247srv" -s -e "SELECT max(vid) FROM node")
NID=$((MAXNID+1))
VID=$((MAXVID+1))
echo "I have a nid of $NID"
echo "I have a vid of $VID"
#sleep 5
sudo mysql drupal --batch -u root -p"A+C247srv" -e "INSERT INTO `node_field_data`(nid,vid,type,langcode,status,title,uid,created,changed,promote,sticky,default_langcode,revision_translation_affected,ds_switch) VALUES ('$NID','$VID','av_alert','en','1','SAMPLE TITLE','1','$(date +%s)','$(date +%s)','0','0','1','1',null);"
#sudo mysql drupal --batch -u root -p"A+C247srv" -e "INSERT INTO `node__field_averror'(bundle,deleted,entity_id,revision_id,langcode,delta,field_averror_value) VALUES ('av_alert','0','$NID','$VID','en','0','THis is the first script test error');" #Need to change error code to the text
#sudo mysql drupal --batch -u root -p"A+C247srv" -e "INSERT INTO `node__field_avid` VALUES ('av_alert','0','$NID','$VID','en','0','987654');" #Need to change AVID to the AVID
#sudo mysql drupal --batch -u root -p"A+C247srv" -e "INSERT INTO `node__field_datetime` VALUES ('av_alert','0','$NID','$VID','en','0','$(date -u +%Y-%m-%dT%H:%M:%S)');"
#sudo mysql drupal --batch -u root -p"A+C247srv" -e "INSERT INTO `node__field_resolved` VALUES ('av_alert','0','$NID','$VID','en','0','1');"
#sudo mysql drupal --batch -u root -p"A+C247srv" -e "INSERT INTO `node__field_roomnum` VALUES ('av_alert','0','$NID','$VID','en','0','2011');" #Need to change room to the variable
#sudo mysql drupal --batch -u root -p"A+C247srv" -e "INSERT INTO `node__field_rtcreated` VALUES ('av_alert','0','$NID','$VID','en','0','1');" 
#sudo mysql drupal --batch -u root -p"A+C247srv" -e "INSERT INTO `node_field_data` VALUES ('$NID','$VID','av_alert','en','1','SAMPLE TITLE','1','$(date +%s)','$(date +%s)','0','0','1','1',null);"
echo "DONE"
