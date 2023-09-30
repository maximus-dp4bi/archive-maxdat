delete from cc_f_agent_by_date
where f_agent_by_date_id in (select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '01-FEB-16');



delete from cc_f_agent_activity_by_date
where f_agent_activity_by_date_id in (select f_agent_activity_by_date_id from cc_f_agent_activity_by_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '01-FEB-16');



delete from cc_f_actuals_queue_interval
where f_call_center_actls_intrvl_id in (select f_call_center_actls_intrvl_id from cc_f_actuals_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '01-FEB-16');


delete from cc_f_acd_queue_interval
where f_cc_acd_queue_intrvl_id in (select f_cc_acd_queue_intrvl_id from cc_f_acd_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '01-FEB-16');

delete from cc_f_acd_agent_interval
where f_cc_acd_agent_intrvl_id in (select f_cc_acd_agent_intrvl_id from cc_f_acd_agent_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '01-FEB-16');


delete from cc_s_acd_interval
where trunc(interval_date) >= '01-FEB-16';

delete from cc_s_acd_queue_interval
where trunc(interval_date) >= '01-FEB-16';

delete from cc_s_acd_agent_interval
where trunc(interval_date) >= '01-FEB-16';

delete from CC_S_ACD_AGENT_ACTIVITY
where trunc(agent_calls_dt) >= '01-FEB-16';

delete from CC_S_AGENT_WORK_DAY
where trunc(work_date) >= '01-FEB-16';

delete from CC_S_WFM_AGENT_ACTIVITY
where trunc(activity_dt) >= '01-FEB-16';

delete from CC_S_AGENT_ABSENCE
where trunc(absence_date) >= '01-FEB-16';

commit;


delete from cc_d_contact_queue
where queue_number!= 0;

commit;