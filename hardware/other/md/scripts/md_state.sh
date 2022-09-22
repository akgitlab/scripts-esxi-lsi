#!/bin/bash

# получаем имя массив
MDNAME=$1

#если имя массива не передано - ошибка
if [[ $MDNAME = "" ]]; then
    echo "-1" | bash                               
else
    MDSTR="mdadm --detail /dev/$MDNAME | grep 'State :' | awk '{split(\$0,a,\":\"); print a[2]}'"
    MDSTR=`echo $MDSTR | bash`
    if [[ $MDSTR = "" ]]; then
        echo "no state"
    else
        echo $MDSTR
    fi
fi
  