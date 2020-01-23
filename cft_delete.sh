#!/bin/bash
if [[ $# -gt 0 ]]
then
  source $1.stack
  if [[ -v region ]]; then
     region=" --region $region "
  fi

  read -p "Are you sure? " -n 3 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^Yes$ ]]
  then
    aws cloudformation delete-stack --stack-name $stack_name
    echo -ne '#####                     (33%)\r'
    sleep 5
    echo -ne '#############             (66%)\r'
    sleep 5
    echo -ne '#######################   (100%)\r'
    aws cloudformation describe-stack-events --stack-name $stack_name \
    | jq '.StackEvents[]|"\(.Timestamp),\(.LogicalResourceId),\(.ResourceStatus),\(.ResourceStatusReason)"' \
    | sort -r |column -t -s, -n
  fi

fi
