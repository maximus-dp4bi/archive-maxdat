

update s_metric_template
set is_actuals_trend_processed = 'Y',
is_forecast_variance_processed = 'Y'
;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('2.4','012','012_UPDATE_S_METRIC_TEMPLATE');

COMMIT;