ALTER TABLE CC_S_TMP_CISCO_C_T_INTERVAL ADD (
	RETURNRING NUMBER
	, INCOMPLETECALLS NUMBER
);

  
INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
  VALUES ('0.1.6','001','001_ALTER_CC_S_TMP_CISCO_C_T_INTERVAL');
 
COMMIT;