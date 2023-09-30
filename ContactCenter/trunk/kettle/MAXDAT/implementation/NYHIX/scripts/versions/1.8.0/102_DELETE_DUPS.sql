delete from cc_f_agent_activity_by_date where f_agent_activity_by_date_id in(
with driver as( 
select D_DATE_ID
,D_AGENT_ID
,d_group_id
,D_PROJECT_ID
,D_PROGRAM_ID
,D_GEOGRAPHY_MASTER_ID
,activity_minutes
,d_site_id
,count(*)
from cc_f_agent_activity_by_date
group by D_DATE_ID
,D_AGENT_ID
,d_group_id
,D_PROJECT_ID
,D_PROGRAM_ID
,D_GEOGRAPHY_MASTER_ID
,activity_minutes
,d_site_id
having count(*)>1)
select f_agent_activity_by_date_id from cc_f_agent_activity_by_date b
inner join  driver a on  a.d_date_id=b.d_date_id
and a.d_program_id=b.d_program_id
and a.d_group_id=b.d_group_id
and a.D_PROJECT_ID=b.D_PROJECT_ID
and a.d_agent_id=b.d_agent_id
and a.D_GEOGRAPHY_MASTER_ID =b.D_GEOGRAPHY_MASTER_ID
and a.d_site_id =b.d_site_id
and a.activity_minutes =b.activity_minutes
and b.D_ACTIVITY_TYPE_ID=461);

COMMIT;

update cc_f_agent_activity_by_date set d_activity_type_id=(select d_activity_type_id from cc_d_activity_type where activity_type_name='Pipkins Modification UPK' and activity_type_category !='Unknown')
where f_agent_activity_by_date_id in(
SELECT F.f_agent_activity_by_date_id
FROM CC_F_AGENT_ACTIVITY_BY_DATE F
INNER JOIN cc_d_activity_type ATC ON ATC.d_activity_type_id  = f.d_activity_type_id 
where ATC.activity_type_name='Pipkins Modification UPK' and ATC.activity_type_category ='Unknown'
); 


commit;
