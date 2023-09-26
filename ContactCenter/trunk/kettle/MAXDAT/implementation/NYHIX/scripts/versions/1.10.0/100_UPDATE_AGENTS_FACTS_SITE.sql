update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='11CW FL-6  Z-1')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='11CW FL-6  Z-1'
);

update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='11CW FL-6  Z-2')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='11CW FL-6  Z-2'
);

update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='11CW FL-6  Z-3')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='11CW FL-6  Z-3'
);

update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='22CW FL-2  Z-1')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='22CW FL-2  Z-1'
);

update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='22CW FL-2  Z-2')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='22CW FL-2  Z-2'
);

update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='22CW FL-4  Z-1')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='22CW FL-4  Z-1'
);

update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='22CW FL-4  Z-2')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='22CW FL-4  Z-2'
);

update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='30 Broad')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='30 Broad'
);

update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='NYC FL-16')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='NYC FL-16'
);

update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='NYC FL-17')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='NYC FL-17'
);


update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='NYC FL-5')
where f_agent_by_date_id in(
SELECT F.F_AGENT_BY_DATE_ID
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='NYC FL-5'
);

-- update agent_activity_by_date site

update cc_f_agent_activity_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='11CW FL-6  Z-1')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='11CW FL-6  Z-1'
);

update cc_f_agent_activity_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='11CW FL-6  Z-2')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='11CW FL-6  Z-2'
);

update cc_f_agent_activity_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='11CW FL-6  Z-3')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='11CW FL-6  Z-3'
);

update cc_f_agent_activity_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='22CW FL-2  Z-1')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='22CW FL-2  Z-1'
);

update cc_f_agent_activity_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='22CW FL-2  Z-2')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='22CW FL-2  Z-2'
);

update cc_f_agent_activity_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='22CW FL-4  Z-1')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='22CW FL-4  Z-1'
);

update cc_f_agent_activity_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='22CW FL-4  Z-2')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='22CW FL-4  Z-2'
);

update cc_f_agent_activity_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='30 Broad')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='30 Broad'
);

update cc_f_agent_activity_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='NYC FL-16')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='NYC FL-16'
);

update cc_f_agent_activity_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='NYC FL-17')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='NYC FL-17'
);


update cc_f_agent_activity_by_date set d_site_id=(select d_site_id from cc_d_site where site_name='NYC FL-5')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_SITE DS ON SA.SITE_NAME = DS.SITE_NAME
where DS.SITE_NAME='NYC FL-5'
);

commit;