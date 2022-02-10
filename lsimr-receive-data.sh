#!/bin/sh
#Receive data of LSI MegaRAID controller from ESXI hosts
#Andrey Kuznetsov, 2022.02.10

KEY="/var/lib/zabbix/.ssh/id_rsa"
IN="/usr/lib/zabbix/reports/hypervisors/$HOST/lsimr-$CTLID-all-info.json"

cat /usr/lib/zabbix/scripts/esxi/hosts |  while read HOST ADDRESS CTRL
do
scp -i $KEY zabbix@$ADDRESS:/tmp/lsimr-$CTRL-all-info.json /usr/lib/zabbix/reports/hypervisors/$HOST/lsimr-$CTRL-all-info.json

done
