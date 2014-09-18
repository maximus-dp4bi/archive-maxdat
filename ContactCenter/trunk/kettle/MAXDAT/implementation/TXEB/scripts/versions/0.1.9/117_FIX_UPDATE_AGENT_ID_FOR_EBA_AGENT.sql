alter table CC_S_ACD_INTERVAL
disable constraint CC_S_ACD_INTRVL_CC_S_AGENT_FK;

update CC_S_ACD_INTERVAL
set agent_id=793
where agent_id=0;

commit;

update cc_s_agent
set agent_id=793
where login_id='EBA';

commit;

alter table CC_S_ACD_INTERVAL
enable constraint CC_S_ACD_INTRVL_CC_S_AGENT_FK;

insert into cc_s_agent(AGENT_ID,LOGIN_ID,PROJECT_CONFIG_ID,FIRST_NAME,LAST_NAME,MIDDLE_INITIAL,JOB_TITLE,LANGUAGE,HOURLY_RATE,RATE_CURRENCY,AGENT_GROUP,RECORD_EFF_DT,RECORD_END_DT,SITE_NAME)
values(0,'0',0,'Unknown','Unknown','Unknown','Unknown','Unknown',0,'USD','Unknown',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'),'Unknown');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.9','117','117_FIX_UPDATE_AGENT_ID_FOR_EBA_AGENT');

commit;