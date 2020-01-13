#!/bin/bash
if [[ $# -gt 0 ]]
then
   source $1.stack
   ./cft_templ.sh $1  > /tmp/test
   diff /tmp/test $local_template
fi
