#!/bin/bash

#set up config variables
HOME_DIR="/home/centos/PI_DATA_INGESTION"
source ${HOME_DIR}/config/pi_data_ingestion_config
EMAIL_SUBJECT_FAIL="Failed to Check Completion for Eastern TZ Projects"
DB=$1

if [ $DB = "PUREINSIGHTS_DEV"  ]
then
     EMAIL_DESTINATION=$EMAIL_DESTINATION_DEV
elif [ $DB = "PUREINSIGHTS_UAT"  ]
then
     EMAIL_DESTINATION=$EMAIL_DESTINATION_UAT
elif [ $DB = "PUREINSIGHTS_PRD" ]
then
     EMAIL_DESTINATION=$EMAIL_DESTINATION_PRD
else
     EMAIL_DESTINATION=$EMAIL_DESTINATION_DEF
fi


rc=0
bash ${SCRIPT_DIR}/check_completion_on_time.sh "$DB" > ${LOG_DIR}/${DB}_check_completion_wrapper_${DB}_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [ "$rc" != 0 ]
then
        mail -s "$EMAIL_SUBJECT_FAIL" -r "$EMAIL_FROM" "$EMAIL_DESTINATION" <  $EMAIL_MESSAGE_FAIL_CHECK
fi
