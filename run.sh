#!/bin/bash
# version 2022-05-19

[[ ! -e /config/scripts ]] && cp -R /src/domoticz/scripts /config/
[[ ! -e /config/plugins ]] && cp -R /src/domoticz/plugins /config/
[[ ! -e /config/www ]] && cp -R /src/domoticz/www /config/

file="/config/docker-debian-domoticz.txt"
newfile="/src/docker-debian-domoticz.txt"
if [ -f "$file" ] 
then
 version=$(cat "$file")
 newversion=$(cat "$newfile")
  if [ "$version" != "$newversion" ] 
then
    cp -Ru /src/domoticz/www /config/
   cp /src/docker-debian-domoticz.txt /config/
  fi
fi

service mosquitto start
/src/domoticz/domoticz -userdata /config/ -dbase /config/domoticz.db -wwwroot /config/www -sslwww 0
