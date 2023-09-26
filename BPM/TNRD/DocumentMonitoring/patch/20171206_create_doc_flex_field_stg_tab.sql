CREATE TABLE doc_flex_field_stg
(DOCUMENT_SET_ID	NUMBER(18,0),
DOCUMENT_ID	NUMBER(18,0),
GROUP_TYPE	VARCHAR2(256),
GROUP_ID	VARCHAR2(256),
NAME	VARCHAR2(256),
VALUE	VARCHAR2(256),
TYPE	VARCHAR2(256),
CREATED_BY	VARCHAR2(80),
CREATE_TS	DATE,
UPDATED_BY	VARCHAR2(80),
UPDATE_TS	DATE,
DOC_FLEX_FIELD_ID	NUMBER(18,0)) TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX DOC_FLEX_FIELD_UK ON DOC_FLEX_FIELD_STG(DOC_FLEX_FIELD_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX01_DOC_FLEX_FIELD ON DOC_FLEX_FIELD_STG(NAME) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON DOC_FLEX_FIELD_STG to MAXDAT_READ_ONLY;

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DOCFLEX_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the doc_flex_field.create_ts from the previous run. creation_date of the most recent activity_details record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DOCFLEX_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the doc_flex_field.update_ts from the previous run. Last_update_date of the most recent activity_details record from the previous run.',sysdate,sysdate);

commit;

DROP index DMS_ACTIVITIES_STG_IDX1;
CREATE INDEX DMS_ACTIVITIES_STG_IDX1 ON dms_activities_stg(dcn) TABLESPACE MAXDAT_INDX;

CREATE INDEX DMSDOCUMENTSTG_PK_FN ON dms_documents_stg(TO_CHAR(dcn)) TABLESPACE MAXDAT_INDX;  