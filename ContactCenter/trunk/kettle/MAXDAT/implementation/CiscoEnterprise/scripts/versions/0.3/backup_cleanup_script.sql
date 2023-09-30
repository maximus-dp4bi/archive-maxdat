alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';


alter session set current_schema = CISCO_ENTERPRISE_CC;

delete from  cc_f_agent_by_date;

delete from  cc_f_agent_activity_by_date;

delete from  cc_f_actuals_queue_interval;

delete from  cc_f_acd_queue_interval;

delete from  cc_f_acd_agent_interval;

delete from  cc_s_acd_interval;

delete from  cc_s_acd_queue_interval;

delete from  cc_s_acd_agent_interval;

delete from  CC_S_ACD_AGENT_ACTIVITY;

delete from  CC_S_AGENT_WORK_DAY;

delete from  CC_S_WFM_AGENT_ACTIVITY;

delete from  CC_S_AGENT_ABSENCE;


commit;

delete from  CC_S_AGENT_SUPERVISOR;

delete from  CC_S_AGENT_GROUP;

delete from cc_d_agent
where login_id not in ('EBA', '0');

commit;

delete from cc_s_agent
where login_id not in ('EBA', '0');

commit;

delete from cc_d_group
where d_group_id != 0;

commit;

delete from cc_d_site
where d_site_id != 0;

commit;

