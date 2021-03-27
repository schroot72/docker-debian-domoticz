# docker-debian-domoticz
files to make a docker container for Domoticz based on Debian

These files are used to make a Domoticz instance on Docker. The containers are placed in https://hub.docker.com/repository/docker/schrooten/debian-domoticz 

currently there is only one file for the latest domoticz instance. second file is in the making, creating the latest beta release.

run.sh is used for all initial & startup commands.

# versions
version 1.1: deCONZ Zigbee stick added, ENV variables added in make file and versioning
version 1.0: initial release: domoticz, mqtt, ZWave & TUYA Web plugin

# ToDo
remove SSL certficate generation, localy created SSL is probably not a good idea. I'm using Domoticz behind a reverse proxy now.
update the plugins to the config folder. Currently config is copied when config folder is empty
add Siemens/Bosch platform for dishwasher / oven etc.

# Beta vs Regular
in the Beta release Domoticz is upgraded to the latest beta. Plugins are the same version.
