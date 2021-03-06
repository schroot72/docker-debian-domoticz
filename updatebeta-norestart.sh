#!/bin/sh

# This script can be used to upgrade to the latest beta version

lowercase(){
    echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

OS=`lowercase \`uname -s\``
MACH=`uname -m`
if [ ${MACH} = "armv6l" ]
then
 MACH="armv7l"
fi

echo "Updating to latest beta version..."
echo "Please Standby..."
wget -4 -O domoticz_beta.tgz --no-check-certificate "https://www.domoticz.com/download.php?channel=beta&type=release&system=${OS}&machine=${MACH}"
echo "Checking file Integrity..."
tar -tzf domoticz_beta.tgz >/dev/null
if [ $? -ne 0 ]
then
 echo "Problem in downloaded Domoticz archive. Stopping update!"
 exit 1
fi
tar xvfz domoticz_beta.tgz
rm domoticz_beta.tgz
