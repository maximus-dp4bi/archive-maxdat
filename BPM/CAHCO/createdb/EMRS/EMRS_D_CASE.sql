CREATE SEQUENCE  "EMRS_SEQ_CASES_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_CASES_ID" TO "MAXDAT_READ_ONLY";

CREATE SEQUENCE  "EMRS_SEQ_CASES_HIST_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_CASES_HIST_ID" TO "MAXDAT_READ_ONLY";

DROP TABLE EMRS_D_CASE;
DROP TRIGGER BIR_CASES ;
DROP TRIGGER BUR_CASES ;


create table MAXDAT.EMRS_D_CASE
(
  dp_case_id              NUMBER not null,
  case_id                 VARCHAR2(10),
  case_number             NUMBER(12),
  clnt_client_id          NUMBER(12),
  mails_returned          VARCHAR2(10),
  addr_bad_date           DATE,
  modified_date           DATE,
  modified_name           VARCHAR2(50),
  record_date             DATE,
  record_name             VARCHAR2(50),
  updated_by              VARCHAR2(20),
  created_by              VARCHAR2(20),
  date_created            DATE,
  date_updated            DATE
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
-- Create/Recreate indexes 
create index MAXDAT.IDX2_CASENUM on MAXDAT.EMRS_D_CASE (CASE_NUMBER)
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

-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.EMRS_D_CASE
  add constraint CASE_PK primary key (DP_CASE_ID)
  using index 
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
-- Grant/Revoke object privileges 
grant select, insert, update on MAXDAT.EMRS_D_CASE to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.EMRS_D_CASE to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.EMRS_D_CASE to MAXDAT_READ_ONLY;

CREATE OR REPLACE TRIGGER "BUIR_CASE"
 BEFORE INSERT OR UPDATE
 ON emrs_d_case
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CASE.dp_case_id%TYPE;
BEGIN

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;

  IF INSERTING THEN

      IF :NEW.dp_case_id IS NULL THEN
        SElECT EMRS_SEQ_CASES_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_case_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;

    Insert into Emrs_D_Case_Hist (  case_number, case_id, clnt_client_id, mails_returned, addr_bad_date,
                record_name, record_date,  modified_name,  modified_date,  record_start_date,  record_end_date,
                dp_case_hist_id,  created_by,  date_created, updated_by,  date_updated )
    Values ( :NEW.Case_Number, :NEW.case_id, :NEW.clnt_client_id, :NEW.mails_returned, :NEW.addr_bad_date,
             :NEW.record_name, :NEW.record_date,  :NEW.modified_name,  :NEW.modified_date,  :NEW.record_date,
             to_date('12312050','MMDDYYYY'), emrs_seq_cases_hist_id.nextval, :NEW.created_by,
             :NEW.date_created, :NEW.updated_by,  :NEW.date_updated);

  ELSIF UPDATING THEN

      Update Emrs_D_Case_Hist Set Record_end_date = :New.Modified_Date, Current_Flag = 'N'
       Where Case_number = :New.Case_Number
         and record_end_Date = to_date('12312050','MMDDYYYY');

      Insert into Emrs_D_Case_Hist (  case_number, case_id, clnt_client_id, mails_returned, addr_bad_date,
                  record_name, record_date,  modified_name,  modified_date,  record_start_date,  record_end_date,
                  dp_case_hist_id,  created_by,  date_created, updated_by,  date_updated )
      Values ( :NEW.Case_Number, :NEW.case_id, :NEW.clnt_client_id, :NEW.mails_returned, :NEW.addr_bad_date,
               :NEW.record_name, :NEW.record_date,  :NEW.modified_name,  :NEW.modified_date,  :NEW.modified_date,
               to_date('12312050','MMDDYYYY'), emrs_seq_cases_hist_id.nextval, :NEW.created_by,
               :NEW.date_created, :NEW.updated_by,  :NEW.date_updated);

  END IF;


END BUIR_CASE;
/


ALTER TRIGGER "BUIR_CASE" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_CASE_SV
AS
SELECT
dp_case_id,
c.case_number,
c.case_id, 
l.cin as case_cin,
clnt_client_id,
l.firstname as first_name,
l.lastname as last_name,
l.middleinitial as middle_initial,
l.writtenlangcode as case_language_cd,
l.participantlang as case_spoken_language_cd,
c.mails_returned,
null as case_status,
null as case_educated_ind,
null as case_head_ssn,
null as case_how_educated_cd,
null as family_number,
c.record_name,
c.record_date,
c.modified_name,
c.modified_date,
c.created_by,
c.date_created,
c.updated_by,
c.date_updated,
null as last_state_updated_by,
CASE WHEN c.mails_returned = 'Y' then 'Mail Returned' ELSE 'No Mail Returned' END mails_returned_drv
FROM emrs_d_case c
LEFT OUTER JOIN emrs_d_client l on c.clnt_client_id = l.client_number;

GRANT SELECT ON "EMRS_D_CASE_SV" TO "MAXDAT_READ_ONLY";


DROP TABLE EMRS_S_CASES_STG;

create table EMRS_S_CASES_STG
(
  case_number    NUMBER(22) not null,
  case_id        VARCHAR2(10),
  clnt_client_id NUMBER(18),
  mails_returned VARCHAR2(1),
  addr_bad_date  DATE,
  record_name    VARCHAR2(50),
  record_date    DATE,
  modified_name  VARCHAR2(50),
  modified_date  DATE
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

create index MAXDAT.STG_IDX2_CASENUM on MAXDAT.EMRS_S_CASES_STG (CASE_NUMBER)
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

-- Grant/Revoke object privileges 
grant select, insert, update on MAXDAT.EMRS_S_CASES_STG to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.EMRS_S_CASES_STG to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.EMRS_S_CASES_STG to MAXDAT_READ_ONLY;

begin
     DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_CASE','ERRLOG_CASE');
  end;
  /
  

DROP TABLE EMRS_D_CASE_HIST;

-- Create table
create table EMRS_D_CASE_HIST
(
  dp_case_hist_id   NUMBER not null,
  case_number       NUMBER(22),
  case_id           VARCHAR2(10),
  clnt_client_id    NUMBER(18),
  mails_returned    VARCHAR2(1),
  addr_bad_date     DATE,
  record_name       VARCHAR2(50),
  record_date       DATE,
  modified_name     VARCHAR2(50),
  modified_date     DATE,
  record_start_date DATE,
  record_end_date   DATE,
  current_flag      VARCHAR2(1) default 'Y',
  created_by        VARCHAR2(20),
  date_created      DATE,
  updated_by        VARCHAR2(20),
  date_updated      DATE
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
  
alter table EMRS_D_CASE_HIST
  add constraint CASE_HIST_PK primary key (DP_CASE_HIST_ID)
  using index 
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

create index MAXDAT.CASEHIST_CASENUM_IDX on MAXDAT.EMRS_D_CASE_HIST (CASE_NUMBER)
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
  
create index MAXDAT.CASE_HIST_DATE_IDX1 on MAXDAT.EMRS_D_CASE_HIST (record_start_date, record_end_date)
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
  
  
-- Grant/Revoke object privileges 
grant select, insert, update on MAXDAT.EMRS_D_CASE_HIST to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.EMRS_D_CASE_HIST to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.EMRS_D_CASE_HIST to MAXDAT_READ_ONLY;  


CREATE OR REPLACE TRIGGER "BUIR_CASE_HIST" 
 BEFORE INSERT OR UPDATE
 ON EMRS_D_CASE_HIST
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CASE_HIST.dp_case_hist_id%TYPE;
BEGIN
  IF INSERTING THEN
    IF :NEW.dp_case_hist_id IS NULL THEN
      SElECT EMRS_SEQ_CASES_HIST_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.dp_case_hist_id   := v_seq_id;
    END IF;
    :NEW.created_by := user;
    :NEW.date_created := sysdate;
  END IF;
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
END BUIR_CASE_HIST;
/

ALTER TRIGGER "BUIR_CASE_HIST" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_CASE_HISTORY_SV AS
SELECT dp_case_hist_id,
l.cin  as case_cin,
null as case_head_ssn,
c.case_number,
clnt_client_id,
c.mails_returned,
null as family_number,
l.firstname as first_name,
l.lastname as last_name,
l.middleinitial as middle_initial,
null as last_state_updated_by,
record_name,
record_date,
modified_name,
modified_date,
c.record_start_date as date_of_validity_start,
c.record_end_date as date_of_validity_end,
0 as version,
c.current_flag,
c.created_by,
c.date_created,
c.updated_by,
c.date_updated,
CASE WHEN c.mails_returned = 'Y' then 'Mail Returned' ELSE 'No Mail Returned' END mails_returned_drv
FROM emrs_d_case_hist c
LEFT OUTER JOIN emrs_d_client_hist_elig l on c.clnt_client_id = l.client_number
and l.record_start_date between c.record_start_date and c.record_end_date;

GRANT SELECT ON "EMRS_D_CASE_HISTORY_SV" TO "MAXDAT_READ_ONLY";