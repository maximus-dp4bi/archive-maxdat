drop package PROCESS_BPM_QUEUE_JOB;
drop procedure INS_CORP_ETL_MANAGE_WORK_BE.sql
drop procedure UPD_CORP_ETL_MANAGE_WORK_BE.sql

alter table BPM_UPDATE_EVENT_QUEUE rename to BPM_UPDATE_EVENT_QUEUE_BCK;
alter table BPM_UPDATE_EVENT_QUEUE_BCK drop constraint BUEQ_PK;
drop index BUEQ_IX1 ;
drop index BUEQ_IX2 ;
drop sequence SEQ_BUEQ_ID;
drop sequence SEQ_PROCESS_BUEQ_ID;

alter table BPM_ERRORS modify (RUN_DATA_OBJECT varchar2(61));
alter table BPM_ERRORS add (BACKTRACE clob);