#!/bin/bash
#corp_run_ktr.sh
# ==========================================================================
# Do not edit these four SVN_* variable values.  They are populated when
#    you commit code to SVN and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/run_ktr.sh $
# $Revision: 10349 $
# $Date: 2014-06-02 16:29:15 -0700 (Mon, 02 Jun 2014) $
# $Author: dd27179 $
# =========================================================================
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
#
#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------
function error_exit
{
	echo "see: $LOG_FILE for details."
	echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
	exit 1
}

LOG_LEVEL=$2
ERRORS_FOUND="/tmp/${STCODE}_child_task_fail.txt"
echo "ERRORS FOUND = ${ERRORS_FOUND}"

#mail related variables
EMAIL_MESSAGE="/tmp/${1/\//}-${STCODE}-ERROR-LOG.txt"
EMAIL_SUBJECT="${STCODE}-Errors With ${1/\//} in ${ENV_CODE}"


#if the message already exists from a prior run, delete it
rm -f ${EMAIL_MESSAGE}

# Check for correct number of arguments  
if [[ $# -ne 2 ]]
then
	echo 'Usage: run_ktr.sh <path><filename> <logging level>'
	echo 'Example: run_ktr.sh ManageWork/Run_ManageWork.kjb Detailed'
	exit  1
else
	${MAXDAT_KETTLE_DIR}/pan.sh -file="$1"  -level="${LOG_LEVEL}" 
	ktrrc=$?
	if [[ ${ktrrc} != 0 ]]
	then #failure
		echo "${ktrrc} ${1/\//}" >> ${ERRORS_FOUND}
		echo "${STCODE}-ERROR IN $1, See ${LOG_FILE} for details." >> ${EMAIL_MESSAGE}
		pan_status ${ktrrc} >> ${EMAIL_MESSAGE}
		mail -s "${EMAIL_SUBJECT}" "${EMAIL}" < ${EMAIL_MESSAGE}
		cat ${EMAIL_MESSAGE}
		error_exit "${LINENO}: An error has occurred in ${STCODE}. run_ktr.sh"
	else
	#success
		echo "$(date +%Y%m%d_%H%M%S) $1 ${STCODE} Completed Successfully"
		pan_status ${ktrrc}
	fi 
fi
exit 0