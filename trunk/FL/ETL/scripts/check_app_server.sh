#!/bin/bash -e
. ~/.bash_profile
PROGNAME=$(basename $0 .sh)
args=("$@")
#
# This script collects stats on the app server for performance issues
#
# Input - check_app_server.sh hostname or ip address 
# runtime is approximately 5  minutes.  
#
# Output - 2 logs
#	1) sarlog - binary log which can be ftp'ed and reviewed off line
#       2) network log - text ping, traceroute, df     
#
LOG_DIR=$MAXDAT_LOG_DIR

#Email related variables
RUN_DATE=$(date +%Y%m%d_%H%M%S)
EMAIL="MAXDatSystem@maximus.com" 

# If you pass a server name (or IP address) we will use it otherwise use the NYHIX
# database server.
if [ $# -eq 1 ] ; then
   DBSERVER=${args[0]}
else 
   DBSERVER=10.1.228.43
fi
#
# First collect network statistics.
#
echo "Start check_app_server.sh at $(date)" > $LOG_DIR/${PROGNAME}_network_${RUN_DATE}.log
echo -en  '\n' >>  $LOG_DIR/${PROGNAME}_network_${RUN_DATE}.log
/bin/ping -c 30 ${DBSERVER} >> $LOG_DIR/${PROGNAME}_network_${RUN_DATE}.log
echo -en '\n' >>  $LOG_DIR/${PROGNAME}_network_${RUN_DATE}.log

#
# If traceroute is installed run it to see if the routes are clear
#
if [ -x /bin/traceroute ] ; then
   /bin/traceroute ${DBSERVER} >> $LOG_DIR/${PROGNAME}_network_${RUN_DATE}.log
   echo -en '\n' >>  $LOG_DIR/${PROGNAME}_network_${RUN_DATE}.log
fi 
#
# Call sar to capture the app server kernal statistics if it is installed.
# Numbers below are timing in seconds then how many samples.
# call free for memory stats if sar is not there.
#
if [ -x /usr/bin/sar ] ; then
   /usr/bin/sar -A 10 30 -o $LOG_DIR/${PROGNAME}_sarlog_${RUN_DATE}.log >/dev/null 
else
   /usr/bin/free >>  $LOG_DIR/${PROGNAME}_network_${RUN_DATE}.log
   echo -en '\n' >>  $LOG_DIR/${PROGNAME}_network_${RUN_DATE}.log
fi
#
# Capture app server disk space.
#
echo -en '\n' >>  $LOG_DIR/${PROGNAME}_network_${RUN_DATE}.log
/bin/df -kl >>  $LOG_DIR/${PROGNAME}_network_${RUN_DATE}.log

echo -en '\n' >>  $LOG_DIR/${PROGNAME}_network_${RUN_DATE}.log
echo "Ending check_app_server.sh at $(date)" >> $LOG_DIR/${PROGNAME}_network_${RUN_DATE}.log
exit 0
