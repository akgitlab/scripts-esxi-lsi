#!/bin/bash

MAILLOG=/var/log/mail.log
TEMPDIR=/tmp/postfix_data/
PARTLOG=${TEMPDIR}partlog.log
OFFSETFILE=${TEMPDIR}offset.dat
DATAFILE=${TEMPDIR}data.dat
LOGTAIL=/usr/sbin/logtail

VALS=( 'bounced' 'deferred' 'sent' 'expired' 'reject' 'connect_from' 'connect_to' 'refused' 'queue' )

[ ! -e "${TEMPDIR}" ] && mkdir "${TEMPDIR}" && chown zabbix:zabbix "${TEMPDIR}"
[ ! -e "${DATAFILE}" ] && touch "${DATAFILE}" && chown zabbix:zabbix "${DATAFILE}"
[ ! -e "${PARTLOG}" ] && touch "${PARTLOG}" && chown zabbix:zabbix "${PARTLOG}"

# read data
if [ -n "$1" ]; then
    key=$(echo ${VALS[@]} | grep -wo $1)
    if [ -n "${key}" ]; then
        value=$(cat "${DATAFILE}" | sort -u | grep -e "^${key};" | cut -d ";" -f2)
        echo "${value}"
    else
        exit 2
    fi

# write data
else
    "${LOGTAIL}" -f"${MAILLOG}" -o"${OFFSETFILE}" > ${PARTLOG}
    for i in "${VALS[@]}"; do
        case ${i} in
            "bounced")
            value=$(grep "status=bounced" ${PARTLOG} | wc -l)
            ;;
            "deferred")
            value=$(grep "status=deferred" ${PARTLOG} | wc -l)
            ;;
            "sent")
            value=$(grep "status=sent" ${PARTLOG} | wc -l)
            ;;
            "expired")
            value=$(grep "status=expired" ${PARTLOG} | wc -l)
            ;;
            "reject")
            value=$(grep "NOQUEUE: reject" ${PARTLOG} | wc -l)
            ;;
            "connect_from")
            value=$(grep ": connect from" ${PARTLOG} | wc -l)
            ;;
            "connect_to")
            value=$(grep ": connect to" ${PARTLOG} | wc -l)
            ;;
            "refused")
            value=$(grep "refused to talk to me:" ${PARTLOG} | wc -l)
            ;;
            "queue")
            value=$(mailq | grep -v "Mail queue is empty" | grep -c "^[A-F0-9]")
            ;;
        esac
        if grep -q ${i} ${DATAFILE}; then
            sed -i "s/^${i};.*$/${i};${value}/" "${DATAFILE}"
        else
            echo "${i};${value}" >> "${DATAFILE}"
            sort -u "${DATAFILE}" -o "${DATAFILE}"
        fi
    done
fi
