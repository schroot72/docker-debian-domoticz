!/bin/bash


[[ ! -e /config/scripts ]] && cp -R /src/domoticz/scripts /config/
[[ ! -e /config/plugins ]] && cp -R /src/domoticz/plugins /config/

if [ ! -e /config/keys/server_cert.pem ]; then
                [[ -e /config/keys/RSA2048.pem ]] && rm /config/keys/RSA2048.pem
                        mkdir /config/keys
                        openssl dhparam -out /config/keys/RSA2048.pem -5 2048
                        openssl req -x509 -nodes -days 365 \
                        -newkey rsa:2048 -keyout /config/keys/server_cert.pem  -out /config/keys/server_cert.pem \
                        -subj "/CN=domoticz"
                        cat /config/keys/RSA2048.pem >> /config/keys/server_cert.pem
        fi

service mosquitto start
/src/domoticz/domoticz -sslcert /config/keys/server_cert.pem -userdata /config/ -dbase /config/domoticz.db -sslwww 1443 
#service domoticz.sh start
#xtail /tmp/domoticz.txt