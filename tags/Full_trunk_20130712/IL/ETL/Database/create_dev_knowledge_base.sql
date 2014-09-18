-- Create table
create table MAXDAT.DEV_KNOWLEDGE_BASE
(
  create_ts       DATE not null,
  workbook        VARCHAR2(120) not null,
  maxdat_table    VARCHAR2(120),
  maxdat_column   VARCHAR2(120),
  in_reference_to VARCHAR2(4000),
  question        VARCHAR2(4000),
  answer          VARCHAR2(4000),
  answer_clob     CLOB,
  dkb_id          NUMBER not null,
  update_ts       DATE not null,
  update_by       VARCHAR2(100) not null,
  create_by       VARCHAR2(100) not null
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
-- Add comments to the columns 
comment on column MAXDAT.DEV_KNOWLEDGE_BASE.create_ts
  is 'Date  quetions created';
comment on column MAXDAT.DEV_KNOWLEDGE_BASE.workbook
  is ' the workbook  the questions was asked about';
comment on column MAXDAT.DEV_KNOWLEDGE_BASE.maxdat_table
  is 'if  specifc question, then table';
comment on column MAXDAT.DEV_KNOWLEDGE_BASE.maxdat_column
  is 'if  specifc question, then column';
-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.DEV_KNOWLEDGE_BASE
  add constraint DKB_PRIM_KEY primary key (DKB_ID)
  using index 
  tablespace MAXDAT_DATA
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
grant select, insert, update on MAXDAT.DEV_KNOWLEDGE_BASE to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.DEV_KNOWLEDGE_BASE to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.DEV_KNOWLEDGE_BASE to MAXDAT_READ_ONLY;
