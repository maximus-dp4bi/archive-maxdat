#!/bin/bash

#set up config variables 
HOME_DIR="/home/centos/PI_DATA_INGESTION"
source ${HOME_DIR}/config/pi_data_ingestion_config
DB=$1
REINGEST_FLAG=$2
INGEST_C="ingest_${DB}"
INGESTION_LOG="${MESSAGES_DIR}/ingestion_log_${DB}.txt"
INGESTION_LOG_SUCCESS="${MESSAGES_DIR}/ingestion_log_success_${DB}.txt"
EMAIL_SUBJECT_FAIL="${DB}: PI Data Ingestion Errors"
EMAIL_SUBJECT_SUCCESS="${DB}: PI Data Ingestion Successful"
EMAIL_FINAL="${MESSAGES_DIR}/email_final_${DB}.txt"

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



echo "INGESTION DB: ${DB}" > $INGESTION_LOG

#get projects currently configured as active for this timezone and kick off ingestion scripts

project_array=()
configured_project_count=0
project_array=($(/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o header=false -o timing=false -o output_format=tsv -q "select projectid from ${DB}.public.d_pi_projects where active=true;")) 
project_array=$(echo "$project_array" |tr '\n' ' ' )
configured_project_count=${#project_array[@]}

echo "config project count is ${configured_project_count}"


pid_list=""
for PROJECTID in ${project_array[@]}
do
echo "creating ingestion process for ${PROJECTID}"

/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o header=false -o timing=false -o output_format=plain -q " call ${DB}.raw.ingestUningestedPIData(${PROJECTID},${REINGEST_FLAG},false,true);"&
pid_list+=" $!"
done


#wait for scripts to finish, check return codes, and increment failed and succeeded return code counters

rc=0;
failed_rc_count=0
succeeded_rc_count=0
for p in $pid_list; do
    wait $p
    rc=$?
    if [ "$rc" != 0 ]; then
       failed_rc_count=$(($failed_rc_count+1))
    else
      succeeded_rc_count=$(($succeeded_rc_count+1)) 
    fi
    echo "return code for process $p is $rc "
done

echo "done ingesting: ${failed_rc_count} processes failed to complete"

#populate session contact summary table
session_contact_summary_sp_rc=0
/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o header=false -o timing=false -o output_format=plain -q " call ${DB}.stage.S_PI_SESSION_CONTACT_SUMMARY_LOAD();"
session_contact_summary_sp_rc=$?

echo "session contact summary return is $session_contact_summary_sp_rc "

if [ "$session_contact_summary_sp_rc" != 0 ]
then
echo -e "Session contact summary population failed to complete. Please check the log for details. \n" >> $INGESTION_LOG
fi


# if failed processes, prepare failed ingestion scripts message

if [ $failed_rc_count != 0 ] || [ $succeeded_rc_count != $configured_project_count ]
then 
echo -e "${failed_rc_count} PI data ingestion processes failed to complete. Please check the log for details. \n" >> $INGESTION_LOG
fi


#populate groups membership history table
groups_membership_history_sp_rc=2
/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o header=false -o timing=false -o output_format=plain -q " call ${DB}.stage.update_groups_membership_daily_snapshot('ALL',${REINGEST_FLAG});"
groups_membership_history_sp_rc=$?

echo "groups_membership daily snapshot return is $groups_membership_history_sp_rc "

if [ "$groups_membership_history_sp_rc" != 0 ]
then
echo -e "Groups membership daily snapshot population failed to complete. Please check the log for details. \n" >> $INGESTION_LOG
fi


#test that there is a success completion status in the ingestion log for every configured project and prepare message if not

missing_project_ingestion=0
missing_project_ingestion=$(/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o header=false -o timing=false -o output_format=plain -q "select count(*)
from ${DB}.public.d_pi_projects pr
where pr.active = true 
and not exists (select 1 from ${DB}.raw.ingest_pi_data_det_log dl
                where dl.projectid = pr.projectid and upper(dl.object_category)='INGESTION COMPLETED' and upper(dl.status_string) = 'SUCCEEDED'
                and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp())
               );")
echo "count of missing success indicator for projects is ${missing_project_ingestion}"

if [ "$missing_project_ingestion" != 0 ]
then
echo -e "\nThe following projects do not have a success indicator in the PI data ingestion log: \n" >> $INGESTION_LOG

/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o timing=false -o header=false -o output_format=tsv -q "select rpad(pr.projectid,10,' '),pr.projectname
from ${DB}.public.d_pi_projects pr
where pr.active = true
and not exists (select 1 from ${DB}.raw.ingest_pi_data_det_log dl
                where dl.projectid = pr.projectid and upper(dl.object_category)='INGESTION COMPLETED' and upper(dl.status_string) = 'SUCCEEDED'
                and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp())
               )
 order by pr.projectname; " >> $INGESTION_LOG

fi


#test that there is a success status in the ingestion log for every configured table for each project and prepare message if not

missing_table_ingestion=0
missing_table_ingestion=$(/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o header=false -o timing=false -o output_format=plain -q "select count(*)
from ${DB}.public.d_pi_projects pr
left outer join ${DB}.public.d_pi_tables ta
where pr.active = true
and ta.s3_sourced = true and ta.active = true
and not exists (select 1 from ${DB}.public.d_pi_project_unavailable_tables ua
               where ua.project_id = pr.projectid
               and ua.table_name = ta.table_name
               and (end_unavailable_date is null or end_unavailable_date >= current_date()))
and not exists (select 1 from ${DB}.raw.ingest_pi_data_det_log dl
               where dl.projectid = pr.projectid
               and dl.object_category = 'TABLE'
               and dl.object_name = ta.table_name
               and dl.status_string = 'SUCCEEDED'
                and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp())); ")

echo "count of missing success indicator for tables is ${missing_table_ingestion}"

if [ "$missing_table_ingestion" != 0 ]
then
echo -e "\nThe following tables do not have a success indicator in the PI data ingestion log: \n" >> $INGESTION_LOG

/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o timing=false -o header=false -o output_format=tsv -q "select rpad(pr.projectid,10,' '), rpad(pr.projectname,15,' '), ta.table_name
from ${DB}.public.d_pi_projects pr
left outer join ${DB}.public.d_pi_tables ta
where pr.active = true
and ta.s3_sourced = true and ta.active = true
and not exists (select 1 from ${DB}.public.d_pi_project_unavailable_tables ua
               where ua.project_id = pr.projectid
               and ua.table_name = ta.table_name
               and (end_unavailable_date is null or end_unavailable_date >= current_date()))
and not exists (select 1 from ${DB}.raw.ingest_pi_data_det_log dl
               where dl.projectid = pr.projectid
               and dl.object_category = 'TABLE'
               and dl.object_name = ta.table_name
               and dl.status_string = 'SUCCEEDED'
               and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp())
)

  order by pr.projectname, ta.table_name; " >> $INGESTION_LOG
fi

#test for success entry in log for session contact summary load
session_contact_summary_success_count=0
session_contact_summary_success_count=$(/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o header=false -o timing=false -o output_format=plain -q "select count(*)
from ${DB}.raw.ingest_pi_data_det_log dl
                where dl.projectid = 'ALL' and upper(dl.object_name) = 'S_PI_SESSION_CONTACT_SUMMARY_LOAD' and upper(dl.status_string) = 'SUCCEEDED'
                and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp());")

echo "count of success indicator for session contact summary is ${session_contact_summary_success_count}"

if [ "$session_contact_summary_success_count" = 0 ]
then
echo -e "\nThe session contact summary load process does not have a success indicator in the PI data ingestion log: \n" >> $INGESTION_LOG
fi

#test for success entry in log for groups membership history process
groups_membership_history_success_count=0
groups_membership_history_success_count=$(/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o header=false -o timing=false -o output_format=plain -q "select count(*)
from ${DB}.raw.ingest_pi_data_det_log dl
                where dl.projectid = 'ALL' and upper(dl.object_name) = 'UPDATE_GROUPS_MEMBERSHIP_DAILY_SNAPSHOT' and upper(dl.status_string) = 'SUCCEEDED'
                and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp());")

echo "count of success indicator for groups membership daily snapshot process is ${groups_membership_history_success_count}"

if [ "$groups_membership_history_success_count" = 0 ]
then
echo -e "\nThe groups membership daily snapshot process does not have a success indicator in the PI data ingestion log: \n" >> $INGESTION_LOG
fi

#test and prepare message for handled failures in ingestion script

failed_count=0
failed_count=$(/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o header=false -o timing=false -o output_format=plain -q "select count(*)  
from ${DB}.raw.ingest_pi_data_det_log dl
left outer join ${DB}.public.d_pi_projects pr
on dl.projectid = pr.projectid
where (pr.active = true or dl.projectid = 'ALL')
and upper(dl.status_string) = 'FAILED' 
and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp())
and not exists (select 1 from ${DB}.public.d_pi_project_unavailable_tables ut 
                where dl.projectid = ut.project_id and dl.object_name = ut.table_name
                 and ((ut.end_unavailable_date is null) or (ut.end_unavailable_date >= current_date()))
               );")
echo "handled failed count is ${failed_count} "

if [ "$failed_count" != 0 ]
then
echo -e "\nThe following handled errors occured during PI data ingestion: \n" >> $INGESTION_LOG

/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o timing=false -o header=false -o output_format=tsv -q "select rpad(projectname,15,' '), convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts))) as ingestion_time, dl.msg 
from ${DB}.raw.ingest_pi_data_det_log dl
left outer join ${DB}.public.d_pi_projects pr
on dl.projectid = pr.projectid
where (pr.active = true or dl.projectid = 'ALL')
and upper(dl.status_string) = 'FAILED' 
and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp())
and not exists (select 1 from ${DB}.public.d_pi_project_unavailable_tables ut 
                where dl.projectid = ut.project_id and dl.object_name = ut.table_name
                 and ((ut.end_unavailable_date is null) or (ut.end_unavailable_date >= current_date()))
               )
 order by pr.projectname, dl.ts desc; " >> $INGESTION_LOG 
fi


#get list of successful ingestions

echo -e "\nThe following projects were ingested successfully (times listed are EST): \n" > $INGESTION_LOG_SUCCESS

/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o timing=false -o header=false -o output_format=tsv -q "select rpad(projectname,15,' '),dl.object_category || ' ', convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts))) as ingestion_time
from ${DB}.raw.ingest_pi_data_det_log dl
left outer join ${DB}.public.d_pi_projects pr
on dl.projectid = pr.projectid
where pr.active = true
and upper(dl.status_string) = 'SUCCEEDED'
and upper(dl.object_category) = 'INGESTION COMPLETED'
and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp())
and not exists (select 1 from ${DB}.raw.ingest_pi_data_det_log dl2
               where dl2.projectid = pr.projectid
               and upper (dl2.status_string)= 'FAILED'
               and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl2.ts)))) = date(current_timestamp()) 
               and not exists (select 1 from ${DB}.public.d_pi_project_unavailable_tables ut
                   where dl2.projectid = ut.project_id and dl2.object_name = ut.table_name
                   and ((ut.end_unavailable_date is null) or (ut.end_unavailable_date >= current_date()))
               )
 )
  order by dl.ts desc;" >> $INGESTION_LOG_SUCCESS

if [ "$session_contact_summary_success_count" -gt 0 ]
then
echo -e "\nSession Contact Summary Load Procedure completed successfully. \n" >> $INGESTION_LOG_SUCCESS
fi


if [ "$groups_membership_history_success_count" -gt 0 ]
then
echo -e "\nGroups membership daily snapshot procedure completed successfully. \n" >> $INGESTION_LOG_SUCCESS
fi



##get list of warnings
warning_count=0
warning_count=$(/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o timing=false -o header=false -o output_format=tsv -q "select count(*)
from ${DB}.raw.ingest_pi_data_det_log dl
left outer join ${DB}.public.d_pi_projects pr
on dl.projectid = pr.projectid
where pr.active = true
and upper(dl.status_string) = 'WARNING'
and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp()) ; ")

if [ "$warning_count" != 0 ]
then
echo -e "\nThe following warnings occured during PI data ingestion (ignore if this is expected behavior): \n" >> $INGESTION_LOG_SUCCESS

/snowsql/snowsql -c ${INGEST_C} -o exit_on_error=true -o friendly=false -o timing=false -o header=false -o output_format=tsv -q "select rpad(projectname,15,' '), convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts))) as ingestion_time, dl.msg
from ${DB}.raw.ingest_pi_data_det_log dl
left outer join ${DB}.public.d_pi_projects pr
on dl.projectid = pr.projectid
where pr.active = true
and upper(dl.status_string) = 'WARNING'
and date(convert_timezone('UTC','America/New_York',to_timestamp(to_varchar(dl.ts)))) = date(current_timestamp())
 order by pr.projectname, dl.ts desc; " >> $INGESTION_LOG_SUCCESS

fi


#check for alert conditions and prepare and send email 

if [ $failed_rc_count != 0 ] || [ $succeeded_rc_count != $configured_project_count ] || [ "$failed_count" != 0 ] || [ "$missing_project_ingestion" != 0 ] || [ "$missing_table_ingestion" != 0 ] || [ "$session_contact_summary_sp_rc" != 0 ] || [ "$session_contact_summary_success_count" = 0 ] || [ "$groups_membership_history_sp_rc" != 0 ] || [ "$groups_membership_history_success_count" = 0 ]

then

        cat $EMAIL_MESSAGE_FAIL $INGESTION_LOG $INGESTION_LOG_SUCCESS > $EMAIL_FINAL
        mail -s "$EMAIL_SUBJECT_FAIL" -r "$EMAIL_FROM" "$EMAIL_DESTINATION" <  $EMAIL_FINAL
        cat $EMAIL_FINAL   
     
else

        cat $EMAIL_MESSAGE_SUCCESS $INGESTION_LOG $INGESTION_LOG_SUCCESS > $EMAIL_FINAL
        mail -s "$EMAIL_SUBJECT_SUCCESS" -r "$EMAIL_FROM" "$EMAIL_DESTINATION" <  $EMAIL_FINAL
        cat $EMAIL_FINAL
fi


