
ALTER TABLE CC_S_CONTACT_QUEUE MODIFY INTERVAL_MINUTES NUMBER(4,0);

ALTER TABLE CC_D_CONTACT_QUEUE MODIFY INTERVAL_MINUTES NUMBER(4,0);


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.1','001','001_ALTER_INTERVAL_MINUTES_DATATYPE');

COMMIT;