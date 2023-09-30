CREATE SEQUENCE  "HCO_SEQ_IVR_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "HCO_SEQ_IVR_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE HCO_IVR_TRANSACTIONS
( IVR_ID NUMBER(10)
, IVR_TRANSACTION_ID NUMBER(18) 
, CLIENT_NUMBER NUMBER(10)
, REQUEST_DATE DATE
, RESPONSE_DATE DATE
, CALL_GUID VARCHAR2(40)
, ACTIVITY_ID VARCHAR2(40)
, ACTIVITY_DATE DATE
, FIRST_NAME VARCHAR2(20)
, LAST_NAME  VARCHAR2(20)
, MIDDLE_NAME VARCHAR2(1)
,	FAX_DOC_TYPE VARCHAR2(15)
, FAX_REQUEST_DATE DATE
, FAX_NUMBER VARCHAR2(15)
, FAX_MAIL_ID VARCHAR2(10)
, FAX_RESPONSE_DATE DATE
, FAX_TIME_IN_MINS NUMBER(5,2)
, PACKET_REQUEST_DATE DATE
, PACKET_MAIL_ID VARCHAR2(10)  
, PACKET_RESPONSE_DATE DATE
, ENROLL_CNT NUMBER(2)
, CREATED_BY    VARCHAR2(18)
, DATE_CREATED  DATE
, DATE_UPDATED  DATE
, UPDATED_BY    VARCHAR2(18)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  ); 
  
create index HCO_IVRCALL_IDX1_CLNTNM_REQSDT on HCO_IVR_TRANSACTIONS (CLIENT_NUMBER, REQUEST_DATE)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  

create index HCO_IVRCALL_IDX1_IVR_TRANSID on HCO_IVR_TRANSACTIONS (IVR_TRANSACTION_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  


CREATE OR REPLACE TRIGGER "BUIR_IVRTRANS"
 BEFORE INSERT OR UPDATE
 ON HCO_IVR_TRANSACTIONS
 FOR EACH ROW
DECLARE
    v_seq_id     HCO_IVR_TRANSACTIONS.ivr_id%TYPE;
BEGIN

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;

  IF INSERTING THEN

      IF :NEW.IVR_ID IS NULL THEN
        SElECT HCO_SEQ_IVR_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.IVR_ID       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;

  END IF;

END BUIR_IVRTRANS;
/  

grant select, insert, update on HCO_IVR_TRANSACTIONS to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on HCO_IVR_TRANSACTIONS to MAXDAT_OLTP_SIUD;
grant select on HCO_IVR_TRANSACTIONS to MAXDAT_READ_ONLY;

--**********************************************************

CREATE SEQUENCE  "HCO_SEQ_OB_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "HCO_SEQ_OB_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE HCO_OB_TRANSACTIONS
( OB_ID NUMBER(10)
, OB_CALL_ID NUMBER(18) 
, OB_CALL_TYPE VARCHAR2(4)
, CLIENT_NUMBER NUMBER(10)
, CASE_NUMBER  NUMBER(10)
, CASE_ID      VARCHAR2(10)
, PHONE_NUMBER VARCHAR2(15)
, CALL_GUID VARCHAR2(40)
, ACTIVITY_ID VARCHAR2(40)
, AGENT_NAME VARCHAR2(40)
, DISPOSITION_DATE DATE
, DISPOSITION_CODE VARCHAR2(8)
, DISPOSITION_DESC VARCHAR2(80)
, FIRST_NAME VARCHAR2(20)
, LAST_NAME  VARCHAR2(20)
, MIDDLE_NAME VARCHAR2(1)
, SENT_TO_CRM_DATE DATE
, SENT_TO_CSR_DATE DATE
, BENE_CNT NUMBER(2)
, ENROLL_CNT NUMBER(2)
, RECORD_DATE DATE
, MODIFIED_DATE DATE
, CREATED_BY    VARCHAR2(18)
, DATE_CREATED  DATE
, DATE_UPDATED  DATE
, UPDATED_BY    VARCHAR2(18)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  ); 

create index HCO_OBCALL_IDX1_CLNTNM_DISPDT on HCO_OB_TRANSACTIONS (CLIENT_NUMBER, DISPOSITION_DATE)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
create index HCO_OBCALL_IDX2_OBCALL_ID on HCO_OB_TRANSACTIONS (OB_CALL_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  

CREATE OR REPLACE TRIGGER "BUIR_OBTRANS"
 BEFORE INSERT OR UPDATE
 ON HCO_OB_TRANSACTIONS
 FOR EACH ROW
DECLARE
    v_seq_id     HCO_OB_TRANSACTIONS.OB_ID%TYPE;
BEGIN

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;

  IF INSERTING THEN

      IF :NEW.OB_ID IS NULL THEN
        SElECT HCO_SEQ_OB_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.OB_ID       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;

  END IF;

END BUIR_OBTRANS;
/ 

grant select, insert, update on HCO_OB_TRANSACTIONS to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on HCO_OB_TRANSACTIONS to MAXDAT_OLTP_SIUD;
grant select on HCO_OB_TRANSACTIONS to MAXDAT_READ_ONLY;

create or replace view maxdat.hco_f_call_details_sv as
Select TRUNC(Date_Created) as Call_Date
     , 'OutBound' as Call_Type
     , ob_call_id as Call_ID
     , Call_Guid
     , O.Activity_id as Call_Activity_ID
     , Client_Number
     , Case When Middle_Name is not null and Middle_Name != '' Then
                  RTRIM(Last_Name)||' '||RTRIM(Middle_Name)||' '||RTRIM(First_Name)
            Else RTRIM(Last_Name)||' '||RTRIM(First_Name) End as Client_Name
     , Phone_Number
     , Disposition_date
     , Disposition_code
     , Disposition_desc
     , Agent_Name
     , Case When Disposition_code is not null then 'Y' else 'N' end as disposition_applied
     , Null Fax_doc
     , 'N' as Forms_Requested_Flag
     , 'N' as Materials_faxed_Flag
     , Case when enroll_cnt > 0 then 'Y' else 'N' end as Form_completed_flag
     , 0 Fax_Time_In_Mins
     , Sent_To_CSR_Date
     , R.SUBJECT as Incident_Type
     , R.ISSUE_TYPE as Issue_Type
     , Round(((Disposition_date - Sent_To_CSR_Date)*24*60*60),2) Call_Duration
     , ob_call_type as Campaign_Name
     , case when Bene_Cnt = 0 then 1 else Bene_Cnt end as Bene_Cnt
     , r.referral
     , r.referral_type
  From HCO_OB_TRANSACTIONS O
Left outer join HCO_CRM_INCIDENTS I on O.Activity_Id = I.Activity_Id
Left outer join HCO_D_INCIDENT_REFERRAL R on I.SUBJECTIDNAME = R.SUBJECT
Union
Select NVL(Trunc(Response_date),Trunc(Request_date))  as Call_Date
     , 'InBound' as Call_Type
     , ivr_transaction_id as Call_ID
     , Call_Guid
     , V.Activity_id as Call_Activity_ID
     , Client_Number
     , Case When Middle_Name is not null and Middle_Name != '' Then
          RTRIM(Last_Name)||' '||RTRIM(Middle_Name)||' '||RTRIM(First_Name)
          Else
          RTRIM(Last_Name)||' '||RTRIM(First_Name)
           End as Client_Name
     , Fax_Number as Phone_Number
     , Request_date as Disposition_date
     , Null as disposition_code
     , Null as disposition_desc
     , Null Agent_Name
     , 'N' as disposition_applied
     , Fax_Mail_ID as Fax_Doc
     , Case When Packet_Request_date is not null then 'Y' else 'N' end as Forms_Requested_Flag
     , Case When Fax_Mail_id is not null then 'Y' else 'N' end as Materials_Faxed_Flag
     , case when enroll_cnt > 0 then 'Y' else 'N' end as Form_completed_flag
     , NVL(Fax_Time_In_Mins,0) as Fax_Time_In_Mins
     , Activity_date as Sent_To_CSR_Date
     , R.SUBJECT as Incident_Type
     , R.ISSUE_TYPE as Issue_Type
     , Round(((Activity_date - Response_date)*24*60*60),2) Call_Duration
     , Null Campaign_Name
     , 1 Bene_Cnt
     , r.referral
     , r.referral_type
  From HCO_IVR_TRANSACTIONS V
  Left outer join HCO_CRM_INCIDENTS I on V.Activity_Id = I.Activity_Id
  Left outer join HCO_D_INCIDENT_REFERRAL R on I.SUBJECTIDNAME = R.SUBJECT
With read only;

GRANT SELECT ON "HCO_F_CALL_DETAILS_SV" TO "MAXDAT_READ_ONLY";

-- Stage tables

create table MAXDAT.HCO_S_OB_TRANSACTIONS_STG
(
  ob_call_id       NUMBER(18),
  ob_call_type     VARCHAR2(4),
  client_number    NUMBER(10),
  case_number      NUMBER(10),
  case_id          VARCHAR2(10),
  phone_number     VARCHAR2(15),
  call_guid        VARCHAR2(40),
  activity_id      VARCHAR2(40),
  agent_name       VARCHAR2(40),
  disposition_date DATE,
  disposition_code VARCHAR2(8),
  disposition_desc VARCHAR2(80),
  first_name       VARCHAR2(20),
  last_name        VARCHAR2(20),
  middle_name      VARCHAR2(1),
  sent_to_crm_date DATE,
  sent_to_csr_date DATE,
  dtl_bene         NUMBER(18),
  enroll_cnt       NUMBER(2),
  bene_cnt         NUMBER(2),
  record_date      DATE,
  modified_date    DATE,
  partitionidx     NUMBER(1),
  rank_dtl	   NUMBER(2) DEFAULT 1
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
-- Grant/Revoke object privileges 
grant select, insert, update on MAXDAT.HCO_S_OB_TRANSACTIONS_STG to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.HCO_S_OB_TRANSACTIONS_STG to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.HCO_S_OB_TRANSACTIONS_STG to MAXDAT_READ_ONLY;

create index MAXDAT.STG_IDX1_OB_CALLID on MAXDAT.HCO_S_OB_TRANSACTIONS_STG (OB_CALL_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

CREATE TABLE MAXDAT.HCO_S_IVR_TRANSACTIONS_STG
(
  IVR_Transaction_ID   NUMBER(18),
  Client_Number        NUMBER(10),
  Request_Date         DATE,
  Response_Date        DATE,
  Call_GUID            VARCHAR2(40), 
  Activity_ID          VARCHAR2(40),
  Activity_Date        DATE,
  First_Name           VARCHAR2(20),
  Last_Name            VARCHAR2(20),
  Middle_Name          VARCHAR2(1),
  Fax_Doc_Type         VARCHAR2(15),
  Fax_Request_Date     DATE,
  Fax_Number           VARCHAR2(15),
  Fax_Mail_ID          VARCHAR2(10),
  Fax_Response_Date    DATE,
  Fax_Time_In_Mins     NUMBER(5,2),
  Packet_Request_Date  DATE,
  Packet_Mail_ID       VARCHAR2(10),
  Packet_Response_Date DATE,
  Enroll_Cnt           NUMBER(2)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Grant/Revoke object privileges 
grant select, insert, update on MAXDAT.HCO_S_IVR_TRANSACTIONS_STG to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.HCO_S_IVR_TRANSACTIONS_STG to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.HCO_S_IVR_TRANSACTIONS_STG to MAXDAT_READ_ONLY;

create index MAXDAT.STG_IDX1_IVR_TRANSID on MAXDAT.HCO_S_IVR_TRANSACTIONS_STG (IVR_Transaction_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
begin
     DBMS_ERRLOG.CREATE_ERROR_LOG ('HCO_S_IVR_TRANSACTIONS_STG','ERRLOG_IVRCALLS');
  end;
  /
  
begin
     DBMS_ERRLOG.CREATE_ERROR_LOG ('HCO_S_OB_TRANSACTIONS_STG','ERRLOG_OBCALLS');
  end;
  /  
  