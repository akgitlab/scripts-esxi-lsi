#!/bin/bash

# Collecting data from network adapters
# Andrey Kuznetsov, 2022.02.23

# Get variables
HVUID=$1
NICID=$2
HOST=$(grep -w $HVUID /usr/lib/zabbix/internalscripts/hardware/esxi/hosts-uid-map.txt | awk '{print $NF}')

# Get controller id
# If the controller id is not passed, we display all the information
    if [[ $NICID = "" ]]; then
       echo "ssh -i /usr/lib/zabbix/.ssh/id_rsa zabbix@$HOST 'esxcli --debug --formatter=json network nic list'" | bash
    else
# Integer test value of a variable
    re='^[A-Za-z0-9]+$'
    if ! [[ $NICID =~ $re ]] ; then
       echo "error: Not correct name" >&2; exit 1
    else
# We form the data of the received controller
        STR="ssh -i /usr/lib/zabbix/.ssh/id_rsa zabbix@$HOST 'esxcli --debug --formatter=json network nic get -n $NICID'"
        echo $STR | bash
    fi
fi
