alter table CC_C_CONTACT_QUEUE
add (INTERVAL_MINUTES Number(*,0));

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.3','101','101_ALTER_TABLE_ADD_INTERVAL_MINUTES');

commit;