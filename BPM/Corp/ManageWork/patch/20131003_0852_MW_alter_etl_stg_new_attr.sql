-- 10/3/13 B.Thai COnsolidate various ETL attributes not in NYEC.

alter table CORP_ETL_MANAGE_WORK add 
( case_id                NUMBER(18),
  client_id              NUMBER(18),
  cancel_method          VARCHAR2(50),
  cancel_reason          VARCHAR2(256),
  cancel_by              VARCHAR2(50),
  task_priority               VARCHAR2(50)
);

comment on column CORP_ETL_MANAGE_WORK.CLIENT_ID is 'Unique identifier associated to the client in MAXe';
comment on column CORP_ETL_MANAGE_WORK.CASE_ID is 'Unique identifier associated to the case in MAXe';
comment on column CORP_ETL_MANAGE_WORK.cancel_by is 'The name of the person or system that cancelled the instance';
comment on column CORP_ETL_MANAGE_WORK.cancel_method is 'The method in which the document instance was cancelled; coule be deleted, trashed by user, or exception';
comment on column CORP_ETL_MANAGE_WORK.cancel_reason is 'The reason that the instance was cancelled';
comment on column CORP_ETL_MANAGE_WORK.task_priority is 'Indicates the priority of the task instance';

create index IDX_MANAGE_WORK_CASE_ID on CORP_ETL_MANAGE_WORK (case_id) TABLESPACE  MAXDAT_INDX ;
create index IDX_MANAGE_WORK_CLIENT_ID on CORP_ETL_MANAGE_WORK (client_id) TABLESPACE  MAXDAT_INDX ;


alter table CORP_ETL_MANAGE_WORK_TMP add 
( case_id                NUMBER(18),
  client_id              NUMBER(18),
  cancel_method          VARCHAR2(50),
  cancel_reason          VARCHAR2(256),
  cancel_by              VARCHAR2(50),
  task_priority               VARCHAR2(50)
);

create index IDX_MANAGE_WORK_TMP_CASE_ID          on CORP_ETL_MANAGE_WORK_TMP (case_id)   TABLESPACE MAXDAT_INDX;
create index IDX_MANAGE_WORK_TMP_CLIENT_ID        on CORP_ETL_MANAGE_WORK_TMP (client_id) TABLESPACE MAXDAT_INDX;
