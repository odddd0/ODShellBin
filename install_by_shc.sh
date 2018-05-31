#!/bin/bash

cd `dirname $0`
workpath=`pwd`/src

mkdir $workpath/../bin 2>/dev/null
mkdir $workpath/../build 2>/dev/null

for cur in $workpath/*
do
	fileGeneral=`hexdump -n 11 -e '16/1 "%02X" ' $cur`
	fileGeneral=`echo $fileGeneral`
	if [ "$fileGeneral" == "23212F62696E2F62617368" ] ; then
		fileName=`basename $cur`
		cp $cur $workpath/../build/$fileName
		shc -f $workpath/../build/$fileName -o $workpath/../bin/$fileName
	fi
done
