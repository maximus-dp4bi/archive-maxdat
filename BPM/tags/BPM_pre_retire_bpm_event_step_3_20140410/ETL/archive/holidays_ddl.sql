-- Create table
create table HOLIDAYS
(
  holiday_id   NUMBER(18) not null,
  holiday_year NUMBER(4),
  holiday_date DATE,
  description  VARCHAR2(128),
  created_by   VARCHAR2(80),
  create_ts    DATE,
  updated_by   VARCHAR2(80),
  update_ts    DATE
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
alter table HOLIDAYS
  add constraint HOY_PK primary key (HOLIDAY_ID)
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
alter table HOLIDAYS
  add constraint HOY_UK unique (HOLIDAY_YEAR, HOLIDAY_DATE)
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
grant select on HOLIDAYS to MAXDAT_READ_ONLY;
