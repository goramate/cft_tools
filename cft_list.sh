#!/bin/bash
if [[ $# -gt 0 ]]; then
  region="--region $1"
fi
aws cloudformation list-stacks $region |  jq '.StackSummaries[] | "\(.StackName),\(.StackStatus),\(.LastUpdatedTime)"' | grep -v "DELETE_COMPLETE" | sed 's/\"//g'|column -t -s, -n   | sort
