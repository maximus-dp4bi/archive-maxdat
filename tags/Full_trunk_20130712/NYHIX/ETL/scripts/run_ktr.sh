#!/bin/bash
#run_ktr.sh
PROGNAME=$(basename $0)
pan_status()
{
panStatusDefs[1]="Errors occurred during processing"
panStatusDefs[2]="An unexpected error occurred during loading or running of the transformation"
panStatusDefs[3]="Unable to prepare and initialize this transformation"
panStatusDefs[7]="The transformation couldn't be loaded from XML or the Repository"
panStatusDefs[8]="Error loading steps or plugins (error in loading one of the plugins mostly)"
panStatusDefs[9]="Command line usage printing"
panStatusDefs[0]="success"
echo ${panStatusDefs[$1]}
}

function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------

	echo "see: $LOG_FILE for details."
	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

#PATH=/u01/maximus/maxdat-dev/IL/config/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
#export KETTLE_HOME=/u01/maximus/maxdat-dev/IL/config
PATH=/u25/app/product/kettle/4.2/data-integration/.kettle/kettle.properties:.:/u25/app/product/kettle/4.2/data-integration/:$PATH
export PATH


export PENTAHO_JAVA_HOME="/u25/app/product/java/j6sdk"
SCRIPTS_DIR="/u25/app/product/kettle/4.2/data-integration"

#CUSTOM_DIR=$MAXDAT_ETL_PATH/IL/ETL/scripts
#LOG_DIR=$MAXDAT_ETL_PATH/IL/ETL/logs
#ERR_DIR=$MAXDAT_ETL_PATH/IL/ETL/errors
CUSTOM_DIR=$MAXDAT_ETL_PATH
LOG_DIR=/u25/ETL_Logs/DEV
ERR_DIR=/u25/ETL_Logs/DEV/errors
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

ERRORS_FOUND="/tmp/tx_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/$2_TX-ERROR-LOG.txt"
EMAIL_SUBJECT="TX-Errors With $2"

#if the message already exists from a prior run, delete it
rm -f $EMAIL_MESSAGE

# Check for any arguments  
# first arg is the Kettle Transformation file name
if [[ $# -ne 1 ]]
then
	echo "Usage: run_ktr.sh <path><filename> <JobName>"
	echo "Example: run_ktr.sh ManageWork/Run_ManageWork.ktr Run_ManageWork"
	exit  1
else
#LOG_FILE="$LOG_DIR/$(date +%Y%m%d_%H%M%S)_${1/\//}.log"
	ksh $SCRIPTS_DIR/pan.sh -file="$1"  -level="$LOG_LEVEL" 
        # $SCRIPTS_DIR/pan.sh -file="$1" -log="$LOG_FILE" -level="$BASIC_LOG_LEVEL" 
		ktrrc=$?
		if [[ $ktrrc != 0 ]]
		then #failure
			echo "$ktrrc $2" >> $ERRORS_FOUND
			echo "TX-ERROR IN $1, See $LOG_FILE for details." >> $EMAIL_MESSAGE
			pan_status $ktrrc >> $EMAIL_MESSAGE
			mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
			cat $EMAIL_MESSAGE
			error_exit "$LINENO: An error has occurred in TX. run_ktr.sh"
		else
		#success
			echo "$(date +%Y%m%d_%H%M%S) $1 TX Completed Successfully"
			pan_status $ktrrc
		fi 
fi
exit 0
