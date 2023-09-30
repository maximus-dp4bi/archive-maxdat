#!/usr/bin/env bash
set -x
# This script create 4 processes to test pidkill
# To break out of the scrip
# Press CTRL+C to stop
a=$1
if [[ $a -lt 6 ]]
then
  echo "Starting process $a with PID $$"
  a=$((a+1))
  $0 $a
fi
if [[ $a -eq 6 ]]; then
  read -n1 -rsp "Press space to continue...\n" key
  if [[ $key = '' ]]
    then
      exit
  fi
fi
