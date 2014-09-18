
--UPDATE CC_S_AGENT records with Site Name via CC_C_LOOKUP table
UPDATE CC_S_AGENT a
SET SITE_NAME = 
  COALESCE((SELECT LOOKUP_VALUE
   FROM CC_C_LOOKUP l
   WHERE l.LOOKUP_TYPE = 'WFM_ORG_SITE'
   AND l.LOOKUP_KEY = a.AGENT_GROUP), 'Unknown');
   
--UPDATE CC_D_AGENT records with value from current S_AGENT record   
UPDATE CC_D_AGENT a
SET SITE_NAME = 
  COALESCE((SELECT stgAgent.SITE_NAME
            FROM CC_S_AGENT stgAgent 
            WHERE a.LOGIN_ID = stgAgent.LOGIN_ID
            AND stgagent.AGENT_ID =
              (SELECT MAX(s.AGENT_ID)
                FROM CC_S_AGENT s
                WHERE s.LOGIN_ID = stgAgent.LOGIN_ID)), 'Unknown');

--CREATE CC_D_SITE RECORDS
INSERT INTO CC_D_SITE (SITE_NAME, VERSION, RECORD_EFF_DT, RECORD_END_DT)
    SELECT DISTINCT
       cl.LOOKUP_VALUE AS SITE_NAME,
       1 AS VERSION,
       to_date('1900-01-01 00:00:00','yyyy-MM-dd HH24:mi:ss') AS RECORD_EFF_DT,
       to_date('2199-12-31 23:59:59','yyyy-MM-dd HH24:mi:ss') AS RECORD_END_DT
    FROM CC_C_LOOKUP cl
	WHERE cl.LOOKUP_TYPE = 'WFM_ORG_SITE'
	and lookup_value!='Austin';
				
--UPDATE CC_F_AGENT_BY_DATE records with correct D_SITE_ID
UPDATE CC_F_AGENT_BY_DATE abd
SET D_SITE_ID = 
  COALESCE(
  (SELECT ds.D_SITE_ID
   FROM CC_D_AGENT da
   INNER JOIN CC_D_SITE ds on da.SITE_NAME = ds.SITE_NAME
   WHERE da.D_AGENT_ID = abd.D_AGENT_ID), 0);

--UPDATE CC_F_AGENT_ACTIVITY_BY_DATE records with correct D_SITE_ID   
UPDATE CC_F_AGENT_ACTIVITY_BY_DATE aabd
SET D_SITE_ID = 
  COALESCE(
  (SELECT ds.D_SITE_ID
   FROM CC_D_AGENT da
   INNER JOIN CC_D_SITE ds on da.SITE_NAME = ds.SITE_NAME
   WHERE da.D_AGENT_ID = aabd.D_AGENT_ID), 0);
   
INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.2.1','102','102_UPDATE_SITE_NAMES');

COMMIT;