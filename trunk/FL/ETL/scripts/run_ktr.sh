#!/bin/bash
#run_ktr.sh
PROGNAME=$(basename $0)
function pan_status()
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

#PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
PATH=$KETTLE_FL_HOME/.kettle/kettle.properties:.:/home/pentaho/design-tools/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_FL_HOME

export PENTAHO_JAVA_HOME="/opt/tools/jdk1.7.0/jre/"
export SCRIPTS_DIR="/home/pentaho/design-tools/data-integration"
export CUSTOM_DIR=$KETTLE_FL_HOME/maxbi-dev/ETL/scripts
export LOG_DIR=$KETTLE_FL_HOME/logs

#CUSTOM_DIR="/u01/maximus/maxdat-prd/ETL/scripts"
#LOG_DIR="/u01/maximus/maxdat-prd/ETL/logs"
#CUSTOM_DIR="/u01/maximus/maxbi-uat/ETL/scripts"
#LOG_DIR="/u01/maximus/maxbi-uat/ETL/logs"
#CUSTOM_DIR="/u01/maximus/maxbi-dev/ETL/scripts"
#LOG_DIR="/u01/maximus/maxbi-dev/ETL/logs"
export LOG_LEVEL="Basic"
export ERRORS_FOUND="/tmp/$(date +%Y%m%d_%H%M%S)_${1/\//}.txt"

#mail related variables
EMAIL="phsmith@Policy-Studies.com, nvirdi@Policy-Studies.com"
EMAIL_MESSAGE="/tmp/${1/\//}-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${1/\//}"

#if the message already exists from a prior run, delete it
rm -f $EMAIL_MESSAGE

# Check for any arguments  
# first arg is the Kettle Transformation file name
if [[ $# -ne 1 ]]
then
	echo "Usage: run_ktr.sh <path><filename>"
	echo "Example: run_ktr.sh ManageWork/Run_ManageWork.ktr"
	exit  1
else
LOG_FILE="$LOG_DIR/$(date +%Y%m%d_%H%M%S)_${1/\//}.log"
	$SCRIPTS_DIR/pan.sh -file="$1"  -level="$LOG_LEVEL" 
        #$SCRIPTS_DIR/pan.sh -file="$1" -log="$LOG_FILE" -level="$LOG_LEVEL" 
		ktrrc=$?
		if [[ $ktrrc != 0 ]]
		then #failure
			echo "$ktrrc ${1/\//}" >> $ERRORS_FOUND
			echo "ERROR IN $1, See $LOG_FILE for details." >> $EMAIL_MESSAGE
			pan_status $ktrrc >> $EMAIL_MESSAGE
			mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
			cat $EMAIL_MESSAGE
			error_exit "$LINENO: An error has occurred. run_ktr.sh"
		else
		#success
			echo "$(date +%Y%m%d_%H%M%S) $1 Completed Successfully"
			pan_status $ktrrc
		fi 
fi
exit 0
