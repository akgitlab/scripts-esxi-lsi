#!/bin/bash
# Collecting data from LSI MegaRAID controller
# Andrey Kuznetsov, 2022.02.15

# Get variables
HOST=$1
CTLID=$2

# Get controller id
# If the controller id is not passed, we display all the information
    if [[ $CTLID = "" ]]; then
       echo "ssh -i /var/lib/zabbix/.ssh/id_rsa zabbix@$HOST '/opt/lsi/storcli/storcli show all j'" | bash
    else
# Integer test value of a variable
    re='^[0-9]+$'
    if ! [[ $CTLID =~ $re ]] ; then
       echo "error: Not a number" >&2; exit 1
    else
# We form the data of the received controller
        CTLSTR="ssh -i /var/lib/zabbix/.ssh/id_rsa zabbix@$HOST '/opt/lsi/storcli/storcli /c$CTLID show all j'"
        echo $CTLSTR | bash
    fi
fi
