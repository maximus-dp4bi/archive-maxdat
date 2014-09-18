
ALTER TABLE S_METRIC_TEMPLATE ADD (
  REPORTING_PERIOD_TYPE VARCHAR(50)
  , IS_FORECAST_VARIANCE_PROCESSED VARCHAR2 (1)
  , IS_ACTUALS_TREND_PROCESSED VARCHAR2 (1)
);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('2.3','012','012_ALTER_STAGING_TABLES');


COMMIT;
