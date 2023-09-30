insert into cc_s_agent(AGENT_ID,LOGIN_ID,FIRST_NAME,LAST_NAME,MIDDLE_INITIAL,JOB_TITLE,LANGUAGE,HOURLY_RATE,RATE_CURRENCY,AGENT_GROUP,EXTRACT_DT,RECORD_EFF_DT,RECORD_END_DT,SITE_NAME,PROJECT_NAME,PROGRAM_NAME)
values(0,'0','Unknown','Unknown','Unknown','Unknown','Unknown',0,'USD','Unknown',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'),'Unknown','Unknown','Unknown');

update cc_s_agent
set project_name='TX Enrollment Broker'
where project_name='Enrollment Broker';

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.9','110','110_INSERT_CC_S_AGENT_unknown');

commit;