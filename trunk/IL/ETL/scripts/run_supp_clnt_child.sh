#!/bin/bash
. ~/.bash_profile
#run_bpm.sh
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

#set up the environment
#PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_IL_HOME

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_PATH/IL/ETL/scripts
LOG_DIR=$MAXDAT_ETL_PATH/IL/ETL/logs
ERR_DIR=$MAXDAT_ETL_PATH/IL/ETL/errors
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

INIT_OK="$CUSTOM_DIR/il_run_init_check.txt"
CHILD_FAIL="/tmp/il_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/run_supp_clnt_child-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With run_supp_clnt_child.sh"

rm -f $EMAIL_MESSAGE $CHILD_FAIL

#init check
#assumption that bpm_init_check.kjb is present in $CUSTOM_DIR
$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/bpm_Init_check.kjb" -level="$DETAIL_LOG_LEVEL"  >> $LOG_DIR/il_bpm_init_check_$(date +%Y%m%d_%H%M%S).log
#creates il_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - IL bpm_Init_check.kjb, aborting Supp Clnt_Child run" >> $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
    #exit $rc
fi

if [[ $rc == 0 && -e $INIT_OK ]]
then
  $CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/SupportClientInquiry/ClientInquiry_Child_RUNALL.kjb >> $LOG_DIR/ClientInquiry_Child_RUNALL_$(date +%Y%m%d_%H%M%S).log
  if [[ $? -eq 0 ]]
     then 
        #success, move on
     			echo "ClientInquiry_Child_RUNALL.kjb  processes completed successfully."
     			rm -f $INIT_OK
			exit 0
  else
     		#mail something went wrong with the init
     		echo "ClientInquiry_Child_RUNALL.kjb failed in ILEB, review error log for additional detail." >> $EMAIL_MESSAGE
     		mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
     		cat $EMAIL_MESSAGE
     		rm -f $INIT_OK
     		#exit
     		error_exit "$LINENO: An error has occurred."
  fi 
# Sleep for 1 hour atn try again
fi
sleep 3600
#init check
#assumption that bpm_init_check.kjb is present in $CUSTOM_DIR
$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/bpm_Init_check.kjb" -level="$DETAIL_LOG_LEVEL"  >> $LOG_DIR/il_bpm_init_check_$(date +%Y%m%d_%H%M%S).log
#creates il_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - IL 2nd bpm_Init_check.kjb Failed, ClientInquiry_Child_RUNALL.kjb DID NOT RUN in ILEB." >> $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
       rm -f $INIT_OK
    exit $rc
fi

if [[ $rc == 0 && -e $INIT_OK ]]
  then
    $CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/SupportClientInquiry/ClientInquiry_Child_RUNALL.kjb >> $LOG_DIR/ClientInquiry_Child_RUNALL_$(date +%Y%m%d_%H%M%S).log
    if [[ $? -eq 0 ]]
       then 
          #success, move on
       			echo "ClientInquiry_Child_RUNALL.kjb  processes completed successfully."
       			rm -f $INIT_OK
  			exit 0
    else
       		#mail something went wrong with the init
       		echo "ClientInquiry_Child_RUNALL.kjb failed in ILEB, review error log for additional detail." >> $EMAIL_MESSAGE
       		mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
       		cat $EMAIL_MESSAGE
       		rm -f $INIT_OK
       		#exit
       		error_exit "$LINENO: An error has occurred."
    fi 
else
     #mail here, it didn't work, no connectivity
     echo "ClientInquiry_Child_RUNALL.kjb DID NOT RUN in ILEB, Failed after second attempt to start." >> $EMAIL_MESSAGE
     mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
    cat $EMAIL_MESSAGE
     rm -f $INIT_OK
    error_exit "$LINENO: An error has occurred in ILEB - run_supp_clnt_child.sh"
fi

#pan status codes
# 0 	The transformation ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading / running of the transformation
# 3 	Unable to prepare and initialize this transformation
# 7 	The transformation couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing

#kitchen status codes
# 0 	The job ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading or running of the job
# 7 	The job couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing
