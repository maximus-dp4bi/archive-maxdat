#!/bin/bash
#run_ktr.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/NYHIX/ETL/scripts/run_ktr.sh $
# $Revision: 5274 $
# $Date: 2013-09-11 12:36:31 -0400 (Wed, 11 Sep 2013) $
# $Author: dd27179 $
PROGNAME=$(basename $0)

location='/u01/maximus/maxdat/NYHIX8/config'
source ${location}/.set_env

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

LOG_LEVEL=$2
ERRORS_FOUND="/tmp/${STCODE}_child_task_fail.txt"
echo "ERRORS FOUND = $ERRORS_FOUND"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${1/\//}-$STCODE-ERROR-LOG.txt"
EMAIL_SUBJECT="${STCODE}-Errors With ${1/\//} in $ENV_CODE"

LOG_NAME=`echo $1|awk -F"/" '{print substr($NF,1,length($NF)-4)}'`_$(date +%Y%m%d_%H%M%S)
LOG_FILE="${MAXDAT_ETL_LOGS}/${LOG_NAME}.log"

#if the message already exists from a prior run, delete it
rm -f $EMAIL_MESSAGE

# Check for any arguments  
# first arg is the Kettle Transformation file name
if [[ $# -ne 2 ]]
then
	echo 'Usage: run_ktr.sh <path><filename> <logging level>'
	echo 'Example: run_ktr.sh ManageWork/Run_ManageWork.kjb Detailed'
	exit  1
else
	$MAXDAT_KETTLE_DIR/pan.sh -file="$1"  -level="$LOG_LEVEL" 
	ktrrc=$?
	if [[ $ktrrc != 0 ]]
	then #failure
		echo "$ktrrc ${1/\//}" >> $ERRORS_FOUND
		echo "${STCODE}-ERROR IN $1, See $LOG_FILE for details." >> $EMAIL_MESSAGE
		pan_status $ktrrc >> $EMAIL_MESSAGE
		mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
		cat $EMAIL_MESSAGE
		error_exit "$LINENO: An error has occurred in ${STCODE}. run_ktr.sh"
	else
	#success
		echo "$(date +%Y%m%d_%H%M%S) $1 ${STCODE} Completed Successfully"
		pan_status $ktrrc
	fi 
fi
exit 0
