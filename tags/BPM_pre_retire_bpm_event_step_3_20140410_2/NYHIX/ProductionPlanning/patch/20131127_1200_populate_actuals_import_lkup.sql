insert into maxdat.pp_cfg_actuals_file_control
  (cfg_actuals_file_control_id, project_id, program_id, geography_master_id, file_location, actuals_filename, enabled, create_date, last_update_date)
values
  (1, 1, 1, 1, '/u01/maximus/maxdat-prd/NYHIX/ETL/Processing/ProductionPlanning/Actuals/', 'PP_NYHIX_ACTUALS.TXT', 'Y', SYSDATE, SYSDATE);

  commit;
  /