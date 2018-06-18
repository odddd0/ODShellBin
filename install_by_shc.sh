#!/bin/bash

cd `dirname $0`
workpath=`pwd`/src

cd ~
homepath=`pwd`
binpath=$homepath/bin

mkdir $workpath/../bin 2>/dev/null
mkdir $workpath/../build 2>/dev/null

curTime=`date +%s`
# one month later 
expirationTime=`expr $curTime + 2592000`
expirationTimeStr=`date -r $expirationTime +%d/%m/%Y`

for cur in $workpath/*
do
	fileGeneral=`hexdump -n 11 -e '16/1 "%02X" ' $cur`
	fileGeneral=`echo $fileGeneral`
	if [ "$fileGeneral" == "23212F62696E2F62617368" ] ; then
		fileName=`basename $cur`
		cp $cur $workpath/../build/$fileName
		shc -e $expirationTimeStr -f $workpath/../build/$fileName -o $workpath/../bin/$fileName
		if [ "$1" == "-i" ] ; then
			cp $workpath/../bin/$fileName $binpath
		fi
	fi
done
