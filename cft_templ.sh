#!/bin/bash
if [[ $# -gt 0 ]]
then
   source $1.stack
   aws cloudformation get-template --stack-name  $stack_name | jq .TemplateBody -r
fi
