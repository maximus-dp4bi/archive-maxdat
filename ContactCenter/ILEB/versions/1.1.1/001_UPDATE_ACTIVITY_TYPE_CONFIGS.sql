
UPDATE CC_C_ACTIVITY_TYPE SET ACTIVITY_TYPE_CATEGORY='Scheduled PTO', IS_ABSENCE_FLAG=1 WHERE ACTIVITY_TYPE_NAME = 'Holiday';
UPDATE CC_C_ACTIVITY_TYPE SET ACTIVITY_TYPE_CATEGORY='Available', IS_PAID_FLAG=1, IS_AVAILABLE_FLAG=1, IS_READY_FLAG=1 WHERE ACTIVITY_TYPE_NAME = 'LTC Team';

UPDATE CC_D_ACTIVITY_TYPE SET ACTIVITY_TYPE_CATEGORY='Scheduled PTO', IS_ABSENCE_FLAG=1 WHERE ACTIVITY_TYPE_NAME = 'Holiday';
UPDATE CC_D_ACTIVITY_TYPE SET ACTIVITY_TYPE_CATEGORY='Available', IS_PAID_FLAG=1, IS_AVAILABLE_FLAG=1, IS_READY_FLAG=1 WHERE ACTIVITY_TYPE_NAME = 'LTC Team';

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('1.1.1','001','001_UPDATE_ACTIVITY_TYPE_CONFIGS');

COMMIT; 