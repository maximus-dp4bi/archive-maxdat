CREATE SEQUENCE  MAXDAT_LOOKUP."SEQ_CELLN_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1
CACHE 20 NOORDER  NOCYCLE ;

-- Create table
create table CORP_ETL_LIST_LKUP_NUM
(
  celln_id    NUMBER not null,
  name       VARCHAR2(30) not null,
  value      VARCHAR2(100) not null,
  start_date DATE,
  end_date   DATE,
  comments   VARCHAR2(4000),
  created_ts DATE not null,
  updated_ts DATE not null
)
tablespace EB_DATA
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
-- Add comments to the table 
comment on table CORP_ETL_LIST_LKUP_NUM
  is 'Used to create list of values to used when pulling data';
-- Add comments to the columns 
comment on column CORP_ETL_LIST_LKUP_NUM.name
  is 'Lookup Name';
comment on column CORP_ETL_LIST_LKUP_NUM.value
  is 'Lookup Value';
comment on column CORP_ETL_LIST_LKUP_NUM.start_date
  is 'used to turn on value';
comment on column CORP_ETL_LIST_LKUP_NUM.end_date
  is 'Used to turn off value';
-- Create/Recreate primary, unique and foreign key constraints 
alter table CORP_ETL_LIST_LKUP_NUM
  add constraint CORP_ETL_LIST_LKUP_NUM_PK primary key (CELLN_ID)
  using index 
  tablespace EB_DATA
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
alter table CORP_ETL_LIST_LKUP_NUM
  add constraint CORP_ETL_LIST_LKUP_NUM_UK unique (NAME, VALUE)
  using index 
  tablespace EB_DATA
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
grant select,references on CORP_ETL_LIST_LKUP_NUM to EB_MAXDAT_REPORTS;







