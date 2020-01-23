#!/bin/bash
#set -x
if [[ $# -gt 0 ]]
then
   source $1.stack
    aws cloudformation describe-stack-events --stack-name $stack_name \
    | jq '.StackEvents[]|"\(.Timestamp),\(.LogicalResourceId),\(.ResourceStatus),\(.ResourceStatusReason)"' \
    | sort -r |column -t -s, -n | less 
fi
