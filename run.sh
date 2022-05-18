#!/bin/bash


[[ ! -e /config/scripts ]] && cp -R /src/domoticz/scripts /config/
[[ ! -e /config/plugins ]] && cp -R /src/domoticz/plugins /config/
[[ ! -e /config/www ]] && cp -R /src/domoticz/www /config/

file="/config/docker-debian-domoticz.txt"
if [ -f "$file" ] 
then
 version=$(cat "$file")
  if [ "$version" != "versie 1.3.0" ] 
then
    cp -Ru /src/domoticz/www /config/
   cp /src/docker-debian-domoticz.txt /config/
  fi
fi

service mosquitto start
/src/domoticz/domoticz -userdata /config/ -dbase /config/domoticz.db -wwwroot /config/www -sslwww 0
