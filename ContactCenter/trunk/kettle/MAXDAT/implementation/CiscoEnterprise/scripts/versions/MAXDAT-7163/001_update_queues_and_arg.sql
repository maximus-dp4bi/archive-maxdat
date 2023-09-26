ALTER SESSION SET CURRENT_SCHEMA=CISCO_ENTERPRISE_CC;

UPDATE CC_C_CONTACT_QUEUE
SET QUEUE_TYPE = 'Escalation', SERVICE_SECONDS = 30, INTERVAL_MINUTES = 15, UNIT_OF_WORK_NAME = 'Mass Health - White Glove NoAgents', PROJECT_NAME = 'Mass Health', PROGRAM_NAME = 'Customer Service Center', REGION_NAME = 'Eastern', STATE_NAME = 'Massachusetts'
WHERE QUEUE_NUMBER = 7323;

UPDATE CC_C_CONTACT_QUEUE
SET QUEUE_TYPE = 'Escalation', SERVICE_SECONDS = 30, INTERVAL_MINUTES = 15, UNIT_OF_WORK_NAME = 'Mass Health - White Glove Queue', PROJECT_NAME = 'Mass Health', PROGRAM_NAME = 'Customer Service Center', REGION_NAME = 'Eastern', STATE_NAME = 'Massachusetts'
WHERE QUEUE_NUMBER = 7324;

UPDATE CC_C_CONTACT_QUEUE
SET QUEUE_TYPE = 'Escalation', SERVICE_SECONDS = 30, INTERVAL_MINUTES = 15, UNIT_OF_WORK_NAME = 'Mass Health - White Glove RONA', PROJECT_NAME = 'Mass Health', PROGRAM_NAME = 'Customer Service Center', REGION_NAME = 'Eastern', STATE_NAME = 'Massachusetts'
WHERE QUEUE_NUMBER = 7325;

COMMIT;

/* AGENT ROUTING GROUP */

UPDATE CC_C_AGENT_RTG_GRP
SET PROJECT_NAME = 'Mass Health', PROGRAM_NAME = 'Customer Service Center', REGION_NAME = 'Eastern', STATE_NAME = 'Massachusetts'
where agent_routing_group_number = 5342;
    
commit;    

/* CC_C_FILTER */

INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_PQ_ID_INC', 5342);

commit;

/* UNIT OF WORK */

INSERT INTO CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, RECORD_EFF_DT, RECORD_END_DT, ACD, IVR) 
VALUES ('Mass Health - White Glove NoAgents','Escalation',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

INSERT INTO CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, RECORD_EFF_DT, RECORD_END_DT, ACD, IVR) 
VALUES ('Mass Health - White Glove Queue','Escalation',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

INSERT INTO CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, RECORD_EFF_DT, RECORD_END_DT, ACD, IVR) 
VALUES ('Mass Health - White Glove RONA','Escalation',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

INSERT INTO CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, PRODUCTION_PLAN_ID, HOURLY_FLAG, HANDLE_TIME_UNIT, ACD, IVR) 
VALUES ('Mass Health - White Glove NoAgents','Escalation', 1, 'N', 'Seconds', 1, 0);
    
INSERT INTO CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, PRODUCTION_PLAN_ID, HOURLY_FLAG, HANDLE_TIME_UNIT, ACD, IVR) 
VALUES ('Mass Health - White Glove Queue','Escalation', 1, 'N', 'Seconds', 1, 0);

INSERT INTO CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, PRODUCTION_PLAN_ID, HOURLY_FLAG, HANDLE_TIME_UNIT, ACD, IVR) 
VALUES ('Mass Health - White Glove RONA','Escalation', 1, 'N', 'Seconds', 1, 0);

commit;    

