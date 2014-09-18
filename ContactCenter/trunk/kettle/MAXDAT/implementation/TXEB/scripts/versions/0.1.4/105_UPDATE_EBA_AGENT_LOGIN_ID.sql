UPDATE CC_S_AGENT
SET LOGIN_ID = 'EBA'
WHERE FIRST_NAME = 'Enrollment Broker Agents';

UPDATE CC_D_AGENT
SET LOGIN_ID = 'EBA'
WHERE FIRST_NAME = 'Enrollment Broker Agents';

UPDATE CC_D_AGENT
SET RECORD_EFF_DT = TO_DATE('1900-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
  , RECORD_END_DT = TO_DATE('2199-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
WHERE LOGIN_ID IN ('0', 'EBA');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.1.4','105','105_UPDATE_EBA_AGENT_LOGIN_ID');

COMMIT;