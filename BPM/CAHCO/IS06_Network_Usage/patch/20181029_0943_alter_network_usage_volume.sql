ALTER TABLE TS_NETWORK_USAGE ADD (NETWORK_USAGE_VOLUME_temp NUMBER(38,2)); 
UPDATE TS_NETWORK_USAGE SET NETWORK_USAGE_VOLUME_temp = NETWORK_USAGE_VOLUME; 
commit;
ALTER TABLE TS_NETWORK_USAGE DROP COLUMN NETWORK_USAGE_VOLUME; 
ALTER TABLE TS_NETWORK_USAGE RENAME COLUMN NETWORK_USAGE_VOLUME_temp TO NETWORK_USAGE_VOLUME; 