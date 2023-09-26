#!/bin/bash
# Do_GENESYS_Pull_M.sh
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
	rm -f $INIT_OK_PULL_M
	exit 1
}
#
function get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     # While $SOURCE is a symlink, resolve it
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          # If $SOURCE was a relative symlink (so no "/" as prefix, need to resolve it relative to the symlink base directory
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
     echo "$DIR"
}
#
SCRIPTDIR="$(get_script_dir)"
. $SCRIPTDIR/.set_env
#
# Echo Environment Variables
echo "STCODE=$STCODE"
echo "MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH"
echo "MAXDAT_ETL_LOGS=$MAXDAT_ETL_LOGS"
echo "MAXDAT_DATA_FILES=$MAXDAT_DATA_FILES" 
echo "ENV_CODE=$ENV_CODE"
#
#
#export KETTLE_HOME=$KETTLE_NYHIX_HOME
#
KTR_LOG_LEVEL="Rowlevel"
KJB_LOG_LEVEL="Detailed"
KJB_LOG_ROWLEVEL="Rowlevel"
#INIT_OK_PULL_M="$MAXDAT_ETL_PATH/${STCODE}_run_check.txt"
#CHILD_FAIL="/tmp/${STCODE}_child_task_fail.txt"
#
#mail related variables
EMAIL="ericburke@maximus.com JeromeHampson@maximus.com RamalakshmiSundar@maximus.com CorneliusAJackson@maximus.com"
EMAIL_PULL="ericburke@maximus.com JeromeHampson@maximus.com RamalakshmiSundar@maximus.com CorneliusAJackson@maximus.com"
#EMAIL="MAXDatSystem@maximus.com"
#EMAIL_MESSAGE="Errors"
EMAIL_MESSAGE="/tmp/${STCODE}_Do_GENESYS_Pull_M-ERROR-LOG.txt"
EMAIL_PULL_MESSAGE="$MAXDAT_DATA_FILES/messages/GC_Links_Message_file_M.txt"
EMAIL_SUBJECT="Errors With Do_GENESYS_Pull_M.sh in $ENV_CODE"
EMAIL_PULL_SUBJECT="MONTHLY GENESYS CLOUD DOWNLOAD LINKS";

rm -f $EMAIL_PULL_MESSAGE

#
#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $INIT_OK_PULL_M ]] ; then
   echo "Run Aborted - $INIT_OK_PULL_M exists"
   exit;
else
   echo "Starting Do_GENESYS_Pull_M.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE 
   touch $INIT_OK_PULL_M
fi
#

# if no files to process, do not call kettle script 
#if ! ["$(ls /u01/maximus/maxdat-dev/VT_GENESYS/data_extracts/*.csv)"]
#then
#echo "No files to process"
#rm -f $INIT_OK_PULL_M
#exit 0
#fi
#init check
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - init_check.kjb, aborting run in $STCODE" >> $EMAIL_MESSAGE
	rm -f $INIT_OK_PULL_M
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	exit $rc
else
   rm -f $EMAIL_PULL_MESSAGE	
   ($MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/GENESYS_Pull/GC_Pull_Main_M.kjb" -param:media_type_param=voice -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/GC_Pull_Main_M_$(date +%Y%m%d_%H%M%S).log) && 

   ($MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/GENESYS_Pull/GC_Pull_Main_M.kjb" -param:media_type_param=chat -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/GC_Pull_Main_M_$(date +%Y%m%d_%H%M%S).log)

   if [[ $? -eq 0 ]]
   then
	#success, move on
	mail -s "$EMAIL_PULL_SUBJECT" "$EMAIL_PULL" < $EMAIL_PULL_MESSAGE
	#cat $EMAIL_MESSAGE_PULL	
	#rm -f $EMAIL_PULL_MESSAGE
	echo "$STCODE - processes completed successfully."
	rm -f $INIT_OK_PULL_M
	exit 0
		
   else
		#mail something went wrong
 		echo "GC_Pull_Main_M.kjb failed in ${STCODE}, review error log for additional detail." >> $EMAIL_MESSAGE
		rm -f $INIT_OK_PULL_M
		#rm -f $EMAIL_PULL_MESSAGE
		mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
		cat $EMAIL_MESSAGE
        	error_exit "$LINENO: $STCODE - An  error has occurred."
   fi 
fi
#
#pan status codes
# 0 	The transformation ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading / running of the transformation
# 3 	Unable to prepare and initialize this transformation
# 7 	The transformation couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing
#
#kitchen status codes
# 0 	The job ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading or running of the job
# 7 	The job couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing
