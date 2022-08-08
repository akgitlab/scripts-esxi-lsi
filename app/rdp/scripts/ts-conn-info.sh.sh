#!/bin/bash

# Checking connectivity to MS Terminal server
# Andrey Kuznetsov, 2022.08.08

# Get variables
DOMAIN=$1
USERNAME=$2
PASSWORD=$3
FDQN=$4
OUTFILE=$(xfreerdp /u:$USERNAME /d:$DOMAIN /p:$PASSWORD /v:$FDQN +auth-only /log-level:ERROR > /home/devops/$FDQN.log 2>&1)

RESULT="cat /home/devops/$FDQN.log | grep -m1 "Authentication only" | awk '{print substr($0,length,1)}'"
echo $RESULT | bash
