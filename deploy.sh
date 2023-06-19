#!/bin/bash
cp /tmp/sample.war /var/lib/tomcat9/webapps/sample.war
systemctl restart tomcat9
