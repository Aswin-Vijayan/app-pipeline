#!/bin/bash

JAR_FILE=/home/ubuntu/petclinic-3.0.7.jar
APP_PROPERTIES=/opt/application.properties
PROPERTIES_SCRIPT=/home/ubuntu/properties.py

# to run python script
sudo python3 ${PROPERTIES_SCRIPT}

# start consul
sudo nohup consul agent -config-dir /etc/consul.d/ &

# start jmx and petclinic application jar file
sudo java -jar ${JAR_FILE} --spring.config.location=${APP_PROPERTIES} --spring.profiles.active=mysql &

sudo java -javaagent:/home/ubuntu/jmx_prometheus_javaagent-0.18.0.jar=9090:/home/ubuntu/config.yml
