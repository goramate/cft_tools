#!/bin/bash
set -x
mkdir -p .manifests
if [[ $# -gt 0 ]]; then
  echo "stack_name=$1" > .manifests/$1.stack
  echo "local_template=$1.yaml" >>  .manifests/$1.stack
  echo "param_file=.manifests/$1.param" >>  .manifests/$1.stack
fi
