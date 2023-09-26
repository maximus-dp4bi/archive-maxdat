--update status to all caps in task history table
update d_mw_task_history set task_status = 'COMPLETED' where task_status = 'Completed';
update d_mw_task_history set task_status = 'CLAIMED' where task_status = 'Claimed';
update d_mw_task_history set task_status = 'UNCLAIMED' where task_status = 'Unclaimed';
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