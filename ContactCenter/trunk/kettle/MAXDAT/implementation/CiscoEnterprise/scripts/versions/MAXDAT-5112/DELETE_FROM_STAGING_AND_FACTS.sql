alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

alter session set current_schema = CISCO_ENTERPRISE_CC;

delete from cc_f_agent_by_date
where f_agent_by_date_id in (select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '17-APR-17');


delete from cc_f_agent_activity_by_date
where f_agent_activity_by_date_id in (select f_agent_activity_by_date_id from cc_f_agent_activity_by_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '17-APR-17');


delete from cc_f_acd_agent_interval
where f_cc_acd_agent_intrvl_id in (select f_cc_acd_agent_intrvl_id from cc_f_acd_agent_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date >= '17-APR-17');


delete from cc_s_acd_agent_interval
where trunc(interval_date) >= '17-APR-17';

delete from CC_S_ACD_AGENT_ACTIVITY
where trunc(agent_calls_dt) >= '17-APR-17';

delete from CC_S_AGENT_WORK_DAY
where trunc(work_date) >= '17-APR-17';

delete from CC_S_WFM_AGENT_ACTIVITY
where trunc(activity_dt) >= '17-APR-17';

delete from CC_S_AGENT_ABSENCE
where trunc(absence_date) >= '17-APR-17';

commit;


#########################################################################################################################################################

alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

alter session set current_schema = CISCO_ENTERPRISE_CC;

delete from cc_f_agent_by_date
where f_agent_by_date_id in (select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '16-FEB-17' and '16-APR-17');



delete from cc_f_agent_activity_by_date
where f_agent_activity_by_date_id in (select f_agent_activity_by_date_id from cc_f_agent_activity_by_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '16-FEB-17' and '16-APR-17');


delete from cc_f_acd_agent_interval
where f_cc_acd_agent_intrvl_id in (select f_cc_acd_agent_intrvl_id from cc_f_acd_agent_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '16-FEB-17' and '16-APR-17');


delete from cc_s_acd_agent_interval
where trunc(interval_date) between '16-FEB-17' and '16-APR-17';

delete from CC_S_ACD_AGENT_ACTIVITY
where trunc(agent_calls_dt) between '16-FEB-17' and '16-APR-17';

delete from CC_S_AGENT_WORK_DAY
where trunc(work_date) between '16-FEB-17' and '16-APR-17';

delete from CC_S_WFM_AGENT_ACTIVITY
where trunc(activity_dt) between '16-FEB-17' and '16-APR-17';

delete from CC_S_AGENT_ABSENCE
where trunc(absence_date) between '16-FEB-17' and '16-APR-17';

commit;
