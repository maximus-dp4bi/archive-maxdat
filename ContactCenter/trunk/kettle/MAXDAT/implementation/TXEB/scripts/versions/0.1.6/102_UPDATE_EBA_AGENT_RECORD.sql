UPDATE CC_S_AGENT
SET FIRST_NAME = 'Enrollment Broker'
  , LAST_NAME = 'Agents'
  , MIDDLE_INITIAL = 'EB'
  , JOB_TITLE = 'Unknown'
  , LANGUAGE = 'Unknown'
  , SITE_NAME = 'Unknown'
  , HOURLY_RATE = 0
  , RATE_CURRENCY = 'USD'
  , AGENT_GROUP = 'Unknown'
WHERE LOGIN_ID = 'EBA';

UPDATE CC_D_AGENT
SET FIRST_NAME = 'Enrollment Broker'
  , LAST_NAME = 'Agents'
  , MIDDLE_INITIAL = 'EB'
  , JOB_TITLE = 'Unknown'
  , LANGUAGE = 'Unknown'
  , SITE_NAME = 'Unknown'
  , HOURLY_RATE = 0
  , RATE_CURRENCY = 'USD'
  , VERSION = 1
WHERE LOGIN_ID = 'EBA';

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.1.6','102','102_UPDATE_EBA_AGENT_RECORD');

COMMIT;