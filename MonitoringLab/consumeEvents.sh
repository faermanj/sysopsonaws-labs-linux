QURL=$1
SERVER=$2
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone/ | sed -e 's/.$//')
for ((;;))
do
  echo "Waiting for events"
  MSG_HANDLE=$(aws sqs receive-message --region=$REGION --wait-time-seconds=5 --queue-url=$QURL --output=text --max-number-of-messages=1 --query='Messages[*].ReceiptHandle')
  if [ -n "$MSG_HANDLE" ]; then
    echo "Received auto scaling event message handle $MSG_HANDLE"
    /usr/local/sysopsonaws-labs-linux-master/pollInstances.sh $SERVER
    echo "Event processed, removing from queue"	
    aws sqs delete-message --region=$REGION --queue-url $QURL --receipt-handle $MSG_HANDLE
  fi
done
