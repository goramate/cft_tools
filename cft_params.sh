#!/bin/bash
if [[ $# -gt 0 ]]
then
   source $1.stack
   aws cloudformation describe-stacks --stack-name  $stack_name | jq .Stacks[0].Parameters
fi
