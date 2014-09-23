delete from cc_f_agent_by_date where f_agent_by_date_id in(
with dups as(
select 
d_date_id
,d_agent_id
,d_site_id
,d_group_id
,d_program_id
,d_project_targets_id
,d_geography_master_id
,count(*)
from cc_f_agent_by_date
group by
d_date_id
,d_agent_id
,d_site_id
,d_group_id
,d_program_id
,d_project_targets_id
,d_geography_master_id
having count(*)>1)
select min(f_agent_by_date_id) from cc_f_agent_by_date b
inner join dups a on a.d_date_id=b.d_date_id
and a.d_agent_id=b.d_agent_id
and a.d_site_id =b.d_site_id
and a.d_group_id =b.d_group_id
and a.d_program_id=b.d_program_id
and a.d_project_targets_id=b.d_project_targets_id
and a.d_geography_master_id =b.d_geography_master_id
group by b.d_date_id,b.d_agent_id,b.d_site_id,b.d_group_id,b.d_program_id,b.d_project_targets_id,b.d_geography_master_id);

commit;