
declare  c int;
begin
   select count(*) into c from user_tables where table_name ='INCIDENT_HISTORY_STG';
   if c = 1 then
      execute immediate 'drop table INCIDENT_HISTORY_STG cascade constraints';
   end if;
end;
/


CREATE TABLE MAXDAT.INCIDENT_HISTORY_STG
    (
      INCIDENT_HISTORY_ID NUMBER (18) NOT NULL
    , TRANSACTION_ID      NUMBER (18)
    , INCIDENT_HEADER_ID  NUMBER (18)
    , FIELD_REF_TYPE      VARCHAR2 (30)
    , FIELD               VARCHAR2 (30)
    , OLD_VALUE           VARCHAR2 (512)
    , NEW_VALUE           VARCHAR2 (512)
    , CREATED_BY          VARCHAR2 (80)
    , CREATE_TS           DATE
    , IH_DTL_DESC_EXT_ID  NUMBER (18)
    , CHILD_SL_NO         NUMBER (18),
    CONSTRAINT INCIDENT_HISTORY_PK PRIMARY KEY (INCIDENT_HISTORY_ID)
    )
    TABLESPACE MAXDAT_DATA
;

CREATE INDEX INCIDENT_HISTORY_IDX01
    ON MAXDAT.INCIDENT_HISTORY_STG (INCIDENT_HEADER_ID)
    TABLESPACE MAXDAT_INDX;

CREATE INDEX INCIDENT_HISTORY_IDX02
    ON MAXDAT.INCIDENT_HISTORY_STG (TRANSACTION_ID)
    TABLESPACE MAXDAT_INDX;


GRANT SELECT ON INCIDENT_HISTORY_STG TO MAXDAT_READ_ONLY;
GRANT SELECT ON INCIDENT_HISTORY_STG TO DP_SCORECARD;

CREATE OR REPLACE VIEW MAXDAT.INCIDENT_HISTORY_STG_SV
AS
SELECT 
      INCIDENT_HISTORY_ID 
    , TRANSACTION_ID      
    , INCIDENT_HEADER_ID  
    , FIELD_REF_TYPE      
    , FIELD               
    , OLD_VALUE           
    , NEW_VALUE           
    , CREATED_BY          
    , CREATE_TS           
    , IH_DTL_DESC_EXT_ID  
    , CHILD_SL_NO 
FROM MAXDAT.INCIDENT_HISTORY_STG
WITH READ ONLY;

GRANT SELECT ON INCIDENT_HISTORY_STG_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON INCIDENT_HISTORY_STG_SV TO DP_SCORECARD;



