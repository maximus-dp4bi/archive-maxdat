CREATE TABLE S_TMP_F_METRIC_CALCS
  ( 
	F_METRIC_ID NUMBER (19) NOT NULL
  ) ;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.4','002','002_ADD_S_TMP_F_METRIC_CALCS');
  
COMMIT;