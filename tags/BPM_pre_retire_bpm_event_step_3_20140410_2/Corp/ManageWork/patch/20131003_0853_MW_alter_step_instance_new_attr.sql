-- 10/3/13 B.Thai COnsolidate various ETL attributes not in NYEC.

alter table STEP_INSTANCE_STG add
(
  case_id                  NUMBER(18),
  client_id                NUMBER(18),
  priority                 VARCHAR2(50),
  stage_update_ts          DATE
);

create index IDX_STEP_INST_STG_case_id   on STEP_INSTANCE_STG (case_id)                  TABLESPACE MAXDAT_INDX;
create index IDX_STEP_INST_STG_client_id on STEP_INSTANCE_STG (client_id)                TABLESPACE MAXDAT_INDX;

