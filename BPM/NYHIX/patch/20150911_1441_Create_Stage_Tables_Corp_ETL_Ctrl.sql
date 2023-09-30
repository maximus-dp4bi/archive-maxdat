/*
Created on 09/11/2015 by Raj A.
Description: Per NYHIX-17154, created stage tables so these can be truncated reloaded on a nightly basis. 
app_doc_data_stg will have diffs on a hourly basis as captured by the Run_Initialization_MFD.kjb
A diff between the DLY_app_doc_data_stg & app_doc_data_stg should give us proof that Update_TS in the source system is faulty.

Raj A. 09/14/2015 Added sequence and trigger.
Raj A. 09/14/2015 Added create table for CORP_ETL_ALERTS and grant.
*/
create table dly_app_doc_data_stg as select * from app_doc_data_stg where rownum <= 1;
create table dly_doc_notification_stg as select * from document_notification_stg  where rownum <= 1;

create table MAXDAT.CORP_ETL_ALERTS
(
  CEA_ID           NUMBER(38),
  ETL_MODULE       VARCHAR2(50),
  SOURCE_TABLE     VARCHAR2(50),
  MAXDAT_TABLE     VARCHAR2(50),
  SOURCE_KEY       NUMBER(38),
  MAXDAT_KEY       NUMBER(38),
  SOURCE_UPDATE_TS DATE,
  MAXDAT_UPDATE_TS DATE,
  REF_INFO_1       VARCHAR2(200),
  REF_INFO_2       VARCHAR2(200),
  PROCESSED        VARCHAR2(1),
  CREATE_TS        DATE,
  UPDATE_TS        DATE
);
grant select on MAXDAT.CORP_ETL_ALERTS to MAXDAT_READ_ONLY; 

create sequence MAXDAT.SEQ_ETL_ALERTS
minvalue 1
maxvalue 9999999999999999999999999999
start with 2421
increment by 1
cache 20;

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('DLY_MAX_UPDATE_TS_DOC_NOTIF','D','2013/10/1 00:00:00','Max Update Date for DOCUMENT_NOTIFICATION Stage table updated once a DAY',SYSDATE,SYSDATE);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('DLY_MAX_UPDATE_TS_APP_DOC','D','2013/10/1 00:00:00','Max Update Date for APP_DOC_DATA Stage table updated once a DAY',SYSDATE,SYSDATE);
commit;


CREATE OR REPLACE TRIGGER MAXDAT.corp_etl_alerts_trg BEFORE
       INSERT OR
       UPDATE ON corp_etl_alerts FOR EACH ROW
BEGIN
  IF Inserting THEN
      SELECT SEQ_ETL_ALERTS.Nextval INTO :NEW.CEA_ID FROM Dual;
      :NEW.create_ts := SYSDATE;
  END IF;

  :NEW.update_ts := SYSDATE;
END;
/