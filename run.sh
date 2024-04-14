#!/bin/bash
# version 2024-04-14

if [ -e /config/docker-debian-domoticz.txt ]
then
    echo "previous config found"
else
cp -R /src/domoticz/scripts /config/
cp -R /src/domoticz/plugins /config/
cp -R /src/domoticz/www /config/

fi

file="/config/docker-debian-domoticz.txt"
newfile="/src/docker-debian-domoticz.txt"
if [ -f "$file" ] 
then
 version=$(cat "$file")
 newversion=$(cat "$newfile")
  if [ "$version" != "$newversion" ] 
then
    # update config files with new versions
echo "previous config updating ..."
    cp -Ru /src/domoticz/www /config/
    cp -Ru /src/domoticz/plugins /config/
    cp -Ru /src/domoticz/scripts /config/
    cp /src/docker-debian-domoticz.txt /config/
  fi
fi

service mosquitto start
/src/domoticz/domoticz -userdata /config/ -dbase /config/domoticz.db -wwwroot /config/www -sslwww 0


    
