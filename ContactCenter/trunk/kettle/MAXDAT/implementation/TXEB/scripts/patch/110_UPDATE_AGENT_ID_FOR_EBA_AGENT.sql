update CC_S_ACD_AGENT_ACTIVITY
set agent_id=793
where agent_id=0;

alter table CC_S_ACD_INTERVAL
disable constraint CC_S_ACD_INTRVL_CC_S_AGENT_FK;

update CC_S_ACD_INTERVAL
set agent_id=793
where agent_id=0;

commit;

update CC_S_AGENT_ABSENCE
set agent_id=793
where agent_id=0;

update CC_S_AGENT_SUPERVISOR
set agent_id=793
where agent_id=0;

update CC_S_AGENT_WORK_DAY
set agent_id=793
where agent_id=0;

update CC_S_CALL_DETAIL
set agent_id=793
where agent_id=0;

update CC_S_WFM_AGENT_ACTIVITY
set agent_id=793
where agent_id=0;

update cc_s_agent
set agent_id=793
where login_id='EBA';

commit;

alter table CC_S_ACD_INTERVAL
enable constraint CC_S_ACD_INTRVL_CC_S_AGENT_FK;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.9','110','110_UPDATE_AGENT_ID_FOR_EBA_AGENT');

commit;