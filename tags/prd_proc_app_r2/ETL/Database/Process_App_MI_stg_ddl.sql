-- Create table
create table PROCESS_APP_MI_STG
( MISSING_INFO_ID           NUMBER(20) not null,
  APP_ID                    NUMBER(20) not null,
  MI_ITEM_LEVEL             VARCHAR2(20) not null,
  MI_ITEM_TYPE              VARCHAR2(20) not null,
  MI_ITEM_CREATE_DT         DATE not null,
  MI_ITEM_REQUESTED_BY      VARCHAR2(50) not null,
  MI_ITEM_STATUS            VARCHAR2(35),
  MI_ITEM_STATUS_DT         DATE,
  MI_ITEM_STATUS_PERFORMER  VARCHAR2(50),
  MI_ITEM_SATISFIED_CHANNEL VARCHAR2(35),
  MI_LETTER_CYCLE_START_DT  DATE,
  MI_LETTER_CYCLE_END_DT    DATE,
  MI_ITEM_CREATE_TASK_TYPE  VARCHAR2(35),
  MI_LETTER_ID              NUMBER(20),
  MI_LETTER_REQUIRED_STATUS VARCHAR2(20),
  MI_VALIDATED_DT           DATE,
  UNDELIVERABLE_IND         VARCHAR2(1) default 'N' not null,
  UNDELIVERABLE_IND_DT      DATE,
  SDE_TASK_COMPLETE_DT      DATE,
  REPROCESS_TASK_CREATE_DT  DATE,
  RFE_STATUS                VARCHAR2(35),
  RFE_STATUS_DT             DATE,
  RFE_NOT_APPROVED_COUNT    NUMBER(10)
  OUTBOUND_CALL_ID          NUMBER(10),
  IN_PROCESS_IND            VARCHAR2(1) default 'Y' not null,
  MI_EXTRACT_COMPLETE_DT    DATE,
  CREATED_BY                VARCHAR2(80),
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
alter table PROCESS_APP_MI_STG
  add constraint PROCESS_APP_MI_STG_PK primary key (MISSING_INFO_ID);
-- Create/Recreate indexes 
create index PROCESS_APP_MI_STG_APP_ID_IDX on PROCESS_APP_MI_STG (APP_ID)
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
  
-- Grant/Revoke object privileges 
grant select, insert, update on PROCESS_APP_MI_STG to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on PROCESS_APP_MI_STG to MAXDAT_OLTP_SIUD;
grant select on PROCESS_APP_MI_STG to MAXDAT_READ_ONLY;

/