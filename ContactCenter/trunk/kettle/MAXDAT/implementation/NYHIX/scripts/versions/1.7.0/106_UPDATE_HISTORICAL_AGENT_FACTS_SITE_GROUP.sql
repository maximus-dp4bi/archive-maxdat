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
and b.d_group_id in (1,5,8,10,13,14,15,16,17,18));


delete from cc_f_agent_activity_by_date a
where rowid > ( select min(rowid) from cc_f_agent_activity_by_date b
where a.d_date_id=b.d_date_id
and a.d_agent_id=b.d_agent_id
and a.D_ACTIVITY_TYPE_ID=b.D_ACTIVITY_TYPE_ID
and a.d_program_id=b.d_program_id
and a.D_GEOGRAPHY_MASTER_ID =b.D_GEOGRAPHY_MASTER_ID
and a.D_GROUP_ID!=b.D_GROUP_ID
and a.D_PROJECT_ID=b.D_PROJECT_ID)
and b.d_group_id in (1,3,4,5,7,8,10,13,14,15,16,17,18));


delete from cc_f_agent_by_date where f_agent_by_date_id in(
with driver as( 
select D_DATE_ID
,D_AGENT_ID
,SUPERVISOR_D_AGENT_ID
,MANAGER_D_AGENT_ID
,D_PROJECT_TARGETS_ID
,D_PROGRAM_ID
,D_GEOGRAPHY_MASTER_ID
,count(*)
from cc_f_agent_by_date
group by D_DATE_ID
,D_AGENT_ID
,SUPERVISOR_D_AGENT_ID
,MANAGER_D_AGENT_ID
,D_PROJECT_TARGETS_ID
,D_PROGRAM_ID
,D_GEOGRAPHY_MASTER_ID
having count(*)>1)
select f_agent_by_date_id from cc_f_agent_by_date b
inner join  driver a on  a.d_date_id=b.d_date_id
and a.d_program_id=b.d_program_id
and a.SUPERVISOR_D_AGENT_ID=b.SUPERVISOR_D_AGENT_ID
and a.D_PROJECT_TARGETS_ID=b.D_PROJECT_TARGETS_ID
and a.MANAGER_D_AGENT_ID=b.MANAGER_D_AGENT_ID
and a.d_agent_id=b.d_agent_id
and a.D_GEOGRAPHY_MASTER_ID =b.D_GEOGRAPHY_MASTER_ID
and b.d_group_id=0);


delete from cc_f_agent_activity_by_date where f_agent_activity_by_date_id in(
with driver as( 
select D_DATE_ID
,D_AGENT_ID
,D_ACTIVITY_TYPE_ID
,D_PROJECT_ID
,D_PROGRAM_ID
,D_GEOGRAPHY_MASTER_ID
,count(*)
from cc_f_agent_activity_by_date
group by D_DATE_ID
,D_AGENT_ID
,D_ACTIVITY_TYPE_ID
,D_PROJECT_ID
,D_PROGRAM_ID
,D_GEOGRAPHY_MASTER_ID
having count(*)>1)
select f_agent_activity_by_date_id from cc_f_agent_activity_by_date b
inner join  driver a on  a.d_date_id=b.d_date_id
and a.d_program_id=b.d_program_id
and a.D_ACTIVITY_TYPE_ID=b.D_ACTIVITY_TYPE_ID
and a.D_PROJECT_ID=b.D_PROJECT_ID
and a.d_agent_id=b.d_agent_id
and a.D_GEOGRAPHY_MASTER_ID =b.D_GEOGRAPHY_MASTER_ID
and b.d_group_id=0);

commit;

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