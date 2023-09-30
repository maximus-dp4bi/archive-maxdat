
alter table CC_S_ACD_INTERVAL
disable constraint CC_S_ACD_INTRVL_CC_S_AGENT_FK;

update CC_S_ACD_INTERVAL
set agent_id=805
where agent_id=793;

commit;

update cc_s_agent
set agent_id=805
where login_id='EBA';

commit;

alter table CC_S_ACD_INTERVAL
enable constraint CC_S_ACD_INTRVL_CC_S_AGENT_FK;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.9','123','123_FIX_UPDATE_AGENT_ID_FOR_EBA_AGENT');

commit;