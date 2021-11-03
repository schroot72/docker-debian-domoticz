!/bin/bash


[[ ! -e /config/scripts ]] && cp -R /src/domoticz/scripts /config/
[[ ! -e /config/plugins ]] && cp -R /src/domoticz/plugins /config/
[[ ! -e /config/www ]] && cp -R /src/domoticz/www /config/

service mosquitto start
/src/domoticz/domoticz -userdata /config/ -dbase /config/domoticz.db -wwwroot /config/www -sslwww 0
#service domoticz.sh start
#xtail /tmp/domoticz.txt
