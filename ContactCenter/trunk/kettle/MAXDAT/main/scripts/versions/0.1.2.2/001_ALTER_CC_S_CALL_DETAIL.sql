ALTER TABLE CC_S_CALL_DETAIL  
MODIFY (ANI_PHONE_NUMBER VARCHAR2(200 BYTE) );

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) VALUES ('0.1.2.2','101','001_ALTER_CALL_DETAIL');

COMMIT;
