/*******************
*
*	DEPLOYMENT NOTE:  PLEASE DO NOT RUN THESE STATEMENTS UNTIL
*	AFTER THE INITIATIAL SET OF FORECAST FILES HAS BEEN UPLOADED
*	AND PROCESSED.  
*
*/



update cc_s_fcst_interval s
set interval_date = (
  select trunc(interval_start_date)
  from cc_s_interval si
  where s.interval_id = si.interval_id
);


update cc_f_forecast_interval f
set d_date_id = (
  select d_date_id
  from cc_d_dates dd
  inner join cc_d_interval di on dd.d_date = trunc(di.interval_start_date)
  where f.d_interval_id = di.d_interval_id
);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) VALUES ('0.1.3','200','200_UPDATE_FORECAST_DATE_ID');

commit;
