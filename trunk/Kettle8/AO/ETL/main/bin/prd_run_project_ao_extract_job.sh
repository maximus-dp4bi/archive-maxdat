#!/bin/bash
#. ~/.bash_profile

location='/u01/maximus/maxdat-prd/AO8/ETL/main/bin'
source ${location}/.set_env


PROGNAME=$(basename $0 .sh)

kitchen_status()
{
#kitchen status codes
kitchenStatusDefs[1]="ERROR: Errors occurred during processing"
kitchenStatusDefs[2]="ERROR: An unexpected error occurred during loading or running of the job"
kitchenStatusDefs[7]="ERROR: The job couldn't be loaded from XML or the Repository"
kitchenStatusDefs[8]="ERROR: Error loading steps or plugins (error in loading one of the plugins mostly)"
kitchenStatusDefs[9]="ERROR: Command line usage printing"
kitchenStatusDefs[0]="STATUS: Success"
echo ${kitchenStatusDefs[$1]}
}

BASEDIR=$(dirname $0)
echo $BASEDIR

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=$AO_ETL_PATH/jobs
AO_INPUT_OUT_DIR=$AO_ROOT/files/Agentmap/Outbound
AO_EXTRACT_MATCH_DIR=$AO_ROOT/files/Agentmap/Inbound
AO_EXTRACT_OUT_DIR=$AO_ROOT/files/ACDExtract/Outbound
echo $AO_ETL_PATH
echo $JOBS_DIR

JOB="$4"
JOBTYPE="$5"

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

PROJECT="$1"
START_DATE="$2"
END_DATE="$3"
RUN_DATE=$(date +"%m/%d/%Y %H:%M:%S" --date='today')
LOG_DIR=$AO_ETL_LOGS
LOG_NAME=${JOB}_${PROJECT}_$(date +%Y%m%d_%H%M%S).log
LOG_LEVEL="Detailed"
echo $LOG_DIR
echo $PROJECT
echo $START_DATE
echo $END_DATE
ENV_CODE_U=$(echo $ENV_CODE | tr '[a-z]' '[A-Z]')

# email-related variables
EMAIL="18956@maximus.com 52647@maximus.com 51922@maximus.com"
EMAIL_MESSAGE="$AO_ETL_LOGS/{$PROJECT}_{$JOB}_LOG.log"

echo "PROJECT : ${PROJECT}" >> $EMAIL_MESSAGE
echo "START_DATE: ${START_DATE}" >> $EMAIL_MESSAGE
echo "END_DATE : ${END_DATE}" >> $EMAIL_MESSAGE
echo "JOB : $JOB" >> $EMAIL_MESSAGE
echo "DATE : $RUN_DATE" >> $EMAIL_MESSAGE
echo "LOG File: ${LOG_DIR}/${LOG_NAME}" >> $EMAIL_MESSAGE
echo "OUTPUT Dir: ${AO_EXTRACT_OUT_DIR} " >> $EMAIL_MESSAGE

echo "" >> $EMAIL_MESSAGE

ls -1 ${AO_EXTRACT_MATCH_DIR}/*${PROJECT}*Match* > /dev/null 2>&1
if [ "$?" = "0" ]; then
 echo "Match File exists"
 echo "Match File exists" >> $EMAIL_MESSAGE
else
 echo "Match File not exists"
 rm -f $EMAIL_MESSAGE
 exit 0
fi

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL" -param:PROJECT=$PROJECT -param:START_DATE=$START_DATE -param:END_DATE=$END_DATE >> "$LOG_DIR/$LOG_NAME"
rc=$?
if [[ $rc != 0 ]] ; then
	EMAIL_SUBJECT="$ENV_CODE_U - AO Agent $JOBTYPE $PROJECT Errors "

	kitchen_status $rc >> $EMAIL_MESSAGE
        echo "AO Agent $JOBTYPE Status Error, See log file for details." >> $EMAIL_MESSAGE
	mail -r "AO_Extract" -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        rm -f $EMAIL_MESSAGE
	exit $rc
else
	EMAIL_SUBJECT="$ENV_CODE_U - AO Agent $JOBTYPE $PROJECT Ran - $JOB"

	kitchen_status $rc >> $EMAIL_MESSAGE
        echo "AO Agent $JOBTYPE Job Ran, See log file for details and Check dir for output files." >> $EMAIL_MESSAGE
	mail -r "AO_Extract" -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        rm -f $EMAIL_MESSAGE
	exit
fi 
