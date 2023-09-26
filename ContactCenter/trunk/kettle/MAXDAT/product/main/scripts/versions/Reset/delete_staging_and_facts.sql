delete from cc_f_agent_by_date
where f_agent_by_date_id in (select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-OCT-15' and '30-APR-16');


delete from cc_f_agent_activity_by_date
where f_agent_activity_by_date_id in (select f_agent_activity_by_date_id from cc_f_agent_activity_by_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-OCT-15' and '30-APR-16');

delete from cc_f_agent_rtg_grp_interval
where f_agent_rtg_grp_interval_id in (select f_agent_rtg_grp_interval_id from cc_f_agent_rtg_grp_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-OCT-15' and '30-APR-16');


delete from cc_f_acd_agent_interval
where f_cc_acd_agent_intrvl_id in (select f_cc_acd_agent_intrvl_id from cc_f_acd_agent_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-OCT-15' and '30-APR-16');

delete from cc_f_actuals_queue_interval
where f_call_center_actls_intrvl_id in (select f_call_center_actls_intrvl_id from cc_f_actuals_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-OCT-15' and '30-APR-16');


delete from cc_f_acd_queue_interval
where f_cc_acd_queue_intrvl_id in (select f_cc_acd_queue_intrvl_id from cc_f_acd_queue_interval f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-OCT-15' and '30-APR-16');

delete from cc_f_term_call_vm
where f_term_call_vm_id in (select f_term_call_vm_id from cc_f_term_call_vm f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-OCT-15' and '30-APR-16');

delete from cc_f_call
where f_call_id in (select f_call_id from cc_f_call f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-OCT-15' and '30-APR-16');

delete from cc_f_ivr_menu_group_date
where f_ivr_menu_group_id in (select f_ivr_menu_group_id from cc_f_ivr_menu_group_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-OCT-15' and '30-APR-16');


delete from cc_s_acd_agent_interval
where trunc(interval_date) between '01-OCT-15' and '30-APR-16';

delete from CC_S_ACD_AGENT_ACTIVITY
where trunc(agent_calls_dt) between '01-OCT-15' and '30-APR-16';

delete from CC_S_AGENT_WORK_DAY
where trunc(work_date) between '01-OCT-15' and '30-APR-16';

delete from CC_S_WFM_AGENT_ACTIVITY
where trunc(activity_dt) between '01-OCT-15' and '30-APR-16';

delete from CC_S_AGENT_ABSENCE
where trunc(absence_date) between '01-OCT-15' and '30-APR-16';

delete from CC_S_AGENT_RTG_GRP_INTERVAL
where trunc(interval_date) between '01-OCT-15' and '30-APR-16';

delete from cc_s_acd_interval
where trunc(interval_date) between '01-OCT-15' and '30-APR-16';

delete from cc_s_acd_queue_interval
where trunc(interval_date) between '01-OCT-15' and '30-APR-16';

delete from cc_s_term_call_vm
where trunc(interval_date) between '01-OCT-15' and '30-APR-16';

delete from cc_s_call_detail
where trunc(call_date) between '01-OCT-15' and '30-APR-16';

delete from CC_S_IVR_MENU_GROUP_DATE
where trunc(call_date) between '01-OCT-15' and '30-APR-16';

commit;