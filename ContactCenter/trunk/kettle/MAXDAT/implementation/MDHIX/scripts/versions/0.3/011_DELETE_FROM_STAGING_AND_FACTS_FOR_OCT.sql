delete from cc_f_agent_by_date
where f_agent_by_date_id in (select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-OCT-14' and '01-NOV-14');

commit;

delete from cc_f_agent_activity_by_date
where f_agent_activity_by_date_id in (select f_agent_activity_by_date_id from cc_f_agent_activity_by_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-OCT-14' and '01-NOV-14');

commit;

delete from cc_f_actuals_queue_interval
where f_call_center_actls_intrvl_id in (select f_call_center_actls_intrvl_id from cc_f_actuals_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-OCT-14' and '01-NOV-14');

commit;

delete from cc_s_acd_interval
where trunc(interval_date) between '01-OCT-14' and '01-NOV-14';

commit;

delete from CC_S_ACD_AGENT_ACTIVITY
where trunc(agent_calls_dt) between '01-OCT-14' and '01-NOV-14';

commit;

delete from CC_S_AGENT_WORK_DAY
where trunc(work_date) between '01-OCT-14' and '01-NOV-14';

commit;

delete from CC_S_WFM_AGENT_ACTIVITY
where trunc(activity_start_time) between '01-OCT-14' and '01-NOV-14';

commit;

delete from CC_S_AGENT_ABSENCE
where trunc(absence_date) between '01-OCT-14' and '01-NOV-14';

commit;
