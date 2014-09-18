#!/bin/ksh
. ~/.profile
#run_bpm.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
        rm -f $INIT_OK
	exit 1
}

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/tx_run_slatask-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With run_upd_sla_task_group.sh"

rm -f $EMAIL_MESSAGE 

#init check
ksh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/tx_bpm_init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - TX bpm_Init_check.kjb, aborting SLA Task run" >> $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
     exit $rc
else
   ksh $MAXDAT_KETTLE_DIR/pan.sh -file="$MAXDAT_ETL_PATH/UPD_SLA_Task_Groups_v2.ktr" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/${STCODE}_UPD_SLA_Task_Groups_$(date +%Y%m%d_%H%M%S).log
   #$MAXDAT_ETL_PATH/run_ktr.sh $MAXDAT_ETL_PATH/UPD_SLA_Task_Groups_v2.ktr $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/UPD_SLA_Task_Groups_v2_$(date +%Y%m%d_%H%M%S).log
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
