-- Create table
create table GROUPS_STG
(
  group_id            NUMBER(18) not null,
  group_name          VARCHAR2(80),
  description         VARCHAR2(1000),
  parent_group_id     NUMBER(18),
  deployment_name     VARCHAR2(32),
  start_date          DATE,
  end_date            DATE,
  type_cd             VARCHAR2(20),
  supervisor_staff_id NUMBER(18),
  created_by          VARCHAR2(80),
  create_ts           DATE,
  updated_by          VARCHAR2(80),
  update_ts           DATE
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

