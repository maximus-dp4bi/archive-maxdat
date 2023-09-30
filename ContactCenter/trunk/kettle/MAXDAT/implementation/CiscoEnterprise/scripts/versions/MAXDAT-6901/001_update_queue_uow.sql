INSERT INTO CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, RECORD_EFF_DT, RECORD_END_DT, ACD, IVR) 
VALUES ('MEB Eligibility Spanish Queue','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

INSERT INTO CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, PRODUCTION_PLAN_ID, HOURLY_FLAG, HANDLE_TIME_UNIT, ACD, IVR) 
VALUES ('MEB Eligibility Spanish Queue','INBOUND', 1, 'N', 'Seconds', 1, 0);

COMMIT;

UPDATE CC_C_CONTACT_QUEUE
SET QUEUE_NAME = 'VAHM_MAMH_1839_MBRELGBLTY_SPA_Q', UNIT_OF_WORK_NAME = 'MEB Eligibility Spanish Queue'
WHERE QUEUE_NUMBER = 7178;

UPDATE CC_S_CONTACT_QUEUE
SET UNIT_OF_WORK_ID = (SELECT UNIT_OF_WORK_ID FROM CC_C_UNIT_OF_WORK WHERE UNIT_OF_WORK_NAME = 'MEB Eligibility Spanish Queue')
WHERE QUEUE_NUMBER = 7178;

UPDATE CC_D_CONTACT_QUEUE
SET D_UNIT_OF_WORK_ID = (SELECT UOW_ID FROM CC_D_UNIT_OF_WORK WHERE UNIT_OF_WORK_NAME = 'MEB Eligibility Spanish Queue')
WHERE QUEUE_NUMBER = 7178;

UPDATE CC_C_AGENT_RTG_GRP
SET AGENT_ROUTING_GROUP_NAME = 'VAHM_MAMH_MBRELGBLTY_SPA'
WHERE AGENT_ROUTING_GROUP_NUMBER = 5324
AND AGENT_ROUTING_GROUP_TYPE = 'Precision Queue';

UPDATE CC_F_ACD_AGENT_INTERVAL
SET D_UNIT_OF_WORK_ID = (SELECT UOW_ID FROM CC_D_UNIT_OF_WORK WHERE UNIT_OF_WORK_NAME = 'MEB Eligibility Spanish Queue')
WHERE D_CONTACT_QUEUE_ID IN (SELECT D_CONTACT_QUEUE_ID FROM CC_D_CONTACT_QUEUE WHERE QUEUE_NUMBER = 7178);

COMMIT;