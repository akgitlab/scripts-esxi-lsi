#!/bin/sh
#Collecting data from LSI MegaRAID controller
#Andrey Kuznetsov, 2022.02.10

CTRID=$1
STORCLI="/opt/lsi/storcli"
OUT="/tmp/lsimr-c$CTLID-all-info.json"

check_raw_file() {
    if [ -e $OUT ]; then
        rm -rf $OUT
    else
        touch $OUT
    fi
}

create_raw_file() {
    $STORCLI storcli /c$CTLID show all J >> $OUT
}

done
