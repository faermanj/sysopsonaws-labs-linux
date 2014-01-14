#!/bin/bash
TARGET=$1
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone/ | sed -e 's/.$//')
INSTANCES=$(aws ec2 describe-instances --filters Name=instance-state-name,Values=running --region=$REGION --output=text --query='Reservations[*].Instances[*].InstanceId')
echo "Removing current instances"
curl -s -X DELETE $TARGET > /dev/null
for i in $INSTANCES 
do
  echo "Adding instance $i"
  curl -s -X PUT -d instanceId=$i $TARGET > /dev/null  
done