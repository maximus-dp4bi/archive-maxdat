
insert into d_project_program (d_project_id, d_program_id) select distinct d_project_id, d_program_id from d_metric_project;

insert into d_project_geography_master (d_project_id, d_geography_master_id) select distinct d_project_id, d_geography_master_id from d_metric_project;

commit;
