
select 
a.TASK_ID, 
a.CURR_OWNER_STAFF_ID, 
c.TEAM_SUPERVISOR_STAFF_ID
from d_MW_v2_current_sv a
--join d_staff b on (a.CURR_OWNER_STAFF_ID = b.staff_id)
join d_teams_sv c on 
	(a.CURR_TEAM_ID = c.TEAM_ID) --and
--(c.TEAM_SUPERVISOR_STAFF_ID = a.CURR_OWNER_STAFF_ID)
join d_staff d on (c.TEAM_SUPERVISOR_STAFF_ID = d.staff_id)