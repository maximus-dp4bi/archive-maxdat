

INSERT INTO CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME, RECORD_EFF_DT, RECORD_END_DT) VALUES ('IVR', to_date('01-JAN-1900', 'dd-mon-yyyy'), to_date('31-DEC-2999', 'dd-mon-yyyy'));

UPDATE CC_C_UNIT_OF_WORK SET UNIT_OF_WORK_NAME = 'HILanguage' WHERE UNIT_OF_WORK_NAME = 'HI Language';
UPDATE CC_C_UNIT_OF_WORK SET UNIT_OF_WORK_NAME = 'OtherLanguage' WHERE UNIT_OF_WORK_NAME = 'Other Language';
UPDATE CC_C_UNIT_OF_WORK SET UNIT_OF_WORK_NAME = 'EngLanguage' WHERE UNIT_OF_WORK_NAME = 'English Language';


UPDATE CC_D_UNIT_OF_WORK SET UNIT_OF_WORK_NAME = 'HILanguage' WHERE UNIT_OF_WORK_NAME = 'HI Language';
UPDATE CC_D_UNIT_OF_WORK SET UNIT_OF_WORK_NAME = 'OtherLanguage' WHERE UNIT_OF_WORK_NAME = 'Other Language';
UPDATE CC_D_UNIT_OF_WORK SET UNIT_OF_WORK_NAME = 'EngLanguage' WHERE UNIT_OF_WORK_NAME = 'English Language';

UPDATE CC_C_CONTACT_QUEUE SET UNIT_OF_WORK_NAME = 'HILanguage' WHERE UNIT_OF_WORK_NAME = 'HI Language';
UPDATE CC_C_CONTACT_QUEUE SET UNIT_OF_WORK_NAME = 'OtherLanguage' WHERE UNIT_OF_WORK_NAME = 'Other Language';
UPDATE CC_C_CONTACT_QUEUE SET UNIT_OF_WORK_NAME = 'EngLanguage' WHERE UNIT_OF_WORK_NAME = 'English Language';


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) VALUES ('0.1.3','101','101_UPDATE_UNIT_OF_WORK');

COMMIT;