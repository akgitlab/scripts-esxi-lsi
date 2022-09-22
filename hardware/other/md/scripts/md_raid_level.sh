#!/bin/bash

# получаем имя массив
MDNAME=$1

#если имя массива не передано - ошибка
if [[ $MDNAME = "" ]]; then
    echo "-1" | bash                               
else
    MDSTR="mdadm --detail /dev/$MDNAME | grep 'Raid Level :' | awk '{print \$4}'"
    MDSTR=`echo $MDSTR | bash`
    if [[ $MDSTR = "" ]]; then
        echo "0"
    else
        echo $MDSTR
    fi
fi
  