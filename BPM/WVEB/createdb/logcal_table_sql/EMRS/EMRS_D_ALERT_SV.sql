SELECT alert_id as alert_id
       ,alert_id as source_record_id
       ,case_id as case_number
       ,client_id as client_number
       ,message as message
       ,start_date as source_alert_start_date
       ,end_date as source_alert_end_date
       ,void_ind as void_ind
       ,system_alert_ind as system_alert_ind
       ,ref_type as ref_type
       ,ref_id as ref_id
       ,lock_id as lock_id
       ,record_count as record_count
       ,alert_handler as alert_handler
       ,TRUNC(create_ts) as record_date
       ,TO_CHAR(create_ts,'HH24MI') as record_time
       ,created_by as record_name
       ,TRUNC(update_ts) as modified_date
       ,updated_by as modified_name
       ,TO_CHAR(update_ts,'HH24MI') as modified_time
       ,create_ts as date_created
       ,update_ts as date_updated
       ,created_by as created_by
       ,updated_by as updated_by
FROM alert