
CREATE TABLE APP_MISSING_INFO_STG 
(
  MISSING_INFO_ID NUMBER(18, 0) NOT NULL 
, APPLICATION_ID NUMBER(18, 0) 
, APP_INDIVIDUAL_ID NUMBER(18, 0) 
, REPORTED_DATE DATE 
, NOTIFICATION_DATE DATE 
, SATISFIED_DATE DATE 
, CALL_RECORD_ID NUMBER(18, 0) 
, CREATE_TS DATE 
, CREATED_BY VARCHAR2(50 BYTE) 
, UPDATE_TS DATE 
, UPDATED_BY VARCHAR2(50 BYTE) 
, MI_SOURCE_CD VARCHAR2(32 BYTE) 
, SATISFIED_MEDIA_CD VARCHAR2(32 BYTE) 
, MI_TYPE_CD VARCHAR2(32 BYTE) 
, NOTE_REF_ID NUMBER(18, 0) 
, ENTITY_NAME VARCHAR2(50 BYTE) 
, CLIENT_ID NUMBER(18, 0) 
, SATISFIED_REASON_CD VARCHAR2(32 BYTE) 
, STATUS_CD VARCHAR2(32 BYTE) 
, SATISFIED_BY VARCHAR2(50 BYTE) 
, VOIDED_BY VARCHAR2(50 BYTE) 
, VOIDED_DATE DATE 
, EXT_REF_ID VARCHAR2(256 BYTE) 
, DUE_DATE DATE 
) TABLESPACE MAXDAT_DATA;

COMMENT ON TABLE APP_MISSING_INFO_STG IS 'Application missing information records';
COMMENT ON COLUMN APP_MISSING_INFO_STG.MISSING_INFO_ID IS 'Missing information record internal ID';
COMMENT ON COLUMN APP_MISSING_INFO_STG.APPLICATION_ID IS 'Application ID (Primary Key), uniquely identifies an application.';
COMMENT ON COLUMN APP_MISSING_INFO_STG.APP_INDIVIDUAL_ID IS 'Application member ID (Primary Key)';
COMMENT ON COLUMN APP_MISSING_INFO_STG.REPORTED_DATE IS 'The date this MI was reported / discovered';
COMMENT ON COLUMN APP_MISSING_INFO_STG.SATISFIED_DATE IS 'The date this MI got satisfied';
COMMENT ON COLUMN APP_MISSING_INFO_STG.MI_TYPE_CD IS 'missing information type code';
COMMENT ON COLUMN APP_MISSING_INFO_STG.ENTITY_NAME IS 'The name of the entity associated with this MI. For example, the employer name for an income type MI.';
COMMENT ON COLUMN APP_MISSING_INFO_STG.CLIENT_ID IS 'internal client id';
COMMENT ON COLUMN APP_MISSING_INFO_STG.SATISFIED_REASON_CD IS 'MI satisfied reason code';
COMMENT ON COLUMN APP_MISSING_INFO_STG.STATUS_CD IS 'status of the MI record (pending, confirmed, voided)';
COMMENT ON COLUMN APP_MISSING_INFO_STG.SATISFIED_BY IS 'staff member that entered the satisified reason';
COMMENT ON COLUMN APP_MISSING_INFO_STG.VOIDED_BY IS 'staff member that entered the voided satisified reason';
COMMENT ON COLUMN APP_MISSING_INFO_STG.VOIDED_DATE IS 'date the voided satisified reason entered';
COMMENT ON COLUMN APP_MISSING_INFO_STG.EXT_REF_ID IS 'External Reference, to facilitate state matching and updating';

CREATE INDEX XIAPP_MI_APPID ON APP_MISSING_INFO_STG (APPLICATION_ID ASC) TABLESPACE MAXDAT_INDX;
CREATE INDEX XIAPP_MI_APPINDVID ON APP_MISSING_INFO_STG (APP_INDIVIDUAL_ID ASC) TABLESPACE MAXDAT_INDX;
CREATE UNIQUE INDEX XPKAPP_MISSING_INFO_STG ON APP_MISSING_INFO_STG (MISSING_INFO_ID ASC)  TABLESPACE MAXDAT_INDX;


GRANT SELECT ON APP_MISSING_INFO_STG TO MAXDAT_READ_ONLY;


insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPMI_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_missing_info.create_ts from the previous run. create_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPMI_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_missing_info.update_ts from the previous run. update_ts of the most recent app header record from the previous run.',sysdate,sysdate);

commit;