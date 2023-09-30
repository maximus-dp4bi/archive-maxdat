delete from cc_f_agent_by_date a
where rowid > ( select min(rowid) from cc_f_agent_by_date b
where a.d_date_id=b.d_date_id
and a.d_program_id=b.d_program_id
and a.D_GROUP_ID!=b.D_GROUP_ID
and a.SUPERVISOR_D_AGENT_ID=b.SUPERVISOR_D_AGENT_ID
and a.D_PROJECT_TARGETS_ID=b.D_PROJECT_TARGETS_ID
and a.MANAGER_D_AGENT_ID=b.MANAGER_D_AGENT_ID
and a.d_agent_id=b.d_agent_id
and a.D_GEOGRAPHY_MASTER_ID =b.D_GEOGRAPHY_MASTER_ID
and b.d_group_id =2);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='EEV Staff to be scheduled')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='EEV Staff to be scheduled'
);

commit;