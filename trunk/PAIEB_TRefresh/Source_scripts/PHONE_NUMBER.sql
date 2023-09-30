-- Create table
create table ATS.PHONE_NUMBER
(
  phon_id                 NUMBER(38) not null,
  phon_begin_date         DATE,
  phon_type_cd            VARCHAR2(32),
  phon_end_date           DATE,
  clnt_client_id          NUMBER(18),
  phon_area_code          VARCHAR2(3),
  phon_phone_number       VARCHAR2(7),
  phon_ext                VARCHAR2(10),
  phon_prov_id            NUMBER(38),
  phon_cntt_id            NUMBER(38),
  phon_dolk_id            VARCHAR2(32),
  created_by              VARCHAR2(30),
  creation_date           DATE,
  last_updated_by         VARCHAR2(30),
  last_update_date        DATE,
  phon_case_id            NUMBER(18),
  start_ndt               NUMBER(18),
  end_ndt                 NUMBER(18),
  phon_carrier_info       VARCHAR2(128),
  sms_enabled_ind         NUMBER(1),
  phon_bad_date           DATE,
  phon_bad_date_satisfied DATE,
  comparable_key          VARCHAR2(2000)
)
tablespace EB_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 8M
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate indexes 
create index ATS.PHONE_IDX11 on ATS.PHONE_NUMBER (CLNT_CLIENT_ID, PHON_CASE_ID, PHON_TYPE_CD, START_NDT, END_NDT)
  tablespace EB_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 8M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ATS.PHONE_IDX12 on ATS.PHONE_NUMBER (PHON_AREA_CODE, PHON_PHONE_NUMBER)
  tablespace EB_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 4M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ATS.PHONE_IDX13 on ATS.PHONE_NUMBER (COMPARABLE_KEY)
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
create index ATS.PHONE_NUMBER_IDX2 on ATS.PHONE_NUMBER (CLNT_CLIENT_ID)
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
  )
  nologging;
create index ATS.PHONE_NUMBER_IDX3 on ATS.PHONE_NUMBER (PHON_CASE_ID)
  tablespace EB_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 3M
    next 1M
    minextents 1
    maxextents unlimited
  )
  nologging;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ATS.PHONE_NUMBER
  add constraint PK_PHONE_NUMBER primary key (PHON_ID)
  using index 
  tablespace EB_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ATS.PHONE_NUMBER
  add constraint CASE_FK_PHONE_NUMBER foreign key (PHON_CASE_ID)
  references ATS.CASES (CASE_ID);
alter table ATS.PHONE_NUMBER
  add constraint CLIENT_FK_PHONE_NUMBER foreign key (CLNT_CLIENT_ID)
  references ATS.CLIENT (CLNT_CLIENT_ID);
alter table ATS.PHONE_NUMBER
  add constraint ENUM_OFFICE_FK_PHONE_NUMBER foreign key (PHON_DOLK_ID)
  references ATS.ENUM_OFFICE (VALUE);
alter table ATS.PHONE_NUMBER
  add constraint ENUM_PHONE_TYPE_FK_PHONE foreign key (PHON_TYPE_CD)
  references ATS.ENUM_PHONE_TYPE (VALUE);
-- Grant/Revoke object privileges 
grant select on ATS.PHONE_NUMBER to EB_READ_ONLY;
