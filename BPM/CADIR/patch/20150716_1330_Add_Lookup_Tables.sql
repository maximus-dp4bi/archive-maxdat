/*
Created on 07/16/2015 by Raj A.
Description: Created for CADIR-857. Create two lookup tables, ACTS_SPECIALITY & ACTS_REFUSAL_REASON. Removed existing public synonyms created by CADIR-934
*/
create table ACTS_SPECIALITY
(
  VALUE                VARCHAR2(32 CHAR) not null,
  DESCRIPTION          VARCHAR2(256 CHAR),
  ORDER_BY_DEFAULT     NUMBER(10),
  EFFECTIVE_START_DATE DATE,
  EFFECTIVE_END_DATE   DATE,
  PARENT_VALUE         VARCHAR2(32 CHAR),
  SPECIALITY_KEY       NUMBER,
  CREATED_BY           VARCHAR2(80 CHAR),
  CREATE_TS            DATE not null,
  UPDATED_BY           VARCHAR2(80 CHAR),
  UPDATE_TS            DATE not null  
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
  
create unique index ACTS_SPECIALITY_VALUE_IX1 on ACTS_SPECIALITY (VALUE)
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
create index MAXDAT.ACTS_SPECIALITY_SP_KEY_IX2 on MAXDAT.ACTS_SPECIALITY (SPECIALITY_KEY)
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

grant select, insert, update, delete on ACTS_SPECIALITY to MAXDAT_OLTP_SIUD;
grant select on ACTS_SPECIALITY to MAXDAT_READ_ONLY;  

create table ACTS_REFUSAL_REASON
(
  VALUE                VARCHAR2(32 CHAR) not null,
  DESCRIPTION          VARCHAR2(256 CHAR),
  ORDER_BY_DEFAULT     NUMBER(10),
  EFFECTIVE_START_DATE DATE,
  EFFECTIVE_END_DATE   DATE,
  CREATED_BY           VARCHAR2(80 CHAR),
  CREATE_TS            DATE not null,
  UPDATED_BY           VARCHAR2(80 CHAR),
  UPDATE_TS            DATE not null,
  PARENT_VALUE         VARCHAR2(32 CHAR)
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
  
create unique index ACTS_REFUSAL_REASON_VALUE_IX1 on ACTS_REFUSAL_REASON (VALUE)
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

grant select, insert, update, delete on ACTS_REFUSAL_REASON to MAXDAT_OLTP_SIUD;
grant select on ACTS_REFUSAL_REASON to MAXDAT_READ_ONLY;  

-- Creating Semantic Views 
CREATE OR REPLACE VIEW D_ACTS_SPECIALITY_SV AS SELECT * FROM ACTS_SPECIALITY WITH READ ONLY;
CREATE OR REPLACE VIEW D_ACTS_REFUSAL_REASON_SV AS SELECT * FROM ACTS_REFUSAL_REASON WITH READ ONLY;

--Removing Public Synonyms created by CADIR-934.
drop public synonym D_ACTS_REVIEW_DECISION_SV;
drop public synonym D_ACTS_CASE_QUEUE_SV;
drop public synonym D_ACTS_PROGRAM_SV;
drop public synonym D_ACTS_USERS_SV;
drop public synonym D_ACTS_CRED_CONSULTANT_SV;
drop public synonym S_ACTS_PM_RESPONSE_DETAILS_SV;
drop public synonym S_ACTS_PM_RESPONSE_SV;
drop public synonym S_ACTS_CONSULTANT_REF_HIST_SV;
drop public synonym S_ACTS_CONSULTANT_REF_SV;
drop public synonym S_ACTS_APPEAL_CASE_SV;