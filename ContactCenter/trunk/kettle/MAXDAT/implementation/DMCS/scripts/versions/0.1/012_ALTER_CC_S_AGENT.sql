alter table cc_s_agent add site_description varchar2(200) null;

alter table cc_s_agent modify site_description not null;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1','012','012_ALTER_CC_S_AGENT');

commit;