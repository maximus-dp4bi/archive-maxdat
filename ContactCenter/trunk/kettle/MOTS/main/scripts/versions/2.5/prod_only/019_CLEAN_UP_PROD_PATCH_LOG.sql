UPDATE CC_L_PATCH_LOG
SET PATCH_VERSION = '2.4'
  , SCRIPT_SEQUENCE = 018
  , SCRIPT_NAME = '018_INSERT_F_METRIC_RECORDS'
WHERE PATCH_VERSION = '2.5'
  AND SCRIPT_SEQUENCE = 003
  AND SCRIPT_NAME = '003_INSERT_F_METRIC_RECORDS';

INSERT INTO CC_L_PATCH_LOG (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
VALUES ('2.4',019,'019_CLEAN_UP_PROD_PATCH_LOG');

COMMIT;