-- Create table
create table NYEC_ETL_PROCESS_APP_MI
(
  CEPAM_ID                  NUMBER(20) not null,
  MISSING_INFO_ID           NUMBER(20) not null,
  APP_ID                    NUMBER(20) not null,
  MI_ITEM_LEVEL             VARCHAR2(20) not null,
  MI_ITEM_TYPE              VARCHAR2(20) not null,
  MI_ITEM_CREATE_DT         DATE not null,
  MI_ITEM_REQUESTED_BY      VARCHAR2(50) not null,
  MI_ITEM_STATUS            VARCHAR2(35),
  MI_ITEM_STATUS_DT         DATE,
  MI_ITEM_STATUS_PERFORMER  VARCHAR2(50),
  MI_ITEM_SATISFIED_CHANNEL VARCHAR2(35),
  MI_ITEM_CREATE_TASK_TYPE  VARCHAR2(35),
  MI_LETTER_CYCLE_START_DT  DATE,
  MI_LETTER_CYCLE_END_DT    DATE,
  MI_LETTER_ID              NUMBER(20),
  MI_LETTER_REQUIRED_STATUS VARCHAR2(20),
  MI_VALIDATED_DT           DATE,
  RFE_STATUS                VARCHAR2(35),
  RFE_STATUS_DT             DATE,
  UNDELIVERABLE_IND         VARCHAR2(1) default 'N' not null,
  UNDELIVERABLE_IND_DT      DATE,
  OUTBOUND_CALL_ID          NUMBER(10),
  STAGE_DONE_DATE           DATE,
  STG_EXTRACT_DATE          DATE,
  STG_LAST_UPDATE_DATE      DATE
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
alter table NYEC_ETL_PROCESS_APP_MI
  add constraint NYEC_ETL_PROCESS_APP_MI_PK primary key (CEPAM_ID);
-- Create/Recreate indexes 
create index NYEC_ETL_PROCESS_APP_MI_ID_IDX on NYEC_ETL_PROCESS_APP_MI (APP_ID, MISSING_INFO_ID)
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

/* Public Synonym for Table */
CREATE PUBLIC SYNONYM NYEC_ETL_PROCESS_APP_MI FOR MAXDAT.NYEC_ETL_PROCESS_APP_MI;

-- Grant/Revoke object privileges 
grant select, insert, update, delete on NYEC_ETL_PROCESS_APP_MI to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on NYEC_ETL_PROCESS_APP_MI to MAXDAT_OLTP_SIUD;
grant select on NYEC_ETL_PROCESS_APP_MI to MAXDAT_READ_ONLY;
