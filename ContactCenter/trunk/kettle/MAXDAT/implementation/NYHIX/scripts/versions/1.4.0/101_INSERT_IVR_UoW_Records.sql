
SELECT SEQ_CC_D_UNIT_OF_WORK.NEXTVAL FROM CC_D_UNIT_OF_WORK;

INSERT INTO CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME) VALUES ('IVR');
INSERT INTO CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME, PRODUCTION_PLAN_ID, HOURLY_FLAG, HANDLE_TIME_UNIT) VALUES ('IVR',0,'N','Seconds');

INSERT INTO CC_L_PATCH_LOG (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
VALUES ('1.4.0',101,'101_INSERT_IVR_UoW_Records');

COMMIT;