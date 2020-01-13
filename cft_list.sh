#!/bin/bash
aws cloudformation list-stacks |  jq '.StackSummaries[] | "\(.StackName),\(.StackStatus),\(.LastUpdatedTime)"' | grep -v "DELETE_COMPLETE" | sed 's/\"//g'|column -t -s, -n "$@"  | sort
