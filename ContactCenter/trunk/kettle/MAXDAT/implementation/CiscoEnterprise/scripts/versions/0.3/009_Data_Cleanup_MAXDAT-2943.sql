truncate table cc_f_agent_by_date;

truncate table cc_f_agent_activity_by_date;

truncate table cc_f_actuals_queue_interval;

truncate table cc_f_acd_queue_interval;

truncate table cc_f_acd_agent_interval;

truncate table cc_s_acd_interval;

truncate table cc_s_acd_queue_interval;

truncate table cc_s_acd_agent_interval;

truncate table CC_S_ACD_AGENT_ACTIVITY;

truncate table CC_S_AGENT_WORK_DAY;

truncate table CC_S_WFM_AGENT_ACTIVITY;

truncate table CC_S_AGENT_ABSENCE;


commit;

truncate table CC_S_AGENT_SUPERVISOR;

truncate table CC_S_AGENT_GROUP;

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

