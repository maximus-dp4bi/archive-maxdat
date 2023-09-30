/*
Created on 02/14/2017 by Raj A.
Description: per NYHIX-26477, rebuilding the PP_BO_TASK table to avoid serialization of ITL slots.
Setting INITRANS to 5.
*/
/*
create table MAXDAT.PP_BO_TASK_BKP
(
  STAFF_ID                      NUMBER(38) not null,
  TASK_START                    DATE not null,
  TASK_END                      DATE not null,
  TASK_CATEGORY_ID              NUMBER(38) not null,
  DURATION                      NUMBER(38) not null,
  EVENT_ID                      NUMBER(38) not null,
  SUPERVISOR                    NUMBER(38),
  TASK_MODIFICATION_REQUEST_REF NUMBER(38),
  TASK_ID                       NUMBER(38) not null,
  EXTRACT_DT                    DATE not null,
  LAST_UPDATE_DT                DATE not null,
  LAST_UPDATED_BY               VARCHAR2(30) not null,
  SCENARIO_GROUP_ID             NUMBER(38) not null
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 5
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )
NOLOGGING
NOCOMPRESS 
NOCACHE 
NOPARALLEL
NOMONITORING;
*/
CREATE TABLE MAXDAT.PP_BO_TASK_BKP
 TABLESPACE MAXDAT_DATA
 NOLOGGING
 PARALLEL (DEGREE 4)
  PCTFREE 10
  INITRANS 4
  MAXTRANS 255
  STORAGE
  (
    INITIAL 64K
    NEXT 1M
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
  )
AS
SELECT * FROM maxdat.PP_BO_TASK
;

DROP TABLE MAXDAT.PP_BO_TASK;

RENAME PP_BO_TASK_BKP TO PP_BO_TASK;

-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.PP_BO_TASK
  add constraint PP_BO_TASK_PK primary key (TASK_ID)
  using index 
  tablespace MAXDAT_DATA
  pctfree 10
  initrans 8
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MAXDAT.PP_BO_TASK
  add constraint TSK_STAFF_ID_FK foreign key (STAFF_ID)
  references MAXDAT.PP_BO_STAFF (STAFF_ID);
alter table MAXDAT.PP_BO_TASK
  add constraint TSK_TASK_CATEGORY_ID_FK foreign key (TASK_CATEGORY_ID)
  references MAXDAT.PP_BO_TASK_CATEGORY (TASK_CATEGORY_ID);

-- Create/Recreate indexes 
create index MAXDAT.TASK_EVENT_ID_FK on MAXDAT.PP_BO_TASK (EVENT_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 8
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index MAXDAT.TASK_STAFF_ID_FK on MAXDAT.PP_BO_TASK (STAFF_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 8
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index MAXDAT.TASK_TASK_CATEGORY_ID_FK on MAXDAT.PP_BO_TASK (TASK_CATEGORY_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 8
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
grant select on MAXDAT.PP_BO_TASK to MAXDAT_READ_ONLY;
execute maxdat_admin.gather_table_stats('MAXDAT', 'PP_BO_TASK', 4);