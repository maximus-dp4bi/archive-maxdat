#!/bin/bash

#set up config variables
HOME_DIR="/home/centos/PI_DATA_INGESTION"
source ${HOME_DIR}/config/pi_data_ingestion_config
DB=$1
INGEST_C="ingest_${DB}"
INGESTION_LOG="${MESSAGES_DIR}/check_completion_log_${DB}.txt"
EMAIL_SUBJECT_FAIL="${DB}: PI Data Ingestion Not Completed on Time for Some Projects"
EMAIL_FINAL="${MESSAGES_DIR}/email_final_check_completion_${DB}.txt"

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

##modify to merge project logs into a temp coalesced log and then check this for ingestion completed or ingestion completed reingest
## Truncate temp table
${SNOW_DIR}/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o header=false -o timing=false -o output_format=plain -q "truncate table ${DB}.RAW.INGEST_PI_DATA_DET_LOG_TEMP;"

##merge project log table data into main log table
${SNOW_DIR}/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o header=false -o timing=false -o output_format=tsv -q "call raw.MergeProjectLogsForIngestion(false,'INGEST_PI_DATA_DET_LOG_TEMP');"

#test that there is a success completion status in the ingestion log for every configured project and prepare message if not

missing_project_ingestion=0
missing_project_ingestion=$(${SNOW_DIR}/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o header=false -o timing=false -o output_format=plain -q "select count(*)
from ${DB}.public.d_pi_projects pr
where pr.active = true
and not exists (select 1 from ${DB}.raw.ingest_pi_data_det_log_temp dl
                where dl.projectid = pr.projectid and upper(dl.object_category) in ('INGESTION COMPLETED','INGESTION COMPLETED REINGEST') and upper(dl.status_string) = 'SUCCEEDED'
                and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp())
               );")
echo "count of missing success indicator for projects is ${missing_project_ingestion}"

if [ "$missing_project_ingestion" != 0 ]
then
echo -e "\nPI data ingestion for the following projects has not completed by the assigned deadline: \n" > $INGESTION_LOG

${SNOW_DIR}/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o timing=false -o header=false -o output_format=tsv -q "select pr.projectid, pr.projectname
from ${DB}.public.d_pi_projects pr
where pr.active = true
and not exists (select 1 from ${DB}.raw.ingest_pi_data_det_log_temp dl
                where dl.projectid = pr.projectid and upper(dl.object_category) in ('INGESTION COMPLETED','INGESTION COMPLETED REINGEST') and upper(dl.status_string) = 'SUCCEEDED'
                and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp())
               )
 order by pr.projectid desc; " >> $INGESTION_LOG

fi


#check for alert conditions and prepare and send email

if [ "$missing_project_ingestion" != 0 ]
then

        cat $INGESTION_LOG  > $EMAIL_FINAL
        mail -s "$EMAIL_SUBJECT_FAIL" -r "$EMAIL_FROM" "$EMAIL_DESTINATION" <  $EMAIL_FINAL
        cat $EMAIL_FINAL

fi

