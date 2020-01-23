#!/bin/bash
set -x
set -e
if [[ $# -gt 0 ]]
then
  source $1.stack
  if [[ -v nested_templates && -v template_bucket ]]; then
    for i in $(echo $nested_templates | sed "s/,/ /g")
    do
       aws cloudformation validate-template --template-body file://$i
       aws s3 cp $i s3://$template_bucket
    done
  fi
  aws cloudformation validate-template --template-body file://$local_template
  aws cloudformation update-stack \
  --stack-name $stack_name \
  --template-body file://$local_template \
  --parameters file://$param_file \
  --capabilities CAPABILITY_AUTO_EXPAND CAPABILITY_IAM
fi

#
# aws cloudformation validate-template --template-body file://sw2-cloudradius-vpc-stage.yml
# aws cloudformation validate-template --template-body file://sw2-cloudradius-sg.yml
#
# aws s3 cp  sw2-cloudradius-sg.yml s3://cf-sw2-template/sw2-cloudradius-sg.yml
#
# aws cloudformation update-stack --stack-name sw2-cloudradius-vpc \
# --template-body file://sw2-cloudradius-vpc-stage.yml \
# --parameters file://cloudradius_param_vpc.json \
# --capabilities CAPABILITY_AUTO_EXPAND
#
# aws cloudformation validate-template --template-body file://sw2-cloudradius-cloudwatch.yml
#
#
# aws cloudformation update-stack --stack-name sw2-cloudradius-cloudwatch \
# --template-body file://sw2-cloudradius-cloudwatch.yml \
# --capabilities CAPABILITY_IAM
