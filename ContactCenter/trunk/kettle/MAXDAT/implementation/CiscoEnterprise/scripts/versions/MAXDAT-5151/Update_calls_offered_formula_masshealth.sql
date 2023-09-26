update cc_a_list_lkup
set out_var = 'select (CONTACTS_OFFERED - SHORT_CALLS - OUTFLOW_CONTACTS - AGENT_ERROR_COUNT - ERROR_COUNT- RETURN_RELEASE - CALLS_RONA - RETURN_BUSY - NETWORK_DEFAULT_ROUTED - ICR_DEFAULT_ROUTED - RETURN_RING - INCOMPLETE_CALLS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
where list_type = 'CC_S_ACD_INTERVAL-CALLS_OFFERED'
and value = 'Mass Health';


update cc_a_list_lkup
set out_var = 'select (CONTACTS_OFFERED - SHORT_CALLS - OUTFLOW_CONTACTS - AGENT_ERROR_COUNT - ERROR_COUNT- RETURN_RELEASE - CALLS_RONA - RETURN_BUSY - NETWORK_DEFAULT_ROUTED - ICR_DEFAULT_ROUTED - RETURN_RING - INCOMPLETE_CALLS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
where list_type = 'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
and value = 'Mass Health';

commit;


-- Delete from staging and facts ---

alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

alter session set current_schema = CISCO_ENTERPRISE_CC;

delete from cc_f_actuals_queue_interval
where f_call_center_actls_intrvl_id in (select f_call_center_actls_intrvl_id from cc_f_actuals_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '27-APR-17');


delete from cc_f_acd_queue_interval
where f_cc_acd_queue_intrvl_id in (select f_cc_acd_queue_intrvl_id from cc_f_acd_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '27-APR-17');

delete from cc_s_acd_interval
where trunc(interval_date) >= '27-APR-17';

delete from cc_s_acd_queue_interval
where trunc(interval_date) >= '27-APR-17';

commit;

-- Insert adhoc jobs --

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE) 
values('load_production_planning','2017-04-27 00:00:00','2017-04-28 00:00:00',1, 'CISCO', 'NA');

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE) 
values('load_production_planning','2017-04-28 00:00:00','2017-04-29 00:00:00',1, 'CISCO', 'NA');

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE) 
values('load_production_planning','2017-04-29 00:00:00','2017-04-30 00:00:00',1, 'CISCO', 'NA');

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE) 
values('load_production_planning','2017-04-30 00:00:00','2017-05-01 00:00:00',1, 'CISCO', 'NA');

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE) 
values('load_production_planning','2017-05-01 00:00:00','2017-05-02 00:00:00',1, 'CISCO', 'NA');

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE) 
values('load_production_planning','2017-05-02 00:00:00','2017-05-03 00:00:00',1, 'CISCO', 'NA');