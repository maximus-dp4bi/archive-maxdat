create table MAXDAT.TS_TIMELINESS_EXCEPTION
(
  timeliness_exception_id NUMBER not null,
  rids_id                 VARCHAR2(20),
  app_id                  NUMBER not null,
  exception_type_id       NUMBER,
  exclusion_flag          VARCHAR2(1),
  hcfa_reactivation_flag  VARCHAR2(1),
  callback_date           DATE,
  new_cycle_start_date    DATE,
  new_cycle_end_date      DATE,
  ignore_flag             VARCHAR2(1),
  comments                VARCHAR2(1000),
  create_by               VARCHAR2(10),
  create_datetime         DATE not null,
  last_updated_by         VARCHAR2(10),
  last_updated_datetime   DATE not null
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
create index MAXDAT.TE_APP_ID on MAXDAT.TS_TIMELINESS_EXCEPTION (APP_ID)
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
create index MAXDAT.TE_RIDS_ID on MAXDAT.TS_TIMELINESS_EXCEPTION (RIDS_ID)
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
alter table MAXDAT.TS_TIMELINESS_EXCEPTION
  add primary key (TIMELINESS_EXCEPTION_ID)
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


create table MAXDAT.TS_EXCEPTION_TYPE_LKUP
(
  exception_type_id NUMBER not null,
  exception_type    VARCHAR2(250),
  end_date          DATE,
  create_by         VARCHAR2(50),
  create_datetime   DATE
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
alter table MAXDAT.TS_EXCEPTION_TYPE_LKUP
  add primary key (EXCEPTION_TYPE_ID)
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


CREATE OR REPLACE VIEW MAXDAT.TS_EXCEPTION_TYPE_LKUP_SV AS
select exception_type_id, exception_type, create_by, create_datetime, end_date
  from MAXDAT.TS_EXCEPTION_TYPE_LKUP;  
  
CREATE OR REPLACE VIEW MAXDAT.TS_TIMELINESS_EXCEPTION_SV AS
select te.timeliness_exception_id,
       te.rids_id,
       te.app_id,
       te.exception_type_id,
       etl.exception_type,
       te.exclusion_flag,
       te.hcfa_reactivation_flag,
       te.callback_date,
       te.new_cycle_start_date,
       te.new_cycle_end_date,
       te.ignore_flag,
       te.comments,
       te.create_by,
       te.create_datetime,
       te.last_updated_by,
       te.last_updated_datetime
  from maxdat.ts_timeliness_exception te
  join maxdat.ts_exception_type_lkup etl on te.exception_type_id=etl.exception_type_id;

commit;

/
