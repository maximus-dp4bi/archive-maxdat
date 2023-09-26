--populate backlog team ids based on supervisor: d_mw_task_instance
update d_mw_task_instance ti 
set ti.curr_team_id = 
nvl((select te.team_id
from d_teams te, d_supervisor su 
where te.team_supervisor_staff_id = su.supervisor_person_id
and su.person_id = ti.curr_owner_staff_id),0);
--populate backlog team ids based on supervisor: corp_etl_mw
update corp_etl_mw mw 
set mw.team_id = 
nvl((select te.team_id
from d_teams te, d_supervisor su 
where te.team_supervisor_staff_id = su.supervisor_person_id
and su.person_id = mw.owner_staff_id),0);
--update team id in task history table for completed records 
update d_mw_task_history th 
set th.team_id = 
nvl((select te.team_id
from d_teams te, d_supervisor su, d_mw_task_instance ti 
where ti.mw_bi_id = th.mw_bi_id
and te.team_supervisor_staff_id = su.supervisor_person_id
and su.person_id = ti.curr_owner_staff_id),0)
where th.task_status in ('COMPLETED')
and th.team_id = 0;
--update team id in task history table for claimed records 
update d_mw_task_history th 
set th.team_id = 
nvl((select case when th.claim_date < ti.curr_claim_date then 0 else te.team_id end
from d_teams te, d_supervisor su, d_mw_task_instance ti 
where ti.mw_bi_id = th.mw_bi_id
and te.team_supervisor_staff_id = su.supervisor_person_id
and su.person_id = ti.curr_owner_staff_id),0)
where th.task_status in ('CLAIMED')
and th.team_id = 0;
