--correct existing d_supervisor table
delete d_supervisor;
--create a team for each supervisor in the d_supervisor table
delete d_teams where team_id != 0;
insert into d_teams select distinct(stf.staff_id) as team_id, 
stf.first_name || ' ' ||case when stf.middle_name is not null then stf.middle_name || ' ' else '' end || stf.last_name as team_name,
stf.first_name || ' ' ||case when stf.middle_name is not null then stf.middle_name || ' ' else '' end || stf.last_name as team_description,
stf.staff_id as team_supervisor_staff_id
from d_staff stf, d_supervisor su
where stf.staff_id = su.supervisor_person_id
order by stf.staff_id;
--include 0 record for None (no supervisor team)
update d_teams set team_name = 'None', team_description = 'None' where team_id = 0;
--populate backlog team ids based on supervisor
update d_mw_task_instance ti 
set ti.curr_team_id = 
nvl((select te.team_id
from d_teams te, d_supervisor su 
where te.team_supervisor_staff_id = su.supervisor_person_id
and su.person_id = ti.curr_owner_staff_id),0);