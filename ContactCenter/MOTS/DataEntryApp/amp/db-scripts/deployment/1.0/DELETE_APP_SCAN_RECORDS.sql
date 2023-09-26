delete s_metric m
where s_actuals_project_report_id in (
  select s_project_report_id
  from s_project_report pr
  where d_project_id > 1000
  and d_project_id != 2440
);

delete s_metric m
where s_forecasts_project_report_id in (
  select s_project_report_id
  from s_project_report pr
  where d_project_id > 1000
  and d_project_id != 2440
);

delete s_project_report
where d_project_id > 1000
and d_project_id != 2440;

delete f_metric
where d_metric_project_id in (
 select d_metric_project_id
 from d_metric_project
  where d_project_id > 1000
  and d_project_id != 2440
);

delete d_metric_project
where d_project_id > 1000
and d_project_id != 2440;

delete d_project_program 
where d_project_id > 1000
and d_project_id != 2440;

delete d_project_geography_master
where d_project_id > 1000
and d_project_id != 2440;

delete d_project_user
where d_project_id > 1000
and d_project_id != 2440;


delete d_project 
where d_project_id > 1000
and d_project_id != 2440;

INSERT INTO CC_L_PATCH_LOG(PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME, SCRIPT_RUN_DATE) VALUES ('AMP-DC-1.0', 23, 'DELETE_APP_SCAN_RECORDS.sql', SYSDATE);

COMMIT;

