-- Create table
create table MAXDAT.CORP_ETL_LIST_LKUP
(
  cell_id    NUMBER not null,
  name       VARCHAR2(30) not null,
  list_type  VARCHAR2(30) not null,
  value      VARCHAR2(100) not null,
  out_var    VARCHAR2(100),
  ref_type   VARCHAR2(100),
  ref_id     NUMBER(38),
  start_date DATE,
  end_date   DATE,
  comments   VARCHAR2(4000),
  created_ts DATE not null,
  updated_ts DATE not null
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
-- Add comments to the table 
comment on table MAXDAT.CORP_ETL_LIST_LKUP
  is 'Used to create list of values to used when pulling data for savvion';
-- Add comments to the columns 
comment on column MAXDAT.CORP_ETL_LIST_LKUP.name
  is 'LIST(lookup rule name for list of values)/IFTHEN(IF VALUE THEN OUT_VAR)/ID(REFERENCE AND ID)';
comment on column MAXDAT.CORP_ETL_LIST_LKUP.value
  is 'Either a list or reference value - Secondary lookup value';
comment on column MAXDAT.CORP_ETL_LIST_LKUP.out_var
  is 'Value to be extacted from table';
comment on column MAXDAT.CORP_ETL_LIST_LKUP.ref_type
  is 'Table name if ref id is prim key';
comment on column MAXDAT.CORP_ETL_LIST_LKUP.ref_id
  is 'Prim key when ref_type has table name';
comment on column MAXDAT.CORP_ETL_LIST_LKUP.start_date
  is 'used to turn on value';
comment on column MAXDAT.CORP_ETL_LIST_LKUP.end_date
  is 'Used to turn off value';
-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.CORP_ETL_LIST_LKUP
  add constraint CORP_ETL_LIST_LKUP_PK primary key (CELL_ID)
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
alter table MAXDAT.CORP_ETL_LIST_LKUP
  add constraint CORP_ETL_LIST_LKUP_UK unique (NAME, LIST_TYPE, VALUE)
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
grant select on MAXDAT.CORP_ETL_LIST_LKUP to MAXDAT_READ_ONLY;
