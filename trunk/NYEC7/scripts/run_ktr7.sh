#!/bin/bash
#run_ktr.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL$
# $Revision$
# $Date$
# $Author$
PROGNAME=$(basename $0)
function pan_status()
{
panStatusDefs[1]='Errors occurred during processing'
panStatusDefs[2]='An unexpected error occurred during loading or running of the transformation'
panStatusDefs[3]='Unable to prepare and initialize this transformation'
panStatusDefs[7]="The transformation couldn't be loaded from XML or the Repository"
panStatusDefs[8]='Error loading steps or plugins (error in loading one of the plugins mostly)'
panStatusDefs[9]='Command line usage printing'
panStatusDefs[0]='success'
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

#-----  NY Specific  --------
#PATH=$KETTLE_NY_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
#export KETTLE_HOME=$KETTLE_NY_HOME
#----------------------------

KTR_FILENAME=$1
LOG_LEVEL=$2
LOG_NAME=`echo $1|awk -F"/" '{print substr($NF,1,length($NF)-4)}'`_$(date +%Y%m%d_%H%M%S)
LOG_FILE="${MAXDAT_ETL_LOGS}/${LOG_NAME}.log"
#ERRORS_FOUND="/tmp/${STCODE}_child_task_fail.txt"
ERRORS_FOUND=$CHILD_FAIL

echo $ERRORS_FOUND

echo "Running $KTR_FILENAME using ${PROGNAME}"
$MAXDAT_KETTLE_DIR/pan.sh -file="$KTR_FILENAME"  -level="$LOG_LEVEL"
kjbrc=$?
if [[ $kjbrc -ne 0 ]] ; then
        echo "$kjbrc ${1/\//}" >> $ERRORS_FOUND
        echo "$KTR_FILENAME failed with a result code: $kjbrc. Environment: $ENV_CODE, Server: $HOSTNAME" >> $EMAIL_MESSAGE
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
        error_exit "$LINENO: An error has occurred."
        exit $kjbrc

else
	echo "Finished running $KTR_FILENAME using run_kjb7.sh"

fi
exit 0
