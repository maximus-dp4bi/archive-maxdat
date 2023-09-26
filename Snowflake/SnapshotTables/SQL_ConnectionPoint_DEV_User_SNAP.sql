CREATE OR REPLACE VIEW DECISIONPOINT_DEV.STAGE.LOAD_CP_USER_HISTORY_VW AS
SELECT
--DATABASE,
--TABLE_NAME,
LOG_CREATED_ON,
USER_ID,
USER_ACCOUNT_AUTHORIZATION,
ACCOUNT_AUTHORIZATION_DATE,
USER_ACCOUNT_TYPE,
END_DATE,
IS_OVERRIDE_AUTHORIZATION,
REASON_FOR_OVERRIDE_AUTHORIZATION,
PROJECT_ID,
REASON_ACCESS_PHI,
REASON_ACCESS_PII,
REQUIRE_ACCESS_PHI,
REQUIRE_ACCESS_PII,
STAFF_ID,
START_DATE,
USER_STATUS,
CISCO_AGENT_ID,
--TABLE,
OFFSET,
TYPE,
INACTIVATE_IMMEDIATELY,
UPDATED_BY,
UPDATED_ON,
USER_INACTIVATE_REASON,
USER_REACTIVATE_REASON,
CREATED_BY,
CREATED_ON,
UIID,
CORRELATION_ID,
TEAM_ID,
--APPLICATION_TYPE,
LOG_CREATED_ON_UTC,
UPDATED_ON_UTC,
CREATED_ON_UTC,
SF_PROCESSED,
LOGIN_EXPIRY_DATE,
LOG_CREATED_ON_DATETIME,

HASH(
LOG_CREATED_ON,
USER_ACCOUNT_AUTHORIZATION,
ACCOUNT_AUTHORIZATION_DATE,
USER_ACCOUNT_TYPE,
END_DATE,
IS_OVERRIDE_AUTHORIZATION,
REASON_FOR_OVERRIDE_AUTHORIZATION,
PROJECT_ID,
REASON_ACCESS_PHI,
REASON_ACCESS_PII,
REQUIRE_ACCESS_PHI,
REQUIRE_ACCESS_PII,
STAFF_ID,
START_DATE,
USER_STATUS,
CISCO_AGENT_ID,
OFFSET,
TYPE,
INACTIVATE_IMMEDIATELY,
UPDATED_BY,
UPDATED_ON,
USER_INACTIVATE_REASON,
USER_REACTIVATE_REASON,
CREATED_BY,
CREATED_ON,
UIID,
CORRELATION_ID,
TEAM_ID,
LOG_CREATED_ON_UTC,
UPDATED_ON_UTC,
CREATED_ON_UTC,
SF_PROCESSED,
LOGIN_EXPIRY_DATE,
LOG_CREATED_ON_DATETIME
) AS ROW_HASH,
SYSDATE() AS SNOWFLAKE_INSERT_DATETIME,
SYSDATE() AS SNOWFLAKE_UPDATE_DATETIME,
CAST(SYSDATE() AS DATE)-1 AS AS_OF_DATE,
'PI_USER_LOAD' AS SNOWFLAKE_INSERT_BY,
1 AS CURRENT_USER_RECORD
FROM MARS_DP4BI_PROD.MARSDB.MARSDB_USER 
--LIMIT 100
;

CREATE OR REPLACE TABLE DECISIONPOINT_DEV.STAGE.CP_USER_HISTORY AS SELECT * FROM DECISIONPOINT_DEV.STAGE.LOAD_CP_USER_HISTORY_VW WHERE 1=0;


SELECT 
--'src.' || COLUMN_NAME || ',',
--COLUMN_NAME || ',',
--'tgt.' || COLUMN_NAME || '=src.' || COLUMN_NAME || ',' 
* 
FROM SNOWFLAKE.ACCOUNT_USAGE.COLUMNS WHERE TABLE_CATALOG = 'DECISIONPOINT_DEV' AND TABLE_SCHEMA = 'STAGE' AND TABLE_NAME = 'LOAD_CP_USER_HISTORY_VW' --AND DELETED IS NULL 
ORDER BY ORDINAL_POSITION ASC;

SELECT COLUMN_NAME || ','
--'a.' || COLUMN_NAME || '=b.' || COLUMN_NAME || ',' 
FROM SNOWFLAKE.ACCOUNT_USAGE.COLUMNS WHERE TABLE_CATALOG = 'DECISIONPOINT_DEV' AND TABLE_SCHEMA = 'STAGE' AND TABLE_NAME = 'CP_USER_HISTORY' AND DELETED IS NULL ORDER BY ORDINAL_POSITION ASC;


SELECT MAX(LOG_CREATED_ON) LOG_CREATED_ON, MAX(UPDATED_ON) UPDATED_ON, MAX(CREATED_ON) CREATED_ON FROM DECISIONPOINT_DEV.STAGE.LOAD_CP_USER_HISTORY_VW;

SELECT * FROM DECISIONPOINT_DEV.STAGE.LOAD_CP_USER_HISTORY_VW WHERE LOG_CREATED_ON = '2022-08-26 02:11:35.000'

DESCRIBE TABLE DECISIONPOINT_DEV.STAGE.CP_USER_HISTORY;
SELECT * FROM DECISIONPOINT_DEV.STAGE.CP_USER_HISTORY;

CREATE OR REPLACE PROCEDURE DECISIONPOINT_DEV.STAGE.LOAD_CP_USER_HISTORY_PROC(PROJECTID varchar,REINGESTFLAG BOOLEAN,RUNFROMBASHFLAG BOOLEAN
                                                                             ) 
returns varchar not null
language sql
AS
--declare 
declare environment varchar;                
        tempTableName varchar default 'LOAD_CP_USER_HIST_TEMP';
        tgtTableName varchar default 'CP_USER_HISTORY';
        srcTableName varchar default 'LOAD_CP_USER_HISTORY_VW';
        tempTableText varchar;
        mergeInsertUpdate varchar;
        mergeCloseCurrent varchar;
                
BEGIN 
                
SELECT CURRENT_DATABASE() || '.' || CURRENT_SCHEMA() || '.' INTO :environment;
      
tempTableText:= 'CREATE OR REPLACE TEMPORARY TABLE ' || :environment || :tempTableName || ' AS SELECT a.*, b.ROW_HASH TGT_ROW_HASH, b.AS_OF_DATE TGT_AS_OF_DATE FROM ' || :environment || :srcTableName || ' a 
              LEFT JOIN ' || :environment || :tgtTableName || ' b ON a.USER_ID = b.USER_ID AND b.CURRENT_USER_RECORD = 1 
             WHERE (a.ROW_HASH != b.ROW_HASH OR a.AS_OF_DATE = b.AS_OF_DATE OR b.USER_ID IS NULL)' || CASE WHEN TRY_TO_NUMBER(:PROJECTID) IS NULL THEN '' ELSE ' AND a.PROJECTID =' || :PROJECTID END;


mergeInsertUpdate:= 'MERGE INTO ' || :environment || :tgtTableName || ' tgt USING (SELECT * FROM ' || :environment || :tempTableName || ') src ON (tgt.USER_ID = src.USER_ID AND tgt.PROJECT_ID = src.PROJECT_ID AND tgt.AS_OF_DATE = src.AS_OF_DATE AND tgt.CURRENT_USER_RECORD = 1) 
            WHEN MATCHED THEN UPDATE SET
tgt.LOG_CREATED_ON=src.LOG_CREATED_ON,
tgt.USER_ACCOUNT_AUTHORIZATION=src.USER_ACCOUNT_AUTHORIZATION,
tgt.ACCOUNT_AUTHORIZATION_DATE=src.ACCOUNT_AUTHORIZATION_DATE,
tgt.USER_ACCOUNT_TYPE=src.USER_ACCOUNT_TYPE,
tgt.END_DATE=src.END_DATE,
tgt.IS_OVERRIDE_AUTHORIZATION=src.IS_OVERRIDE_AUTHORIZATION,
tgt.REASON_FOR_OVERRIDE_AUTHORIZATION=src.REASON_FOR_OVERRIDE_AUTHORIZATION,
tgt.REASON_ACCESS_PHI=src.REASON_ACCESS_PHI,
tgt.REASON_ACCESS_PII=src.REASON_ACCESS_PII,
tgt.REQUIRE_ACCESS_PHI=src.REQUIRE_ACCESS_PHI,
tgt.REQUIRE_ACCESS_PII=src.REQUIRE_ACCESS_PII,
tgt.STAFF_ID=src.STAFF_ID,
tgt.START_DATE=src.START_DATE,
tgt.USER_STATUS=src.USER_STATUS,
tgt.CISCO_AGENT_ID=src.CISCO_AGENT_ID,
tgt.OFFSET=src.OFFSET,
tgt.TYPE=src.TYPE,
tgt.INACTIVATE_IMMEDIATELY=src.INACTIVATE_IMMEDIATELY,
tgt.UPDATED_BY=src.UPDATED_BY,
tgt.UPDATED_ON=src.UPDATED_ON,
tgt.USER_INACTIVATE_REASON=src.USER_INACTIVATE_REASON,
tgt.USER_REACTIVATE_REASON=src.USER_REACTIVATE_REASON,
tgt.CREATED_BY=src.CREATED_BY,
tgt.CREATED_ON=src.CREATED_ON,
tgt.UIID=src.UIID,
tgt.CORRELATION_ID=src.CORRELATION_ID,
tgt.TEAM_ID=src.TEAM_ID,
tgt.LOG_CREATED_ON_UTC=src.LOG_CREATED_ON_UTC,
tgt.UPDATED_ON_UTC=src.UPDATED_ON_UTC,
tgt.CREATED_ON_UTC=src.CREATED_ON_UTC,
tgt.SF_PROCESSED=src.SF_PROCESSED,
tgt.LOGIN_EXPIRY_DATE=src.LOGIN_EXPIRY_DATE,
tgt.LOG_CREATED_ON_DATETIME=src.LOG_CREATED_ON_DATETIME,
tgt.ROW_HASH=src.ROW_HASH,
tgt.SNOWFLAKE_INSERT_DATETIME=src.SNOWFLAKE_INSERT_DATETIME,
tgt.SNOWFLAKE_UPDATE_DATETIME=src.SNOWFLAKE_UPDATE_DATETIME,
tgt.AS_OF_DATE=src.AS_OF_DATE,
tgt.SNOWFLAKE_INSERT_BY=src.SNOWFLAKE_INSERT_BY,
tgt.CURRENT_USER_RECORD=src.CURRENT_USER_RECORD
            WHEN NOT MATCHED AND src.TGT_ROW_HASH != src.ROW_HASH OR src.TGT_ROW_HASH IS NULL THEN INSERT (
LOG_CREATED_ON,
USER_ID,
USER_ACCOUNT_AUTHORIZATION,
ACCOUNT_AUTHORIZATION_DATE,
USER_ACCOUNT_TYPE,
END_DATE,
IS_OVERRIDE_AUTHORIZATION,
REASON_FOR_OVERRIDE_AUTHORIZATION,
PROJECT_ID,
REASON_ACCESS_PHI,
REASON_ACCESS_PII,
REQUIRE_ACCESS_PHI,
REQUIRE_ACCESS_PII,
STAFF_ID,
START_DATE,
USER_STATUS,
CISCO_AGENT_ID,
OFFSET,
TYPE,
INACTIVATE_IMMEDIATELY,
UPDATED_BY,
UPDATED_ON,
USER_INACTIVATE_REASON,
USER_REACTIVATE_REASON,
CREATED_BY,
CREATED_ON,
UIID,
CORRELATION_ID,
TEAM_ID,
LOG_CREATED_ON_UTC,
UPDATED_ON_UTC,
CREATED_ON_UTC,
SF_PROCESSED,
LOGIN_EXPIRY_DATE,
LOG_CREATED_ON_DATETIME,
ROW_HASH,
SNOWFLAKE_INSERT_DATETIME,
SNOWFLAKE_UPDATE_DATETIME,
AS_OF_DATE,
SNOWFLAKE_INSERT_BY,
CURRENT_USER_RECORD) values(
   src.LOG_CREATED_ON,
src.USER_ID,
src.USER_ACCOUNT_AUTHORIZATION,
src.ACCOUNT_AUTHORIZATION_DATE,
src.USER_ACCOUNT_TYPE,
src.END_DATE,
src.IS_OVERRIDE_AUTHORIZATION,
src.REASON_FOR_OVERRIDE_AUTHORIZATION,
src.PROJECT_ID,
src.REASON_ACCESS_PHI,
src.REASON_ACCESS_PII,
src.REQUIRE_ACCESS_PHI,
src.REQUIRE_ACCESS_PII,
src.STAFF_ID,
src.START_DATE,
src.USER_STATUS,
src.CISCO_AGENT_ID,
src.OFFSET,
src.TYPE,
src.INACTIVATE_IMMEDIATELY,
src.UPDATED_BY,
src.UPDATED_ON,
src.USER_INACTIVATE_REASON,
src.USER_REACTIVATE_REASON,
src.CREATED_BY,
src.CREATED_ON,
src.UIID,
src.CORRELATION_ID,
src.TEAM_ID,
src.LOG_CREATED_ON_UTC,
src.UPDATED_ON_UTC,
src.CREATED_ON_UTC,
src.SF_PROCESSED,
src.LOGIN_EXPIRY_DATE,
src.LOG_CREATED_ON_DATETIME,
src.ROW_HASH,
src.SNOWFLAKE_INSERT_DATETIME,
src.SNOWFLAKE_UPDATE_DATETIME,
src.AS_OF_DATE,
src.SNOWFLAKE_INSERT_BY,
src.CURRENT_USER_RECORD)' ;                


mergeCloseCurrent:= 'MERGE INTO ' || :environment || :tgtTableName || ' tgt USING (SELECT * FROM ' || :environment || :tempTableName || ') src ON (tgt.USER_ID = src.USER_ID AND tgt.PROJECT_ID = src.PROJECT_ID AND tgt.CURRENT_USER_RECORD = 1 AND src.TGT_AS_OF_DATE = tgt.AS_OF_DATE)
                WHEN MATCHED AND src.ROW_HASH != src.TGT_ROW_HASH AND src.TGT_ROW_HASH IS NOT NULL THEN UPDATE
                    SET SNOWFLAKE_UPDATE_DATETIME = src.SNOWFLAKE_UPDATE_DATETIME
                    ,   CURRENT_USER_RECORD = 0' ;                                

EXECUTE IMMEDIATE tempTableText;                


BEGIN TRANSACTION;

EXECUTE IMMEDIATE mergeInsertUpdate;
EXECUTE IMMEDIATE mergeCloseCurrent;
            
COMMIT;              
--RETURN mergeInsertUpdate;
  RETURN 'Success';
  --PROJECTID;
EXCEPTION
  WHEN OTHER THEN
  ROLLBACK;
  RETURN 'Error';                
--RETURN mergeInsertUpdate;
END;

CALL DECISIONPOINT_DEV.STAGE.LOAD_CP_USER_HISTORY_PROC('All',1,1);


MERGE INTO DECISIONPOINT_DEV.STAGE.CP_USER_HISTORY tgt USING (SELECT * FROM DECISIONPOINT_DEV.STAGE.LOAD_CP_USER_HIST_TEMP) src ON (tgt.USER_ID = src.USER_ID AND tgt.PROJECT_ID = src.PROJECT_ID AND tgt.AS_OF_DATE = src.AS_OF_DATE AND tgt.CURRENT_USER_RECORD = 1)              WHEN MATCHED THEN UPDATE SET tgt.LOG_CREATED_ON=src.LOG_CREATED_ON, tgt.USER_ACCOUNT_AUTHORIZATION=src.USER_ACCOUNT_AUTHORIZATION, tgt.ACCOUNT_AUTHORIZATION_DATE=src.ACCOUNT_AUTHORIZATION_DATE, tgt.USER_ACCOUNT_TYPE=src.USER_ACCOUNT_TYPE, tgt.END_DATE=src.END_DATE, tgt.IS_OVERRIDE_AUTHORIZATION=src.IS_OVERRIDE_AUTHORIZATION, tgt.REASON_FOR_OVERRIDE_AUTHORIZATION=src.REASON_FOR_OVERRIDE_AUTHORIZATION, tgt.REASON_ACCESS_PHI=src.REASON_ACCESS_PHI, tgt.REASON_ACCESS_PII=src.REASON_ACCESS_PII, tgt.REQUIRE_ACCESS_PHI=src.REQUIRE_ACCESS_PHI, tgt.REQUIRE_ACCESS_PII=src.REQUIRE_ACCESS_PII, tgt.STAFF_ID=src.STAFF_ID, tgt.START_DATE=src.START_DATE, tgt.USER_STATUS=src.USER_STATUS, tgt.CISCO_AGENT_ID=src.CISCO_AGENT_ID, tgt.OFFSET=src.OFFSET, tgt.TYPE=src.TYPE, tgt.INACTIVATE_IMMEDIATELY=src.INACTIVATE_IMMEDIATELY, tgt.UPDATED_BY=src.UPDATED_BY, tgt.UPDATED_ON=src.UPDATED_ON, tgt.USER_INACTIVATE_REASON=src.USER_INACTIVATE_REASON, tgt.USER_REACTIVATE_REASON=src.USER_REACTIVATE_REASON, tgt.CREATED_BY=src.CREATED_BY, tgt.CREATED_ON=src.CREATED_ON, tgt.UIID=src.UIID, tgt.CORRELATION_ID=src.CORRELATION_ID, tgt.TEAM_ID=src.TEAM_ID, tgt.LOG_CREATED_ON_UTC=src.LOG_CREATED_ON_UTC, tgt.UPDATED_ON_UTC=src.UPDATED_ON_UTC, tgt.CREATED_ON_UTC=src.CREATED_ON_UTC, tgt.SF_PROCESSED=src.SF_PROCESSED, tgt.LOGIN_EXPIRY_DATE=src.LOGIN_EXPIRY_DATE, tgt.LOG_CREATED_ON_DATETIME=src.LOG_CREATED_ON_DATETIME, tgt.ROW_HASH=src.ROW_HASH, tgt.SNOWFLAKE_INSERT_DATETIME=src.SNOWFLAKE_INSERT_DATETIME, tgt.SNOWFLAKE_UPDATE_DATETIME=src.SNOWFLAKE_UPDATE_DATETIME, tgt.AS_OF_DATE=src.AS_OF_DATE, tgt.SNOWFLAKE_INSERT_BY=src.SNOWFLAKE_INSERT_BY, tgt.CURRENT_USER_RECORD=src.CURRENT_USER_RECORD             WHEN NOT MATCHED AND src.TGT_ROW_HASH != src.ROW_HASH OR src.TGT_ROW_HASH IS NULL THEN INSERT ( LOG_CREATED_ON, USER_ID, USER_ACCOUNT_AUTHORIZATION, ACCOUNT_AUTHORIZATION_DATE, USER_ACCOUNT_TYPE, END_DATE, IS_OVERRIDE_AUTHORIZATION, REASON_FOR_OVERRIDE_AUTHORIZATION, PROJECT_ID, REASON_ACCESS_PHI, REASON_ACCESS_PII, REQUIRE_ACCESS_PHI, REQUIRE_ACCESS_PII, STAFF_ID, START_DATE, USER_STATUS, CISCO_AGENT_ID, OFFSET, TYPE, INACTIVATE_IMMEDIATELY, UPDATED_BY, UPDATED_ON, USER_INACTIVATE_REASON, USER_REACTIVATE_REASON, CREATED_BY, CREATED_ON, UIID, CORRELATION_ID, TEAM_ID, LOG_CREATED_ON_UTC, UPDATED_ON_UTC, CREATED_ON_UTC, SF_PROCESSED, LOGIN_EXPIRY_DATE, LOG_CREATED_ON_DATETIME, ROW_HASH, SNOWFLAKE_INSERT_DATETIME, SNOWFLAKE_UPDATE_DATETIME,AS_OF_DATE, SNOWFLAKE_INSERT_BY, CURRENT_USER_RECORD) values(src.LOG_CREATED_ON, src.USER_ID, src.USER_ACCOUNT_AUTHORIZATION, src.ACCOUNT_AUTHORIZATION_DATE, src.USER_ACCOUNT_TYPE, src.END_DATE, src.IS_OVERRIDE_AUTHORIZATION, src.REASON_FOR_OVERRIDE_AUTHORIZATION, src.PROJECT_ID, src.REASON_ACCESS_PHI, src.REASON_ACCESS_PII, src.REQUIRE_ACCESS_PHI, src.REQUIRE_ACCESS_PII, src.STAFF_ID, src.START_DATE, src.USER_STATUS, src.CISCO_AGENT_ID, src.OFFSET, src.TYPE, src.INACTIVATE_IMMEDIATELY, src.UPDATED_BY, src.UPDATED_ON, src.USER_INACTIVATE_REASON, src.USER_REACTIVATE_REASON, src.CREATED_BY, src.CREATED_ON, src.UIID, src.CORRELATION_ID, src.TEAM_ID, src.LOG_CREATED_ON_UTC, src.UPDATED_ON_UTC, src.CREATED_ON_UTC, src.SF_PROCESSED, src.LOGIN_EXPIRY_DATE, src.LOG_CREATED_ON_DATETIME, src.ROW_HASH, src.SNOWFLAKE_INSERT_DATETIME, src.SNOWFLAKE_UPDATE_DATETIME, src.AS_OF_DATE, src.SNOWFLAKE_INSERT_BY, src.CURRENT_USER_RECORD);