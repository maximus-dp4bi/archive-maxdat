#!/bin/bash

#set up config variables
HOME_DIR="/home/centos/PI_DATA_INGESTION"
source ${HOME_DIR}/config/pi_data_ingestion_config
EMAIL_SUBJECT_FAIL="PI Data Ingestion Errors"
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

#EMAIL_DESTINATION=$EMAIL_DESTINATION_DEF

rc=0
bash ${SCRIPT_DIR}/ingest_PI_data_V2.sh "$DB" "true" "true" "2022/01/25 00:00:00" "2080/12/31 00:00:00" "1" "ALL" > ${LOG_DIR}/${DB}_ingest_pi_data_wrapper_${DB}_$(date +%Y%m%d_%H%M%S).log
#bash ${SCRIPT_DIR}/ingest_PI_data.sh "$DB" "false" "false" > ${LOG_DIR}/${DB}_ingest_pi_data_wrapper_${DB}_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [ "$rc" != 0 ] 
then
        mail -s "$EMAIL_SUBJECT_FAIL" -r "$EMAIL_FROM" "$EMAIL_DESTINATION" <  $EMAIL_MESSAGE_FAIL
fi
    

