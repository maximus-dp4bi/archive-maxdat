insert into cc_d_project (project_id, project_name, segment_id)
values (2, 'IL EEV', 2);

insert into cc_d_program (program_id, program_name)
values (4, 'EEV');

insert into cc_d_project_targets (project_id, average_handle_time_target,cost_per_call_target,labor_cost_per_call_target
  ,occupancy_target,utilization_target,record_eff_dt,record_end_dt,version)
values (2,0,0,0,0,0,to_date('01/01/1900', 'mm/dd/yyyy'),to_date('12/31/2199', 'mm/dd/yyyy'),1);
commit;

insert into cc_l_patch_log (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
values ('0.3.1',116,'116_INSERT_EEV_D_PROJECT_AND_PROGRAM');
commit;
