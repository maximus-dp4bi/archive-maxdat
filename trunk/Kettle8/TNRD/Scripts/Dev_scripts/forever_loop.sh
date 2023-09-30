#!/usr/bin/env bash
# This script will loop forever
# To break out of the scrip
# Press CTRL+C to stop

i=0
for (( ; ; ))
do
  echo -en "\r Press CTRL+C to stop... Runtime: $i seconds"
  ((i+=1))
  sleep 1
done
 
