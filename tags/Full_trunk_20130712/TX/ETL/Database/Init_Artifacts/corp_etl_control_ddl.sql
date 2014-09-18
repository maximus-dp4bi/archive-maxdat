-- Create table
create table CORP_ETL_CONTROL
(
  name        VARCHAR2(50) not null,
  value_type  VARCHAR2(1) not null,
  value       VARCHAR2(100) not null,
  description VARCHAR2(400),
  created_ts  DATE not null,
  updated_ts  DATE not null
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
comment on column CORP_ETL_CONTROL.name
  is 'Named Variable which will have a value stored';
comment on column CORP_ETL_CONTROL.value_type
  is 'Type of the named variable';
comment on column CORP_ETL_CONTROL.value
  is 'Holds the value for the named variable identifier - secondary lookup value';
comment on column CORP_ETL_CONTROL.description
  is 'Description of named variable';
comment on column CORP_ETL_CONTROL.created_ts
  is 'Date variable created';
comment on column CORP_ETL_CONTROL.updated_ts
  is 'Date Variable updated';
-- Create/Recreate primary, unique and foreign key constraints 
alter table CORP_ETL_CONTROL
  add constraint CECTL_PK primary key (NAME)
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
grant select on CORP_ETL_CONTROL to MAXDAT_READ_ONLY;
