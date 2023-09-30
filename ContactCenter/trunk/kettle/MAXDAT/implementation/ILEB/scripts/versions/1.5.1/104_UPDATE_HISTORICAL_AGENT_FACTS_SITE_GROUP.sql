-- update agent_by_date site



update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='Chicago-CES')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='Chicago-CES'
);

update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='Chicago-EEV')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='Chicago-EEV'
);


-- update agent_activity_by_date site

update cc_f_agent_activity_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='Chicago-CES')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='Chicago-CES'
);

update cc_f_agent_activity_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='Chicago-EEV')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='Chicago-EEV'
);


-- update agent_by_date group

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='CES Staff to be scheduled')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='CES Staff to be scheduled'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='EEV Staff to be scheduled')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='EEV Staff to be scheduled'
);


-- update agent_activity_by_date group

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='CES Staff to be scheduled')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='CES Staff to be scheduled'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='EEV Staff to be scheduled')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='EEV Staff to be scheduled'
);


commit;