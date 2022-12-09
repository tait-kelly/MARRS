#!/bin/bash
IP=$1
TODAY="$(date +%Y%m%d%H%M%S)"
sshpass -p 'A+C247av' ssh -o StrictHostKeyChecking=no sysadmin@$IP 'reboot'

