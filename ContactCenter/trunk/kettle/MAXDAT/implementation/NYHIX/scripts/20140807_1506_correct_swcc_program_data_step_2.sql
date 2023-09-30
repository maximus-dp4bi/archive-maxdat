update cc_f_agent_by_date set d_program_id=(select program_id from cc_d_program where program_name='SWCC')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_C_PROJECT_CONFIG CPC ON SA.PROJECT_CONFIG_ID = CPC.PROJECT_CONFIG_ID
where cpc.program_name='SWCC'
);

commit;

update cc_f_agent_activity_by_date set d_program_id=(select program_id from cc_d_program where program_name='SWCC')
where f_agent_activity_by_date_id in(
SELECT F.F_AGENT_ACTIVITY_BY_DATE_ID
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_C_PROJECT_CONFIG CPC ON SA.PROJECT_CONFIG_ID = CPC.PROJECT_CONFIG_ID
where cpc.program_name='SWCC'
);

commit;
