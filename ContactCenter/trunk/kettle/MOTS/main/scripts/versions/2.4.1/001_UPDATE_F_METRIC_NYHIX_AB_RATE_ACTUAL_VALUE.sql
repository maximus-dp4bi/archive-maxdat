UPDATE F_METRIC
SET ACTUAL_VALUE = 0.68
WHERE F_METRIC_ID IN (
  SELECT F_METRIC_ID
  FROM F_METRIC F
  INNER JOIN D_METRIC_PROJECT MP ON F.D_METRIC_PROJECT_ID = MP.D_METRIC_PROJECT_ID
  INNER JOIN D_METRIC_DEFINITION MD ON MP.D_METRIC_DEFINITION_ID = MD.D_METRIC_DEFINITION_ID
  INNER JOIN D_PROJECT PRJ ON MP.D_PROJECT_ID = PRJ.D_PROJECT_ID
  INNER JOIN D_REPORTING_PERIOD RP ON F.D_REPORTING_PERIOD_ID = RP.D_REPORTING_PERIOD_ID
  WHERE PROJECT_NAME = 'NY HIX'
  AND MD.NAME = 'AB Rate'
  AND RP.END_DATE = TO_DATE('31-MAY-2014', 'DD-MON-YYYY')
  AND RP.TYPE = 'WEEKLY'
);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.4.1','001','001_UPDATE_F_METRIC_NYHIX_AB_RATE_ACTUAL_VALUE');
	
commit;