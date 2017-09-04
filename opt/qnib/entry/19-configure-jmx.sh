#!/bin/bash
set -x

sed -i'' -e "s/JMX_PORT/${JMX_PORT}/g" /opt/prometheus/jmx/*.yml
