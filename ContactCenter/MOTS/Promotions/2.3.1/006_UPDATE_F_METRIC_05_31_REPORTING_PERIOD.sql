--  correct reporting period to 5/31 WEEKLY instead of 5/31 MONTHLY
update f_metric
set d_reporting_period_id = (
  select d_reporting_period_id 
  from d_reporting_period 
  where type = 'WEEKLY' 
  and end_date = to_date('2014/05/31', 'YYYY/MM/DD')
)
where f_metric_id in (
  select f_metric_id
  from f_metric f
  inner join d_reporting_period rp on f.d_reporting_period_id = rp.d_reporting_period_id
  where rp.type = 'MONTHLY'
  and end_date = to_date('2014/05/31', 'YYYY/MM/DD')
);


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.3.1','006','006_UPDATE_F_METRIC_05_31_REPORTING_PERIOD');

COMMIT;