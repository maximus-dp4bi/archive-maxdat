SET escape '\';

update cc_f_agent_by_date
set d_program_id=5,
d_project_targets_id=(select d_project_targets_id from cc_d_project_targets where project_id=4) 
where d_program_id=0 and d_agent_id in(select d_agent_id from cc_d_agent where login_id in (select login_id from cc_s_agent where agent_group='E\&E Supervisor'));

update cc_f_agent_activity_by_date
set d_project_id=4,
d_program_id=5 
where d_program_id=0 and d_agent_id in(select d_agent_id from cc_d_agent where login_id in (select login_id from cc_s_agent where agent_group='E\&E Supervisor'));

update cc_f_agent_by_date
set d_program_id=1,
d_project_targets_id=(select d_project_targets_id from cc_d_project_targets where project_id=1) 
where d_program_id=0 and d_agent_id in(select d_agent_id from cc_d_agent where login_id in (select login_id from cc_s_agent where agent_group='CC Supervisors'));

update cc_f_agent_activity_by_date
set d_project_id=1,
d_program_id=1
where d_program_id=0 and d_agent_id in(select d_agent_id from cc_d_agent where login_id in (select login_id from cc_s_agent where agent_group='CC Supervisors'));


COMMIT;

