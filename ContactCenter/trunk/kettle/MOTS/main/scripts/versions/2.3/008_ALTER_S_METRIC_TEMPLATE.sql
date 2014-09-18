
ALTER TABLE S_METRIC_TEMPLATE ADD (
  IS_ERROR VARCHAR2 (1) DEFAULT 'N'
);

ALTER TABLE S_METRIC_TEMPLATE 
MODIFY IS_PROCESSED VARCHAR2 (1) DEFAULT 'N';
ALTER TABLE S_METRIC_TEMPLATE 
MODIFY IS_FORECAST_VARIANCE_PROCESSED VARCHAR2 (1) DEFAULT 'N';
ALTER TABLE S_METRIC_TEMPLATE 
MODIFY IS_ACTUALS_TREND_PROCESSED VARCHAR2 (1) DEFAULT 'N';


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('2.3','008','008_ALTER_S_METRIC_TEMPLATE');


COMMIT;
