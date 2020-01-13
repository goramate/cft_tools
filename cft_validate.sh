#!/bin/bash
#set -x
if [[ $# -gt 0 ]]
then
   source $1.stack
    aws cloudformation validate-template --template-body file://$local_template
fi
