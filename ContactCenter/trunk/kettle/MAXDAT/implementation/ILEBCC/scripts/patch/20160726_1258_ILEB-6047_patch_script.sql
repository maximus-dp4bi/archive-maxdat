-- Delete the data first

delete from CC_S_TMP_AVY_AGT_WORK_DAY;

delete from CC_S_TMP_AVY_AGT_EVENT_DETAIL;

delete from CC_S_TMP_AVY_AGENT;

COMMIT;


ALTER TABLE CC_S_TMP_AVY_AGT_WORK_DAY MODIFY (AGENT_ID VARCHAR2(50));

ALTER TABLE CC_S_TMP_AVY_AGT_EVENT_DETAIL MODIFY (AGENT_ID  VARCHAR2(50));

ALTER TABLE CC_S_TMP_AVY_AGENT MODIFY (TELSETLOGINID VARCHAR2(50));

COMMIT;