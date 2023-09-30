
select * from d_project;

select * from d_program;

select * from d_geography_master;



insert into d_project_program (d_project_id, d_program_id) select distinct d_project_id, d_program_id from d_metric_project;

insert into d_project_geography_master (d_project_id, d_geography_master_id) select distinct d_project_id, d_geography_master_id from d_metric_project;


select * from amp_user;

select * from amp_role;

select d_project_user_id, pu.d_project_id, p.project_name, pu.app_user_id, u.username, d_project_role_id, r.name, functional_area
from d_project_user pu
inner join amp_user u on pu.app_user_id = u.id
inner join d_project p on pu.d_project_id = p.d_project_id
inner join amp_role r on pu.d_project_role_id = r.id;

select * from s_project_report;

/*
insert into d_project_user(d_project_user_id, d_project_id, app_user_id, d_project_role_id, functional_area, is_active_flag)
values (-11, -2, -7, -4, 'Back Office', 'Y');

insert into d_project_user(d_project_user_id, d_project_id, app_user_id, d_project_role_id, functional_area, is_active_flag)
values (-12, -2, -8, -4, 'Contact Center', 'Y');
*/