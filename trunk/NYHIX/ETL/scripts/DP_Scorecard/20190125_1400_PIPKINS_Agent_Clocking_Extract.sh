#!/bin/ksh
#PIPKINS_Agent_Clocking_Extract.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$

. ~/.bash_profile

PROGNAME=$(basename $0 .sh)

#export KETTLE_HOME=$KETTLE_NYHIX_HOME

if [[ -e $KETTLE_NYHIX_HOME ]] ; then
   echo "Kettle Home is: $KETTLE_NYHIX_HOME"
   export KETTLE_HOME=$KETTLE_NYHIX_HOME
else
   echo "KETTLE_NYHIX_HOME Does not exist"	
fi

#export KETTLE_HOME=$KETTLE_NYHIX_HOME

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
KJB_LOG_ROWLEVEL="Rowlevel"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_PIPKINS_Agent_Clocking_Extract-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_PIPKINS_Agent_Clocking_Extract.sh in $ENV_CODE"


#checking for run file, Abort if it exists, create if it does not exists

RUN_CHECK="$MAXDAT_ETL_PATH/${STCODE}_Pipkins_Agent_Clocking_Extract_check.txt"
echo $RUN_CHECK

if [[ -e $RUN_CHECK ]] ; then
      echo "PIPKINS_Agent_Clocking_Extract - Run Aborted - $RUN_CHECK exists"
      echo "exited with status: $rc - RUN_CHECK failed for PIPKINS_Agent_Clocking_Extract.sh, aborting run in $STCODE" >> $EMAIL_MESSAGE
      mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
      cat $EMAIL_MESSAGE
      exit;
else
   echo "Starting ${STCODE}_PIPKINS_Agent_Clocking_Extract.sh in ${ENV_CODE}."
   #Remove the EMAIL_MESSAGE
   rm -f $EMAIL_MESSAGE 
   touch $RUN_CHECK
fi

#create the log file name

PIPKINS_Agent_Clocking_Extract_LOG="$MAXDAT_ETL_LOGS/PIPKINS_Agent_Clocking_Extract_$(date +%Y%m%d_%H%M%S).log"
echo $PIPKINS_Agent_Clocking_Extract_LOG
 
#check Data Base Connections

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/dp_scorecard_Init_check.kjb" -level="$KJB_LOG_LEVEL"  > $PIPKINS_Agent_Clocking_Extract_LOG
rc=$?
wait
if [[ $rc != 0 ]] ; then
        echo "exited with status: $rc - INIT_CHECK failed for PIPKINS_Agent_Clocking_Extract.sh, aborting run in $STCODE" >> $EMAIL_MESSAGE
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
        # if the failure was due to a dtabase connection remove the RUN_CHECK file
        # so the next scheduled job can try to connect
	rm -f $RUN_CHECK
        exit $rc
else
        #connections are good
        echo "PIPKINS_Agent_Clocking_Extract Database Connection are good"
fi

echo "Starting ${STCODE}_PIPKINS_Agent_Clocking_Extract.sh in ${ENV_CODE}."
touch $RUN_CHECK

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/DP_Scorecard/Pipkins_Agent_Clocking_Extract.kjb" -level="Detailed"  >> $PIPKINS_Agent_Clocking_Extract_LOG
rc=$?
wait
if [[ $rc != 0 ]] ; then
        echo "exited with status: $rc - Pipkins_Agent_Clocking_Extract.kjb, aborting run in $STCODE" >> $EMAIL_MESSAGE
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
        exit $rc
else
        #job ran successfully - remove check file
	echo "PIPKINS_Agent_Clocking_Extract ran successfully - removing check file"
        rm $RUN_CHECK
fi
