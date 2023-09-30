-- Create table
create table ATS.APP_ADV_PLAN_SELECTION
(
  app_adv_plan_id                NUMBER(18) not null,
  application_id                 NUMBER(18),
  placement_county               VARCHAR2(32),
  residence_county               VARCHAR2(32),
  plan_id                        NUMBER(18),
  plan_id_ext                    VARCHAR2(32),
  network_id                     NUMBER(18),
  status_cd                      VARCHAR2(32),
  notes                          VARCHAR2(4000),
  reason_cd                      VARCHAR2(32),
  sent_date                      DATE,
  response_received_date         DATE,
  created_by                     VARCHAR2(80),
  create_ts                      DATE,
  updated_by                     VARCHAR2(80),
  update_ts                      DATE,
  choice_hierarchy_selection_ind NUMBER(1)
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table ATS.APP_ADV_PLAN_SELECTION
  add constraint XPKAPP_ADV_PLAN_ID primary key (APP_ADV_PLAN_ID)
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
alter table ATS.APP_ADV_PLAN_SELECTION
  add constraint APP_APPLICATION_IDUC1 unique (APPLICATION_ID)
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
alter table ATS.APP_ADV_PLAN_SELECTION
  add constraint APP_APPLICATION_IDFK1 foreign key (APPLICATION_ID)
  references ATS.APP_HEADER (APPLICATION_ID);
alter table ATS.APP_ADV_PLAN_SELECTION
  add constraint NETWORK_IDFK1 foreign key (NETWORK_ID)
  references ATS.NETWORK (NETWORK_ID);
alter table ATS.APP_ADV_PLAN_SELECTION
  add constraint PLAN_IDFK1 foreign key (PLAN_ID)
  references ATS.PLANS (PLAN_ID);
-- Grant/Revoke object privileges 
grant select on ATS.APP_ADV_PLAN_SELECTION to EB_READ_ONLY;
