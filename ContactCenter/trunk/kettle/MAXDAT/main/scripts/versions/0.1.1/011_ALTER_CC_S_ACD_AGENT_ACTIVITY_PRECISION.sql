INSERT into CC_L_PATCH_LOG (     PATCH_VERSION , 
     SCRIPT_SEQUENCE , 
     SCRIPT_NAME)values ('0.1.1','011','011_ALTER_CC_S_ACD_AGENT_ACTIVITY_PRECISION');


ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (LOGIN_SECONDS NUMBER(10, 2) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (EXTERNAL_SECONDS NUMBER(10, 2) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (INTERNAL_SECONDS NUMBER(10, 2) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (IDLE_SECONDS NUMBER(10, 2) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (NOT_READY_SECONDS NUMBER(10, 2) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (ACD_TALK_SECONDS NUMBER(10, 2) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (HOLD_SECONDS NUMBER(10, 2) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (AFTER_CALL_WORK_SECONDS NUMBER(10, 2) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (TALK_RESERVE_SECONDS NUMBER(10, 2) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (RING_SECONDS NUMBER(10, 2) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (PREDICTIVE_TALK_SECONDS NUMBER(10, 2) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (PREVIEW_TALK_SECONDS NUMBER(10, 2) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (ACD_CALLS_COUNT NUMBER(10, 0) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (EXTERNAL_CALLS_COUNT NUMBER(10, 0) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (INTERNAL_CALLS_COUNT NUMBER(10, 0) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (PREDICTIVE_CALLS_COUNT NUMBER(10, 0) );

ALTER TABLE CC_S_ACD_AGENT_ACTIVITY  
MODIFY (PREVIEW_CALLS_COUNT NUMBER(10, 0) );

commit;