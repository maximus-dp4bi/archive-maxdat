update tx_qc_random_sample set
local_start_time_dt = to_date(substr(LOCAL_START_TIME,1,18) || ' ' || substr(local_start_time, 27,2) ,'yy-mon-dd hh.mi.ss am')
,local_end_time_dt = to_date(substr(LOCAL_end_TIME,1,18) || ' ' || substr(local_end_time, 27,2) ,'yy-mon-dd hh.mi.ss am')
,create_date_dt = to_date(substr(create_date,1,18) || ' ' || substr(create_date, 27,2) ,'yy-mon-dd hh.mi.ss am')
, wrapup_time_secs = to_number(substr(wrapup_time, 4,2)) * 60 + to_number(substr(wrapup_time, 7,2))
;

select to_number(substr(call_duration, 4,2)) * 60 + to_number(substr(call_duration, 7,2)) d from tx_qc_random_sample

select * from tx_qc_random_sample

select * from survey_template

select * from survey_template_context
