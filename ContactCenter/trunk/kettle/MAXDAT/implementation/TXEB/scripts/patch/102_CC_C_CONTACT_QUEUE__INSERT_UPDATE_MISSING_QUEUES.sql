alter session set nls_date_format = 'YYYY-MM-DD HH24:MI:SS';
INSERT INTO CC_C_CONTACT_QUEUE(QUEUE_NUMBER, QUEUE_NAME, UNIT_OF_WORK_NAME, QUEUE_TYPE, PROJECT_NAME, PROGRAM_NAME, REGION_NAME, STATE_NAME, PROVINCE_NAME, DISTRICT_NAME, COUNTRY_NAME, RECORD_EFF_DT, RECORD_END_DT) VALUES ('5097', 'CHIP_INB_EN_VM', 'CHIP ENG VM', 'Inbound', 'Enrollment Broker', 'CHIP', 'Central', 'Texas', 'N/A', 'N/A', 'USA', '1900-01-01 00:00:00', '2999-12-31 00:00:00');
INSERT INTO CC_C_CONTACT_QUEUE(QUEUE_NUMBER, QUEUE_NAME, UNIT_OF_WORK_NAME, QUEUE_TYPE, PROJECT_NAME, PROGRAM_NAME, REGION_NAME, STATE_NAME, PROVINCE_NAME, DISTRICT_NAME, COUNTRY_NAME, RECORD_EFF_DT, RECORD_END_DT) VALUES ('5105', 'CHIP_INB_SP_VM', 'CHIP SPN VM', 'Inbound', 'Enrollment Broker', 'CHIP', 'Central', 'Texas', 'N/A', 'N/A', 'USA', '1900-01-01 00:00:00', '2999-12-31 00:00:00');

UPDATE CC_C_CONTACT_QUEUE SET SERVICE_PERCENT = 98.5, SERVICE_SECONDS = 15, QUEUE_TYPE = 'Inbound' WHERE QUEUE_NUMBER = 6964;
UPDATE CC_C_CONTACT_QUEUE SET SERVICE_PERCENT = 98.5, SERVICE_SECONDS = 15, QUEUE_TYPE = 'Inbound' WHERE QUEUE_NUMBER = 6965;
UPDATE CC_C_CONTACT_QUEUE SET SERVICE_PERCENT = 98.5, SERVICE_SECONDS = 15, QUEUE_TYPE = 'Inbound' WHERE QUEUE_NUMBER = 6966;
UPDATE CC_C_CONTACT_QUEUE SET SERVICE_PERCENT = 98.5, SERVICE_SECONDS = 15, QUEUE_TYPE = 'Inbound' WHERE QUEUE_NUMBER = 6967;
UPDATE CC_C_CONTACT_QUEUE SET SERVICE_PERCENT = 98.5, SERVICE_SECONDS = 15, QUEUE_TYPE = 'Inbound' WHERE QUEUE_NUMBER = 6968;
UPDATE CC_C_CONTACT_QUEUE SET SERVICE_PERCENT = 98.5, SERVICE_SECONDS = 15, QUEUE_TYPE = 'Inbound' WHERE QUEUE_NUMBER = 6969;
UPDATE CC_C_CONTACT_QUEUE SET SERVICE_PERCENT = 98.5, SERVICE_SECONDS = 15, QUEUE_TYPE = 'Inbound' WHERE QUEUE_NUMBER = 6971;
UPDATE CC_C_CONTACT_QUEUE SET SERVICE_PERCENT = 98.5, SERVICE_SECONDS = 15, QUEUE_TYPE = 'Inbound' WHERE QUEUE_NUMBER = 6972;
UPDATE CC_C_CONTACT_QUEUE SET SERVICE_PERCENT = 98.5, SERVICE_SECONDS = 15, QUEUE_TYPE = 'Inbound' WHERE QUEUE_NUMBER = 6973;
UPDATE CC_C_CONTACT_QUEUE SET SERVICE_PERCENT = 98.5, SERVICE_SECONDS = 15, QUEUE_TYPE = 'Inbound' WHERE QUEUE_NUMBER = 6974;
UPDATE CC_C_CONTACT_QUEUE SET SERVICE_PERCENT = 98.5, SERVICE_SECONDS = 15, QUEUE_TYPE = 'Inbound' WHERE QUEUE_NUMBER = 6975;
UPDATE CC_C_CONTACT_QUEUE SET SERVICE_PERCENT = 98.5, SERVICE_SECONDS = 15, QUEUE_TYPE = 'Inbound' WHERE QUEUE_NUMBER = 6976;

  INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
  VALUES ('0.1.4','102','102_CC_C_CONTACT_QUEUE__INSERT_UPDATE_MISSING_QUEUES');
  
  COMMIT;