-- increase the size of the 'Message' field in CC_L_ERROR
alter table cc_l_error
modify (message varchar2(4000));

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.6.0','001','001_ALTER_CC_L_ERROR');

COMMIT;
