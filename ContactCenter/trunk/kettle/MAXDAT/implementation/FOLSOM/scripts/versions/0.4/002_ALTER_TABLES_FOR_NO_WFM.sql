ALTER SESSION SET CURRENT_SCHEMA = FOLSOM_SHARED_CC;

ALTER TABLE CC_S_AGENT MODIFY (AGENT_GROUP NULL);

ALTER TABLE CC_S_WFM_AGENT_ACTIVITY MODIFY (ACTIVITY_START_TIME NULL, ACTIVITY_END_TIME NULL);

ALTER TABLE CC_F_AGENT_BY_DATE MODIFY (D_GROUP_ID  NULL, D_SITE_ID NULL);

ALTER TABLE CC_F_AGENT_ACTIVITY_BY_DATE MODIFY (D_GROUP_ID  NULL, D_SITE_ID NULL);