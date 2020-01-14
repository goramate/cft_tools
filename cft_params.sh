#!/bin/bash
set -x
if [[ $# -gt 0 ]]
then
  source $1.stack
  if [[ -v region ]]; then
     region=" --region $region "
  fi

  if [ -n ${param_file} ]; then
    if [ ! -f "$param_file" ]; then
        aws cloudformation describe-stacks $region --stack-name  $stack_name | jq .Stacks[0].Parameters > $param_file
    fi
  fi
  local_parameters_tmp_file=$(mktemp)
  cft_parameters_tmp_file=$(mktemp)
  cat $param_file |  jq '.[]| "\(.ParameterKey):\(.ParameterValue)"' | sort > $local_parameters_tmp_file
  aws cloudformation describe-stacks $region --stack-name  $stack_name | jq '.Stacks[0].Parameters[]  | "\(.ParameterKey):\(.ParameterValue)"' | sort > $cft_parameters_tmp_file
  cat $cft_parameters_tmp_file | sed 's/:/=/'
  diff $local_parameters_tmp_file $cft_parameters_tmp_file
  rm -rf $local_parameters_tmp_file $cft_parameters_tmp_file
fi
