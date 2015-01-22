#!/bin/bash
#temperature:             23 C

#TEMPERATURE=`awk '{print $2}' /proc/acpi/thermal_zone/THRM/temperature`
MONTH=`date +%Y-%m`
DATE=`date +%Y-%m-%d`
for HDD in sda sdb sdc sdd
do
	RAWTEMP=`/usr/sbin/hddtemp /dev/$HDD`
	#echo $RAWTEMP
	#TEMPERATURE=`awk '{print $NF}' /root/tmp/hddtemp`
	TEMPERATURE=`echo $RAWTEMP | awk '{print $NF}' | sed 's/°C//g'`
	LOG="/var/log/custom_logs/hdd/temperature_${HDD}_${MONTH}.log"
	TIMESTAMP=`date "+%Y%m%d %H%M"`
	echo "${TIMESTAMP} $TEMPERATURE" >> ${LOG}
	#echo "${TIMESTAMP} $TEMPERATURE"

	LOG="/var/log/custom_logs/temp_daily/hdd/temperature_${HDD}_${DATE}.log"
	#TIMESTAMP=`date "+%Y%m%d %H%M"`
	echo "${TIMESTAMP} $TEMPERATURE" >> ${LOG}
done
