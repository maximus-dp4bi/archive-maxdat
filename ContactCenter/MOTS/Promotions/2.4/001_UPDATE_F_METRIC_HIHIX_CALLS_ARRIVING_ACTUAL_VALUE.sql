update f_metric
set actual_value = null, forecast_value = null
where d_metric_project_id = (select mp.d_metric_project_id
                            from d_metric_project mp
                            inner join d_project p
                              on mp.d_project_id = p.d_project_id
                            inner join d_metric_definition md
                              on mp.d_metric_definition_id = md.d_metric_definition_id
                            where md.name = 'Calls Arriving'
                              and p.project_name = 'HI HIX')
  and d_reporting_period_id = (select d_reporting_period_id
                              from d_reporting_period
                              where start_date = to_date('2014/05/04', 'yyyy/mm/dd'));

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.4','001','001_UPDATE_F_METRIC_HIHIX_CALLS_ARRIVING_ACTUAL_VALUE');