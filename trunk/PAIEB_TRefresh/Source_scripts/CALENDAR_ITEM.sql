-- Create table
create table ATS.CALENDAR_ITEM
(
  calendar_item_id      NUMBER(18) not null,
  title                 VARCHAR2(100),
  description           VARCHAR2(4000),
  location              VARCHAR2(100),
  end_ts                DATE,
  type_cd               VARCHAR2(32),
  organizer             VARCHAR2(32),
  note_ref_id           NUMBER(18),
  contact               VARCHAR2(100),
  recurring_ind         NUMBER(1) default 0,
  recurrence_id         NUMBER(18),
  transparency_ind      NUMBER(1) default 1,
  public_ind            NUMBER(1) default 1,
  ref_calendar_item_id  NUMBER(18),
  item_status_cd        VARCHAR2(32),
  category_cd           VARCHAR2(32),
  start_ts              DATE,
  priority_cd           VARCHAR2(32),
  all_day_event_ind     NUMBER(1),
  ref_type              VARCHAR2(20),
  ref_id                NUMBER(18),
  ref_type_2            VARCHAR2(32),
  ref_id_2              VARCHAR2(32),
  ref_type_3            VARCHAR2(32),
  ref_id_3              VARCHAR2(32),
  created_by            VARCHAR2(20),
  create_ts             DATE,
  updated_by            VARCHAR2(20),
  update_ts             DATE,
  item_status_reason_cd VARCHAR2(32),
  status_ts             DATE not null,
  status_updated_by     VARCHAR2(20)
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
create index ATS.CALENDAR_ITEM_IDX1 on ATS.CALENDAR_ITEM (TYPE_CD)
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
create index ATS.CALENDAR_ITEM_IDX2 on ATS.CALENDAR_ITEM (ITEM_STATUS_CD)
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
create index ATS.CALENDAR_ITEM_IDX3 on ATS.CALENDAR_ITEM (CATEGORY_CD)
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
create index ATS.CALENDAR_ITEM_IDX4 on ATS.CALENDAR_ITEM (REF_TYPE_3, REF_ID_3)
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
create index ATS.CALENDAR_ITEM_IDX5 on ATS.CALENDAR_ITEM (REF_TYPE, REF_ID)
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
create index ATS.CALENDAR_ITEM_IDX6_NAM on ATS.CALENDAR_ITEM (START_TS, END_TS, ITEM_STATUS_CD, REF_TYPE, REF_ID)
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
alter table ATS.CALENDAR_ITEM
  add constraint XPKCALENDAR_ITEM primary key (CALENDAR_ITEM_ID)
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
alter table ATS.CALENDAR_ITEM
  add constraint CALENDAR_ITEM_R06 foreign key (REF_ID_2)
  references ATS.ENUM_CALENDAR_ITEM_REASON (VALUE);
alter table ATS.CALENDAR_ITEM
  add constraint FK_CALENDAR_ITEM_RECURRENCE foreign key (RECURRENCE_ID)
  references ATS.CALENDAR_ITEM_RECURRENCE (RECURRENCE_ID);
alter table ATS.CALENDAR_ITEM
  add constraint FK_ENUM_CALENDAR_ITEM_CTGR1 foreign key (CATEGORY_CD)
  references ATS.ENUM_CALENDAR_ITEM_CATEGORY (VALUE);
alter table ATS.CALENDAR_ITEM
  add constraint FK_ENUM_CALENDAR_ITEM_PRIORITY foreign key (PRIORITY_CD)
  references ATS.ENUM_CALENDAR_ITEM_PRIORITY (VALUE);
alter table ATS.CALENDAR_ITEM
  add constraint FK_ENUM_CALENDAR_ITEM_STATUS foreign key (ITEM_STATUS_CD)
  references ATS.ENUM_CALENDAR_ITEM_STATUS (VALUE);
alter table ATS.CALENDAR_ITEM
  add constraint FK_ENUM_CALENDAR_ITEM_TYPE foreign key (TYPE_CD)
  references ATS.ENUM_CALENDAR_ITEM_TYPE (VALUE);
alter table ATS.CALENDAR_ITEM
  add constraint FK_ENUM_CALENDAR_STATUS_REASON foreign key (ITEM_STATUS_REASON_CD)
  references ATS.ENUM_CALENDAR_STATUS_REASON (VALUE);
-- Grant/Revoke object privileges 
grant select on ATS.CALENDAR_ITEM to EB_READ_ONLY;
