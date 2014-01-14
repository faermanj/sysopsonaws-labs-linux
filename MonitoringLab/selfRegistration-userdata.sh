#!/bin/bash
curl -X PUT \
  -d instanceId=$(curl -s http://169.254.169.254/latest/meta-data/instance-id) \
  [server_url]