#!/bin/bash
#Collecting data from LSI MegaRAID controller
#Andrey Kuznetsov, 2022.02.20

# Get variables
HVUID=$1
PDNAME=$2
HOST=$(grep -w $HVUID /etc/zabbix/scripts/lsimr-hosts-info | awk '{print $NF}')

# We form the data of the received controller
CTLSTR="ssh -i /var/lib/zabbix/.ssh/id_rsa zabbix@$HOST '/opt/lsi/storcli/storcli $PDNAME show all j'"
echo $CTLSTR | bash
