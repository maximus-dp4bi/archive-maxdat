#!/bin/bash
# emrs_run_ktr.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/IL/ETL/scripts/run_emrs_ktr.sh $
# $Revision: 3852 $
# $Date: 2013-07-16 00:18:58 -0600 (Tue, 16 Jul 2013) $
# $Author: dh24064 $
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
#set up the environment
PATH=$KETTLE_FL_HOME/.kettle/kettle.properties:.:/home/pentaho/design-tools/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_FL_HOME

export PENTAHO_JAVA_HOME="/opt/tools/jdk1.7.0/jre/"
KETTLEDIR="/home/pentaho/designkdata-integration"
STCODE=IL
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

ERRORS_FOUND="/tmp/$STCODE_child_task_fail.txt"

#mail related variables
EMAIL="phsmith@Policy-Studies.com"
EMAIL_MESSAGE="/tmp/$2_$STCODE-ERROR-LOG.txt"
EMAIL_SUBJECT="$STCODE-Errors With $2"

#if the message already exists from a prior run, delete it
rm -f $EMAIL_MESSAGE

# Check for any arguments  
# first arg is the Kettle Transformation file name
if [[ $# -ne 2 ]]
then
	echo "Usage: erms_run_ktr.sh <path><filename> <JobName>"
	echo "Example: erms_run_ktr.sh ManageWork/Run_ManageWork.ktr Run_ManageWork"
	exit  1
else
#LOG_FILE="$LOG_DIR/$(date +%Y%m%d_%H%M%S)_${1/\//}.log"
	ksh $KETTLEDIR/pan.sh -file="$1"  -level="$LOG_LEVEL" 
        ktrrc=$?
		if [[ $ktrrc != 0 ]]
		then #failure
			echo "$ktrrc $2" >> $ERRORS_FOUND
			echo "$STCODE-ERROR IN $1, See $LOG_FILE for details." >> $EMAIL_MESSAGE
			pan_status $ktrrc >> $EMAIL_MESSAGE
			mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
			cat $EMAIL_MESSAGE
			error_exit "$LINENO: An error has occurred in $STCODE. erms_run_ktr.sh"
		else
		#success
			echo "$(date +%Y%m%d_%H%M%S) $1 $STCODE Completed Successfully"
			pan_status $ktrrc
		fi 
fi
exit 0
