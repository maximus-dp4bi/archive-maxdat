delete from s_metric
where s_metric_id in (
  SELECT m.s_metric_id
  FROM S_PROJECT_REPORT PR
  INNER JOIN S_METRIC M ON PR.S_PROJECT_REPORT_ID = M.S_ACTUALS_PROJECT_REPORT_ID
  left outer join d_metric_project mp 
    on pr.d_project_id = mp.d_project_id
    and pr.d_program_id = mp.d_program_id
    and pr.d_geography_master_id = mp.d_geography_master_id
    and m.d_metric_definition_id = mp.d_metric_definition_id
  left outer join f_metric f 
    on pr.d_reporting_period_id = f.d_reporting_period_id
    and mp.d_metric_project_id = f.d_metric_project_id
  WHERE pr.STATUS = 'Approved'
  AND IS_ACTUALS_TREND_PROCESSED <> 'Y'
  AND IS_ERROR <> 'Y'
  and f.f_metric_id is null
)
;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('3.1','007','007_DELETE_S_METRIC_TREND_BLOCKERS');

COMMIT;