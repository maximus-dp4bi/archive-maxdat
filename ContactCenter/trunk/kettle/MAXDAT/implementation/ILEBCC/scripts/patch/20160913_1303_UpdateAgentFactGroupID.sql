--Update Group ID in Agent By Date Fact

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='CSR Bilingual')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='CSR Billingual'
and D_DATE_ID in (select d_date_id from cc_d_dates
where d_date between '01-AUG-16' and '31-AUG-16')
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='CSR English')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='CSR Englsh'
and D_DATE_ID in (select d_date_id from cc_d_dates
where d_date between '01-AUG-16' and '31-AUG-16')
);

commit;

--Update Group ID in Agent Activity by Date Fact

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='CSR Bilingual')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='CSR Billingual'
and D_DATE_ID in (select d_date_id from cc_d_dates
where d_date between '01-AUG-16' and '31-AUG-16')
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='CSR English')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='CSR Englsh'
and D_DATE_ID in (select d_date_id from cc_d_dates
where d_date between '01-AUG-16' and '31-AUG-16')
);

COMMIT;