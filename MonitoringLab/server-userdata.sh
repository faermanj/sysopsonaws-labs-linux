#!/bin/bash
easy_install pip
pip install setuptools --no-use-wheel --upgrade
pip install Flask
curl -s -O -L https://github.com/awstrainingandcertification/sysopsonaws-labs-linux/archive/master.zip
unzip master.zip -d /usr/local/
python /usr/local/sysopsonaws-labs-linux-master/MonitoringLab/server.py &