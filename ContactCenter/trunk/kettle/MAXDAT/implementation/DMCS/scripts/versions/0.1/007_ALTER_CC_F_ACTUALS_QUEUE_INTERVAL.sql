ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY (MAX_HANDLE_TIME NUMBER(8,2),MAX_SPEED_TO_HANDLE NUMBER(8,2));

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.1','007','007_ALTER_CC_F_ACTUALS_QUEUE_INTERVAL');

COMMIT;