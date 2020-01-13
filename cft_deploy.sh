#!/bin/bash
set -x
if [[ $# -gt 0 ]]
then
   source $1.stack
   aws cloudformation deploy \
   --template-file $local_template \
   --stack-name $stack_name
   #--parameter-overrides Key1=Value1 Key2=Value2
   #--tags Key1=Value1 Key2=Value2
    #aws cloudformation validate-template --template-body file://$local_template
    aws cloudformation describe-stack-events --stack-name $stack_name
fi
