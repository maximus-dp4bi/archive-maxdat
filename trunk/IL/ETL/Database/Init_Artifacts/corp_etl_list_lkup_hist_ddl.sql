-- Create table
create table MAXDAT.CORP_ETL_LIST_LKUP_HIST
(
  cell_history_id NUMBER not null,
  hist_type       VARCHAR2(100),
  cell_id         NUMBER not null,
  name            VARCHAR2(30) not null,
  list_type       VARCHAR2(30) not null,
  value           VARCHAR2(100) not null,
  out_var         VARCHAR2(100),
  ref_type        VARCHAR2(100),
  ref_id          NUMBER(38),
  start_date      DATE,
  end_date        DATE,
  comments        VARCHAR2(4000),
  created_ts      DATE not null,
  updated_ts      DATE not null,
  hist_created_ts DATE not null,
  hist_user       VARCHAR2(4000),
  hist_updated_ts DATE not null
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.CORP_ETL_LIST_LKUP_HIST
  add constraint CORP_ETL_LIST_LKUP_HIST_PK primary key (CELL_HISTORY_ID)
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
grant select on MAXDAT.CORP_ETL_LIST_LKUP_HIST to MAXDAT_READ_ONLY;
