-- update agent_by_date site
SET escape '\';


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

-- update agent_by_date group

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='CC Supervisors')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='CC Supervisors'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='E\&E Supervisor')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='E\&E Supervisor'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='Eligibility Specialist A')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='Eligibility Specialist A'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='Eligibility Specialist B')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='Eligibility Specialist B'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='Eligibility Specialist C')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='Eligibility Specialist C'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='Financial Management')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='Financial Management'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='HDSE')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='HDSE'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - Agency Conference')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - Agency Conference'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - Agency Conference Supervisor')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - Agency Conference Supervisor'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - FPBP')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - FPBP'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - FPBP Supervisor')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - FPBP Supervisor'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - PAP Supervisor')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - PAP Supervisor'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - Renewal Assistant')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - Renewal Assistant'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - Renewal Processing')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - Renewal Processing'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - Renewal Supervisor')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - Renewal Supervisor'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYHBE Individual Agents')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYHBE Individual Agents'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYHBE SHOP Agents')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYHBE SHOP Agents'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYHBE State Wide Agents')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYHBE State Wide Agents'
);

update cc_f_agent_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='OPS STAFF')
where f_agent_by_date_id in(
SELECT F.f_agent_by_date_id
FROM CC_F_AGENT_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='OPS STAFF'
);

-- update agent_activity_by_date group

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='CC Supervisors')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='CC Supervisors'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='E\&E Supervisor')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='E\&E Supervisor'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='Eligibility Specialist A')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='Eligibility Specialist A'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='Eligibility Specialist B')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='Eligibility Specialist B'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='Eligibility Specialist C')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='Eligibility Specialist C'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='Financial Management')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='Financial Management'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='HDSE')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='HDSE'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - Agency Conference')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - Agency Conference'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - Agency Conference Supervisor')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - Agency Conference Supervisor'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - FPBP')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - FPBP'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - FPBP Supervisor')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - FPBP Supervisor'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - PAP Supervisor')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - PAP Supervisor'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - Renewal Assistant')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - Renewal Assistant'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - Renewal Processing')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - Renewal Processing'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYEC - Renewal Supervisor')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYEC - Renewal Supervisor'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYHBE Individual Agents')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYHBE Individual Agents'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYHBE SHOP Agents')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYHBE SHOP Agents'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='NYHBE State Wide Agents')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='NYHBE State Wide Agents'
);

update cc_f_agent_activity_by_date set d_group_id=(select d_group_id from cc_d_group where group_name='OPS STAFF')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN CC_D_AGENT DA ON F.D_AGENT_ID = DA.D_AGENT_ID
INNER JOIN CC_S_AGENT SA ON DA.LOGIN_ID = SA.LOGIN_ID
INNER JOIN CC_D_GROUP GR ON SA.AGENT_GROUP = GR.GROUP_NAME
where GR.GROUP_NAME='OPS STAFF'
);

commit;