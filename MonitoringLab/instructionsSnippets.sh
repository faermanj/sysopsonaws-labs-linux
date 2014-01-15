# Interacting with CloudWatch
## Topic 3.2

wget http://ec2-downloads.s3.amazonaws.com/cloudwatch-samples/CloudWatchMonitoringScripts-v1.1.0.zip
unzip CloudWatchMonitoringScripts-v1.1.0.zip 
rm CloudWatchMonitoringScripts-v1.1.0.zip 
cd aws-scripts-mon

## Topic 3.3

./mon-put-instance-data.pl --mem-avail

## topic 3.4 

echo "*/5 * * * * ~/aws-scripts-mon/mon-put-instance-data.pl --mem-avail" | crontab 

## Topic 4.1

aws cloudwatch get-metric-statistics \
 --metric-name "MemoryAvailable" \
 --namespace="System/Linux" \
 --start-time=$(date -d yesterday -I) \
 --end-time=$(date -d tomorrow -I) \
 --period=300 \
 --statistics="Minimum" \
 --dimensions Name=InstanceId,Value=$(curl -s http://169.254.169.254/latest/meta-data/instance-id) \
 --region=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | rev | cut -c 2- | rev)

## Topic 7.2

curl -s https://raw.github.com/jfaerman/sysopsonaws-labs-linux/master/MonitoringLab/allocateMemory.py | python -

# Integrating with Other Monitoring Services

## Start the Monitoring Server - Topic 4

#!/bin/bash
easy_install pip
pip install setuptools --no-use-wheel –upgrade
pip install Flask
curl -s -O -L https://github.com/awstrainingandcertification/sysopsonaws-labs-linux/archive/master.zip
unzip master.zip -d /usr/local/
python /usr/local/sysopsonaws-labs-linux-master/MonitoringLab/server.py &

## Client Self-Registration - Topic 7

#!/bin/bash
curl -X PUT \
  -d instanceId=$(curl -s http://169.254.169.254/latest/meta-data/instance-id) \
 [monitoring_server_url]

## Full Scan / Config Rewrite - Topic 8

echo "*/2 * * * * /usr/local/sysopsonaws-labs-linux-master/MonitoringLab/pollInstances.sh [monitoring_server_url]" | crontab -

## Messaging (SNS and SQS) - Topic 7 

/usr/local/sysopsonaws-labs-linux-master/consumeEvents.sh [queue_url] [monitoring_server_url]
