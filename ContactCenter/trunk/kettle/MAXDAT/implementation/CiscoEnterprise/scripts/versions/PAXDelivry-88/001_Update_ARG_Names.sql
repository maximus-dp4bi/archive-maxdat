alter session set current_schema = cisco_enterprise_cc;

update cc_c_agent_rtg_grp
set agent_routing_group_name = 'VAHM_MAMH_MBRENROLL_SPA'
where agent_routing_group_number = 5446
and agent_routing_group_name = 'UAT_VAHM_MAMH_MBRENROLL_SPA';

update cc_c_agent_rtg_grp
set agent_routing_group_name = 'VAHM_MAMH_MBRELGB_SPA'
where agent_routing_group_number = 5447
and agent_routing_group_name = 'UAT_VAHM_MAMH_MBRELGB_SPA';

update cc_c_agent_rtg_grp
set agent_routing_group_name = 'VAHM_MAMH_MBRAPP_SPA'
where agent_routing_group_number = 5448
and agent_routing_group_name = 'UAT_VAHM_MAMH_MBRAPP_SPA';


commit;