-- Create table
create table ATS.ASSESSMENT
(
  assessment_id               NUMBER(18) not null,
  assessment_type_cd          VARCHAR2(32) not null,
  calendar_item_id            NUMBER(18) not null,
  nurse_id                    NUMBER(18) not null,
  client_id                   NUMBER(18) not null,
  status_cd                   VARCHAR2(32) not null,
  effective_date              DATE,
  expiration_date             DATE,
  completion_date             DATE,
  preferred_nurse_gender_cd   VARCHAR2(32),
  preferred_nurse_language_cd VARCHAR2(32),
  client_address_id           NUMBER(18) not null,
  client_phone_id             NUMBER(18) not null,
  form_required_ind           NUMBER(1),
  note_ref_id                 NUMBER(18),
  authorized_contact_id       NUMBER(18),
  created_by                  VARCHAR2(32),
  create_ts                   DATE,
  updated_by                  VARCHAR2(32),
  update_ts                   DATE,
  status_ts                   DATE not null,
  status_updated_by           VARCHAR2(20),
  ref_type_1                  VARCHAR2(32),
  ref_val_1                   VARCHAR2(32),
  ref_type_2                  VARCHAR2(32),
  ref_val_2                   VARCHAR2(32)
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
-- Create/Recreate indexes 
create index ATS.ASSESSMENT_IDX01 on ATS.ASSESSMENT (ASSESSMENT_TYPE_CD)
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
create index ATS.ASSESSMENT_IDX02 on ATS.ASSESSMENT (CALENDAR_ITEM_ID)
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
create index ATS.ASSESSMENT_IDX03 on ATS.ASSESSMENT (NURSE_ID)
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
create index ATS.ASSESSMENT_IDX04 on ATS.ASSESSMENT (CLIENT_ID)
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
create index ATS.ASSESSMENT_IDX05 on ATS.ASSESSMENT (STATUS_CD)
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
create index ATS.ASSESSMENT_IDX06 on ATS.ASSESSMENT (EFFECTIVE_DATE)
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
create index ATS.ASSESSMENT_IDX07 on ATS.ASSESSMENT (EXPIRATION_DATE)
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
create index ATS.ASSESSMENT_IDX08 on ATS.ASSESSMENT (UPDATE_TS)
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
create index ATS.ASSESSMENT_IDX09 on ATS.ASSESSMENT (STATUS_TS)
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
create index ATS.ASSESSMENT_IDX10 on ATS.ASSESSMENT (CLIENT_ADDRESS_ID)
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
create index ATS.ASSESSMENT_IDX11 on ATS.ASSESSMENT (CLIENT_PHONE_ID)
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table ATS.ASSESSMENT
  add constraint ASSESSMENT_PK primary key (ASSESSMENT_ID)
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
alter table ATS.ASSESSMENT
  add constraint ASSESSMENT_R01 foreign key (ASSESSMENT_TYPE_CD)
  references ATS.ENUM_ASSESSMENT_TYPE (VALUE);
alter table ATS.ASSESSMENT
  add constraint ASSESSMENT_R02 foreign key (CALENDAR_ITEM_ID)
  references ATS.CALENDAR_ITEM (CALENDAR_ITEM_ID);
alter table ATS.ASSESSMENT
  add constraint ASSESSMENT_R04 foreign key (CLIENT_ID)
  references ATS.CLIENT (CLNT_CLIENT_ID);
alter table ATS.ASSESSMENT
  add constraint ASSESSMENT_R05 foreign key (PREFERRED_NURSE_GENDER_CD)
  references ATS.ENUM_GENDER (VALUE);
alter table ATS.ASSESSMENT
  add constraint ASSESSMENT_R06 foreign key (PREFERRED_NURSE_LANGUAGE_CD)
  references ATS.ENUM_LANGUAGE (VALUE);
alter table ATS.ASSESSMENT
  add constraint ASSESSMENT_R07 foreign key (CLIENT_ADDRESS_ID)
  references ATS.ADDRESS (ADDR_ID);
alter table ATS.ASSESSMENT
  add constraint ASSESSMENT_R08 foreign key (CLIENT_PHONE_ID)
  references ATS.PHONE_NUMBER (PHON_ID);
alter table ATS.ASSESSMENT
  add constraint ASSESSMENT_R10 foreign key (STATUS_CD)
  references ATS.ENUM_ASSESSMENT_STATUS (VALUE);
alter table ATS.ASSESSMENT
  add constraint ASSESSMENT_R11 foreign key (AUTHORIZED_CONTACT_ID)
  references ATS.AUTHORIZED_CONTACT (AUTHORIZED_CONTACT_ID);
-- Grant/Revoke object privileges 
grant select on ATS.ASSESSMENT to EB_READ_ONLY;
