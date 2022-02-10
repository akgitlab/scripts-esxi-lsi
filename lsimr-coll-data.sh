#!/bin/sh
#Collecting data from LSI MegaRAID controller
#Andrey Kuznetsov, 2022.02.10

CTRID=$1
STORCLI="/opt/lsi/storcli"
OUT="/tmp/lsimr-$CTLID-all-info.json"

check_old_file() {
    if [ -e $OUT ]; then
        rm -rf $OUT
    else
        touch $OUT
    fi
}

create_new_file() {
    $STORCLI storcli /$CTLID show all J > $OUT
}

done
