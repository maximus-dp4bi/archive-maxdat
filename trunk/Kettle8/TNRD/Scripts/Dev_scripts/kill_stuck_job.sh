#!/usr/bin/env bash
#set -x

# This script requires the run file (.sh) file name that is stuck
# as an input parameter
# The script will find the pid of the run file that was passed
# Then find the next three pids related to the job
# The script will then kill the pids in reverse order
# to properly kill the job

# Check for the job name from the script input
if [ $# -eq 0 ]
  then
    echo
    echo 'Run File (.sh) file name to kill not supplied'
    echo 'kill_stuck_job.sh <name of run file (.sh) to kill>'
    exit
  else
    echo
    echo "Killing pids for job: $1"
fi
#
# ====================== Functions =========================
#
# Define function pidget to load the four pids to kill into the pidnum array
pidget()
{
a=$1
# Loop until the value of $a reaches 2 then exit 
  while [[ $a -le 2 ]]
  do 
#     pgrep -P will find the pid number of the process that has a parent pid number matching the array value
      childpid=$(pgrep -oP ${pidnum[$a]})
      if [ "$?" != '0' ]
        then
           echo
           echo "Could not find child process of process: ${pidnum[$a]}"
           echo 'There should be four total processes to identify'
           a=$((a + 1))
           echo "Only $a processes found" 
           exit 1
      fi
      pidnum+=($childpid)
      ((a++))
  done
}

# Define function to kill pids determined by pidget in reverse order
pidkill()
{
a=$1
# Loop until the value of $a equals 0
  while [[ $a -ge 0 ]]
  do 
      if ! ps -p ${pidnum[$a]} > /dev/null
        then
           echo
           echo "Process ${pidnum[$a]} no longer exists, checking next process"
           ((a--))
           continue
      fi
      echo "Killing PID: ${pidnum[$a]}"
      kill -9 ${pidnum[$a]}
      if [ "$?" != '0' ]
        then
           echo
           echo "Kill command, 'kill -9 for ${pidnum[$a]}' failed! Exiting"
           exit 1
      fi
      if ps -p ${pidnum[$a]} > /dev/null
        then
           echo "PID ${pidnum[$a]} is still running. Exiting"
           exit 1
        else
           echo "PID ${pidnum[$a]} has been killed"
      fi
      ((a--))
  done
}

#
# ========================= Main Program =======================
#
# Create an indexed array
declare -a pidnum

# Check to see if job is running
if [ $(pgrep -fo $1) != "$$" ]
  then

#    Find the pid for the entered job name and add it to the pidnum array
     pidnum+=$( pgrep -of $1 )

     echo "Job PID: ${pidnum[@]}"

#    Get the PIDs for the rest of the processes
     pidget 0

     echo "PIDs found: ${pidnum[@]}"

#    Now kill the PIDs identified by pidget
     pidkill 3
 
else
     echo "Process for job $1 not running, please check entry"
     exit 1
fi

echo
echo "All processes for $1 killed successfully"
echo "Please verify that the check file associated with $1 was removed"
echo "If not, it must be removed before execution of $1 is attempted" 
exit 0

