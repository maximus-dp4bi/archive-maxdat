ALTER TABLE D_GEOGRAPHY_MASTER MODIFY(COUNTRY_ID NULL); 
ALTER TABLE D_GEOGRAPHY_MASTER MODIFY(STATE_ID NULL);
ALTER TABLE D_GEOGRAPHY_MASTER MODIFY(PROVINCE_ID NULL);
ALTER TABLE D_GEOGRAPHY_MASTER MODIFY(DISTRICT_ID NULL);
ALTER TABLE D_GEOGRAPHY_MASTER MODIFY(REGION_ID NULL);

INSERT INTO CC_L_PATCH_LOG(PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME, SCRIPT_RUN_DATE) VALUES ('AMP-DC-1.0', 21, 'ALTER_D_GEOGRAPHY_MASTER.sql', SYSDATE);

COMMIT;