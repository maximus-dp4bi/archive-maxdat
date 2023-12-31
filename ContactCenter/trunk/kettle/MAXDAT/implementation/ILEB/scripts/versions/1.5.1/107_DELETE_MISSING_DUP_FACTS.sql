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

commit;