alter table F_COR_BY_DATE drop constraint FCORBD_PK;
alter table F_COR_BY_DATE add constraint FCORBD_PK primary key (FCORBD_ID) using index tablespace MAXDAT_INDX;

update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where BSL_ID = 15;

commit;
