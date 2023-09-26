ALTER SESSION SET CURRENT_SCHEMA=CISCO_ENTERPRISE_CC;

UPDATE CC_C_CONTACT_QUEUE
SET QUEUE_TYPE = 'Callback', SERVICE_SECONDS = 30, INTERVAL_MINUTES = 15, UNIT_OF_WORK_NAME = 'MBRSVC Virtual CCB', PROJECT_NAME = 'Mass Health', PROGRAM_NAME = 'Customer Service Center', REGION_NAME = 'Eastern', STATE_NAME = 'Massachusetts'
WHERE QUEUE_NUMBER = 7209;


COMMIT;


/* UNITS OF WORK */

INSERT INTO CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, RECORD_EFF_DT, RECORD_END_DT, ACD, IVR) 
VALUES ('MBRSVC Virtual CCB','CALLBACK',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

INSERT INTO CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, PRODUCTION_PLAN_ID, HOURLY_FLAG, HANDLE_TIME_UNIT, ACD, IVR) 
VALUES ('MBRSVC Virtual CCB','CALLBACK', 1, 'N', 'Seconds', 1, 0);
       
commit;    
