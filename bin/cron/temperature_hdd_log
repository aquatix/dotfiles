#!/bin/bash
#temperature:             23 C

#TEMPERATURE=`awk '{print $2}' /proc/acpi/thermal_zone/THRM/temperature`
MONTH=`date +%Y-%m`
DATE=`date +%Y-%m-%d`
for HDD in sda sdb sdc sdd sde sdf sdg
do
	#TEMPERATURE=`awk '{print $NF}' /root/tmp/hddtemp`
        if [ "$HDD" == "sdb" ]; then
		TEMPERATURE=`/usr/sbin/smartctl -A /dev/${HDD} | grep \ Temperature_Cel | awk '{print $10}'`
	else
		TEMPERATURE=`/usr/sbin/smartctl -A /dev/${HDD} | grep Temperature_Cel | awk '{print $10}'`
	fi
        #if [ "$HDD" == "sde" ]; then
	#	TEMPERATURE=`/usr/sbin/smartctl -A /dev/sde | grep Temperature_Cel | awk '{print $10}'`
        #elif [ "$HDD" == "sdf" ]; then
	#	TEMPERATURE=`/usr/sbin/smartctl -A /dev/sdf | grep Temperature_Cel | awk '{print $10}'`
        #elif [ "$HDD" == "sdc" ]; then
	#	TEMPERATURE=`/usr/sbin/smartctl -A /dev/sdc | grep Temperature_Cel | awk '{print $10}'`
        #elif [ "$HDD" == "sdd" ]; then
	#	TEMPERATURE=`/usr/sbin/smartctl -A /dev/sdd | grep Temperature_Cel | awk '{print $10}'`
	#else
	#	RAWTEMP=`/usr/sbin/hddtemp /dev/$HDD`
	#	#echo $RAWTEMP
	#	TEMPERATURE=`echo $RAWTEMP | awk '{print $NF}' | sed 's/°C//g'`
	#fi
	LOG="/var/log/custom_logs/hdd/temperature_${HDD}_${MONTH}.log"
	TIMESTAMP=`date "+%Y%m%d %H%M"`
	echo "${TIMESTAMP} $TEMPERATURE" >> ${LOG}
	#echo "${HDD} ${TIMESTAMP} $TEMPERATURE"
	#echo "${TIMESTAMP} $TEMPERATURE"

	LOG="/var/log/custom_logs/temp_daily/hdd/temperature_${HDD}_${DATE}.log"
	#TIMESTAMP=`date "+%Y%m%d %H%M"`
	echo "${TIMESTAMP} $TEMPERATURE" >> ${LOG}
done
