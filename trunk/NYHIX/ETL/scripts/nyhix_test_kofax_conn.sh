#!/bin/ksh
. ~/.bash_profile
#nyhix_test_kofax_conn.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
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


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

export KETTLE_HOME=$KETTLE_NYHIX_HOME

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"

	#ensure the directory structure matches and the desired kjb/ktr files are specified
	$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MailFaxBatch/MailFaxBatch_Check_DB_Connections_Remote.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/MailFaxBatch_Check_DB_Connections_Remote_$(date +%Y%m%d_%H%M%S).log &
	$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MailFaxBatch/MailFaxBatch_Check_DB_Connections_Central.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/MailFaxBatch_Check_DB_Connections_Central_$(date +%Y%m%d_%H%M%S).log &
	$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MailFaxBatch/MailFaxBatch_Check_DB_Connections_Remote.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/MailFaxBatch_Check_DB_Connections_ARS_$(date +%Y%m%d_%H%M%S).log &
	$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MailFaxDoc/chk_dms_connect.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/chk_dms_connect_$(date +%Y%m%d_%H%M%S).log &

	  wait
		if [[ -e $CHILD_FAIL ]]
		then
			#a child process failed, abort mission
			echo "test_kofax_conn - One or more subtasks failed.  Check error logs for more details."
			#exit
			error_exit "$LINENO: test_kofax_conn - A Connection error has occurred."
		else
			#success, move on
			echo "test_kofax_conn -  processes completed successfully."
			exit 0
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
