#!/bin/bash
#set -x
if [[ $# -gt 0 ]]
then
   echo $@
   source $1.stack
   shift
   if [[ $# -gt 0 ]]; then
     aws cloudformation deploy \
     --template-file $local_template \
     --stack-name $stack_name \
     --parameter-overrides $@
   else
     aws cloudformation deploy \
     --template-file $local_template \
     --stack-name $stack_name
   fi
    aws cloudformation describe-stack-events --stack-name $stack_name \
    | jq '.StackEvents[]|"\(.Timestamp),\(.LogicalResourceId),\(.ResourceStatus),\(.ResourceStatusReason)"' \
    | sort -r |column -t -s, -n
fi
