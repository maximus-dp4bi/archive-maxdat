alter session set current_schema = cisco_enterprise_cc;

/* select d_program_id, count(*) from cc_f_agent_by_date
where D_PROJECT_TARGETS_ID = 542
group by d_program_id;
*/

update cc_f_agent_by_date
set d_program_id = (select program_id from cc_d_program where program_name = 'Medical Application Assistance')
where d_program_id = (select program_id from cc_d_program where program_name = 'Multiple')
and d_project_targets_id = (select d_project_targets_id from cc_d_project_targets where project_id = (select project_id from cc_d_project where project_name = 'LA LARA'));
----------------------

/*
select d_program_id, count(*) from cc_f_acd_agent_interval
where D_PROJECT_ID = 762
group by d_program_id;
*/

update cc_f_acd_agent_interval
set d_program_id = (select program_id from cc_d_program where program_name = 'Medical Application Assistance')
where d_program_id = (select program_id from cc_d_program where program_name = 'Multiple')
and d_project_id = (select project_id from cc_d_project where project_name = 'LA LARA');
---------------------------

/*
select d_program_id, count(*) from cc_f_acd_agent_activity_consolidated
where d_project_id = 762
group by d_program_id;
*/

update cc_f_acd_agent_activity_consolidated
set d_program_id = (select program_id from cc_d_program where program_name = 'Medical Application Assistance')
where d_program_id = (select program_id from cc_d_program where program_name = 'Multiple')
and d_project_id = (select project_id from cc_d_project where project_name = 'LA LARA');

-----------------------------

/*
select d_program_id, count(*) from cc_f_acd_agent_activity_detail
where d_project_id = 762
group by d_program_id;
*/

update cc_f_acd_agent_activity_detail
set d_program_id = (select program_id from cc_d_program where program_name = 'Medical Application Assistance')
where d_program_id = (select program_id from cc_d_program where program_name = 'Multiple')
and d_project_id = (select project_id from cc_d_project where project_name = 'LA LARA');

----------------------------

/*
select d_program_id, count(*) from cc_f_agent_activity_by_date
where d_project_id = 762
group by d_program_id;
*/

update cc_f_agent_activity_by_date
set d_program_id = (select program_id from cc_d_program where program_name = 'Medical Application Assistance')
where d_program_id = (select program_id from cc_d_program where program_name = 'Multiple')
and d_project_id = (select project_id from cc_d_project where project_name = 'LA LARA');

------------------------------

commit;

