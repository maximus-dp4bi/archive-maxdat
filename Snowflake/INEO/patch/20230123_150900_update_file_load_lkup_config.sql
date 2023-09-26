 INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('AGENTPERFORMANCE_','INEO_AGENT_PERFORMANCE_HISTORY','INEO',
'date,userid,queue,calltype,interactions,avgtalk,totaltalk,avghold,totalhold,avgacw,totalacw,avgspdans,localdisconnected,agentavailable,filename',
'try_cast(date as date),userid,queue,calltype,try_cast(regexp_replace(interactions,''[^0-9]'','''') as number),avgtalk,totaltalk,avghold,totalhold,avgacw,totalacw,avgspdans,try_cast(regexp_replace(localdisconnected,''[^0-9]'','''') as number),agentavailable,filename',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY',
'INEO_AGENT_PERFORMANCE','AGENT_PERFORMANCE_ID','AGENT_PERFORMANCE_HISTORY_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('RCCIEDSSTASKINVENTORY__','INEO_RCC_IEDSS_TASK_INVENTORY_HISTORY','INEO',
'date,region,county,office,totals,filename,work_category,queue_name,task_name,future_total,current_total,overdue_total',
'try_cast(date as date),region,county,office,try_cast(regexp_replace(totals,''[^0-9]'','''') as number),filename,work_category,queue_name,task_name,try_cast(regexp_replace(future_total,''[^0-9]'','''') as number),try_cast(regexp_replace(current_total,''[^0-9]'','''') as number),try_cast(regexp_replace(overdue_total,''[^0-9]'','''') as number)',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY',
'INEO_RCC_IEDSS_TASK_INVENTORY','INEO_RCC_IEDSS_TASK_INVENTORY_ID','INEO_RCC_IEDSS_TASK_INVENTORY_HISTORY_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('INEOQUEUEDAILYSUMMARY_','INEO_QUEUE_DAILY_SUMMARY_HISTORY','INEO',
'date,abd,aht,asa,rcc,filename,calls_offered,calls_answered,abd15_secs,ab_rate,sla_8060,average_talk_time,average_hold_time,average_follow_up_time',
'try_cast(date as date),try_cast(regexp_replace(abd,''[^0-9]'','''') as number),aht,asa,rcc,filename,try_cast(regexp_replace(calls_offered,''[^0-9]'','''') as number),try_cast(regexp_replace(calls_answered,''[^0-9]'','''') as number),try_cast(regexp_replace(abd__15_secs,''[^0-9]'','''') as number),ab_rate,sla_8060,average_talk_time,average_hold_time,average_follow_up_time',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY',
'INEO_QUEUE_DAILY_SUMMARY','INEO_QUEUE_DAILY_SUMMARY_ID','INEO_QUEUE_DAILY_SUMMARY_HISTORY_ID');

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key) 
 VALUES('INEOQUEUESUMMARY_','INEO_QUEUE_SUMMARY_HISTORY','INEO',
'date,abd,aht,asa,rcc,filename,calls_offered,calls_answered,abd15_secs,ab_rate,sla_8060,average_talk_time,average_hold_time,average_follow_up_time,summary_type',
'try_cast(date as date),try_cast(regexp_replace(abd,''[^0-9]'','''') as number),aht,asa,rcc,filename,try_cast(regexp_replace(calls_offered,''[^0-9]'','''') as number),try_cast(regexp_replace(calls_answered,''[^0-9]'','''') as number),try_cast(regexp_replace(abd__15_secs,''[^0-9]'','''') as number),ab_rate,sla_8060,average_talk_time,average_hold_time,average_follow_up_time,summary_type',
'WHERE 1=1',
'Y',
'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual',
'PREVIOUS_BUSINESS_DAY',
'INEO_QUEUE_SUMMARY','INEO_QUEUE_SUMMARY_ID','INEO_QUEUE_SUMMARY_HISTORY_ID');
