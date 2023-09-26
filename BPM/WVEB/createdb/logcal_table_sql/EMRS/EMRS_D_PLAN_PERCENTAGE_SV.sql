SELECT plan_percentage_id
,updated_by
,yyyymm year_month
,NULL plan_type_id
,program_type_cd managed_care_program
,service_area
,plan_id source_plan_id
,percentage 
,create_ts record_date
,TO_CHAR(create_ts,'HH24MI') record_time
,created_by record_name
,update_ts modified_date
,TO_CHAR(update_ts,'HH24MI') modified_time
,updated_by modified_name
,create_ts date_created
,created_by
,update_ts date_updated
,plan_percentage_id source_record_id
,plan_type_cd plan_type
FROM plan_percentage