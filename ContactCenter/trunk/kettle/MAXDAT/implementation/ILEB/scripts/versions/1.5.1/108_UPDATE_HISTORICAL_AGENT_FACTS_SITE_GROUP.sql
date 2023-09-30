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