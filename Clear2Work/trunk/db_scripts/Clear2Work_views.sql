-- create view for CLEAR2WORK_BADGE
CREATE OR REPLACE VIEW CLEAR2WORK_BADGE_SV
AS 
SELECT
    DATE_TIME,
    EVENT_USER,
    CREDENTIAL_ID,
    MAX_ID,
    SITE_NAME,
    DOOR_DEVICE,
    BADGE_DATE,
	TO_DATE(SUBSTR(DATE_TIME,1,LENGTH(TRIM(DATE_TIME))-4),'MM/DD/YY HH:MI:SS AM') BADGE_DT
FROM CLEAR2WORK_BADGE bdg
WHERE BADGE_DATE  >= TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD') 
		             - (SELECT TO_NUMBER(COALESCE(MAX(PARAM_VALUE),'2000'))
                        FROM CLEAR2WORK_GLOBAL_CONFIG gc
                        WHERE gc.PARAM_KEY = 'BADGE_VIEW_DATA_DAYS')
AND NOT EXISTS (SELECT 1 
				FROM CLEAR2WORK_GLOBAL_CONFIG gc
				WHERE gc.PARAM_KEY = 'SKIP_BADGE_RECS_FOR_VACCINATED'
				AND gc.PARAM_VALUE = 'Y')
UNION
SELECT
    DATE_TIME,
    EVENT_USER,
    CREDENTIAL_ID,
    MAX_ID,
    SITE_NAME,
    DOOR_DEVICE,
    BADGE_DATE,
	TO_DATE(SUBSTR(DATE_TIME,1,LENGTH(TRIM(DATE_TIME))-4),'MM/DD/YY HH:MI:SS AM') BADGE_DT
FROM CLEAR2WORK_BADGE bdg
WHERE BADGE_DATE  >= TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD') 
		             - (SELECT TO_NUMBER(COALESCE(MAX(PARAM_VALUE),'2000'))
                        FROM CLEAR2WORK_GLOBAL_CONFIG gc
                        WHERE gc.PARAM_KEY = 'BADGE_VIEW_DATA_DAYS')
AND EXISTS (SELECT 1 
			FROM CLEAR2WORK_GLOBAL_CONFIG gc
			WHERE gc.PARAM_KEY = 'SKIP_BADGE_RECS_FOR_VACCINATED'
			AND gc.PARAM_VALUE = 'Y')
AND NOT EXISTS (SELECT 1 
				FROM CLEAR2WORK_SURVEY srvy
				WHERE srvy.EMP_ID = bdg.MAX_ID
				AND srvy.EMP_LATEST_SURVEY = 'Y'
				AND srvy.CLEAR_IND = '1')
WITH READ ONLY;

-- grant select on the view 
GRANT SELECT ON CLEAR2WORK_BADGE_SV to MOTS_READ_ONLY;

-- create view for CLEAR2WORK_BADGE
CREATE OR REPLACE VIEW CLEAR2WORK_BADGE_USERENTRY_SV
AS 
SELECT
    bdg.DATE_TIME,
    bdg.EVENT_USER,
	nmap.FULL_NAME,
	nmap.FIRST_NAME,
	nmap.LAST_NAME,
    bdg.CREDENTIAL_ID,
    bdg.MAX_ID,
    bdg.SITE_NAME,
    bdg.DOOR_DEVICE,
    bdg.BADGE_DATE,
	TO_DATE(SUBSTR(bdg.DATE_TIME,1,LENGTH(TRIM(bdg.DATE_TIME))-4),'MM/DD/YY HH:MI:SS AM') BADGE_DT
FROM CLEAR2WORK_BADGE bdg
     LEFT JOIN CLEAR2WORK_EVENTUSER_NAME_MAP nmap
	   ON bdg.EVENT_USER = nmap.EVENT_USER
WHERE bdg.EVENT_USER LIKE 'User Entry:%'
AND bdg.MAX_ID <> ' '
AND bdg.EVENT_USER NOT LIKE '% - %'
AND bdg.BADGE_DATE  >= TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD') 
		             - (SELECT TO_NUMBER(COALESCE(MAX(PARAM_VALUE),'2000'))
                        FROM CLEAR2WORK_GLOBAL_CONFIG gc
                        WHERE gc.PARAM_KEY = 'BADGE_VIEW_DATA_DAYS')
AND NOT EXISTS (SELECT 1 
				FROM CLEAR2WORK_GLOBAL_CONFIG gc
				WHERE gc.PARAM_KEY = 'SKIP_BADGE_RECS_FOR_VACCINATED'
				AND gc.PARAM_VALUE = 'Y')
UNION
SELECT
    bdg.DATE_TIME,
    bdg.EVENT_USER,
    nmap.FULL_NAME,
	nmap.FIRST_NAME,
	nmap.LAST_NAME,
    bdg.CREDENTIAL_ID,
    bdg.MAX_ID,
    bdg.SITE_NAME,
    bdg.DOOR_DEVICE,
    bdg.BADGE_DATE,
	TO_DATE(SUBSTR(bdg.DATE_TIME,1,LENGTH(TRIM(bdg.DATE_TIME))-4),'MM/DD/YY HH:MI:SS AM') BADGE_DT
FROM CLEAR2WORK_BADGE bdg
     LEFT JOIN CLEAR2WORK_EVENTUSER_NAME_MAP nmap
	   ON bdg.EVENT_USER = nmap.EVENT_USER
WHERE bdg.EVENT_USER LIKE 'User Entry:%'
AND bdg.MAX_ID <> ' '
AND bdg.EVENT_USER NOT LIKE '% - %'
AND bdg.BADGE_DATE  >= TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD') 
		             - (SELECT TO_NUMBER(COALESCE(MAX(PARAM_VALUE),'2000'))
                        FROM CLEAR2WORK_GLOBAL_CONFIG gc
                        WHERE gc.PARAM_KEY = 'BADGE_VIEW_DATA_DAYS')
AND EXISTS (SELECT 1 
			FROM CLEAR2WORK_GLOBAL_CONFIG gc
			WHERE gc.PARAM_KEY = 'SKIP_BADGE_RECS_FOR_VACCINATED'
			AND gc.PARAM_VALUE = 'Y')
AND NOT EXISTS (SELECT 1 
				FROM CLEAR2WORK_SURVEY srvy
				WHERE srvy.EMP_ID = bdg.MAX_ID
				AND srvy.EMP_LATEST_SURVEY = 'Y'
				AND srvy.CLEAR_IND = '1')
WITH READ ONLY;

-- grant select on the view 
GRANT SELECT ON CLEAR2WORK_BADGE_USERENTRY_SV to MOTS_READ_ONLY;

-- create view for CLEAR2WORK_BADGE - NON EMPLOYEES
CREATE OR REPLACE VIEW C2W_BADGE_USERENTRY_NONEMP_SV
AS
  SELECT
    bdg.DATE_TIME,
    bdg.EVENT_USER,
	nmap.FULL_NAME,
	nmap.FIRST_NAME,
	nmap.LAST_NAME,
    bdg.CREDENTIAL_ID,
    bdg.MAX_ID,
    bdg.SITE_NAME,
    bdg.DOOR_DEVICE,
    bdg.BADGE_DATE
FROM CLEAR2WORK_BADGE bdg
LEFT JOIN CLEAR2WORK_EVENTUSER_NAME_MAP nmap ON bdg.EVENT_USER = nmap.EVENT_USER
WHERE bdg.EVENT_USER LIKE 'User Entry:%'
AND bdg.MAX_ID = ' '
AND bdg.BADGE_DATE  >= TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD') 
		             - (SELECT TO_NUMBER(COALESCE(MAX(PARAM_VALUE),'2000'))
                        FROM CLEAR2WORK_GLOBAL_CONFIG gc
                        WHERE gc.PARAM_KEY = 'BADGE_VIEW_DATA_DAYS')

WITH READ ONLY;

-- grant select on the view
GRANT SELECT ON C2W_BADGE_USERENTRY_NONEMP_SV TO MOTS_READ_ONLY;

-- create view for CLEAR2WORK_SURVEY
CREATE OR REPLACE VIEW CLEAR2WORK_SURVEY_SV
AS 
SELECT
   ASSIGNEE_ID,
   TO_CHAR(TO_DATE(SUBSTR(LTRIM(RTRIM(SUBMISSION_TIME)),1,19),'YYYY-MM-DD HH24:MI:SS'),'MON DD, YYYY HH:MI:SS AM') AS SUBMISSION_TIME,
   EMP_ID,
   SITE_NAME,
   CLEAR_IND,
   NOT_CLEAR_IND,
   ASSIGNEE_NAME,
   ABOUT_USER_ID,
   ABOUT_USER_NAME,
   TO_CHAR(TO_DATE(SUBSTR(LTRIM(RTRIM(START_TIME)),1,19),'YYYY-MM-DD HH24:MI:SS'),'MON DD, YYYY HH:MI:SS AM') AS START_TIME,
   COMPLETED_BY_USER_ID,
   COMPLETED_BY_USER_NAME
FROM CLEAR2WORK_SURVEY
WHERE SURVEY_DATE >= TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'),'YYYY-MM-DD')
		             - (SELECT TO_NUMBER(COALESCE(MAX(PARAM_VALUE),'2000'))
                        FROM CLEAR2WORK_GLOBAL_CONFIG gc
                        WHERE gc.PARAM_KEY = 'SURVEY_VIEW_DATA_DAYS')
WITH READ ONLY;

-- grant select on the view 
GRANT SELECT ON CLEAR2WORK_SURVEY_SV to MOTS_READ_ONLY;

-- create view for CLEAR2WORK_SITE
CREATE OR REPLACE VIEW CLEAR2WORK_SITE_SV
AS 
SELECT
   SITE_NAME,
   CLEAR2WORK_SITE,  
   BRIVO_SITE, 
   SITE_GROUP, 
   DIVISION
FROM CLEAR2WORK_SITE
WITH READ ONLY;

-- grant select on the view 
GRANT SELECT ON CLEAR2WORK_SITE_SV to MOTS_READ_ONLY;
 
/