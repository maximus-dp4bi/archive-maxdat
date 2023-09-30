alter table cc_s_call_detail add (TIME_OUT_CALL number(1) default 0);

alter table cc_s_call_detail add (CALL_TYPE_ID number);

alter table cc_s_call_detail add (TIME_TO_AGENT number);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.3.0','001','001_ALTER_CC_S_DETAIL');


COMMIT;