#!/bin/bash

APP_JAR_FILE=/home/ubuntu/petclinic-3.0.7.jar
AGENT_JAR_FILE=/home/ubuntu/jmx_prometheus_javaagent-0.18.0.jar
APP_PROPERTIES=/opt/application.properties
PROPERTIES_SCRIPT=/home/ubuntu/properties.py

# to run the Python script
sudo python3 "${PROPERTIES_SCRIPT}"

# start consul
sudo nohup consul agent -config-dir /etc/consul.d/ &

# start JMX and petclinic application jar file
sudo java -javaagent:"${AGENT_JAR_FILE}=9090:/home/ubuntu/config.yml" -jar "${APP_JAR_FILE}" --spring.config.location="${APP_PROPERTIES}" --spring.profiles.active=mysql &
