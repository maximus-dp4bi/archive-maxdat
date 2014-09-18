drop trigger TRG_AI_NYEC_ETL_INIT_RENEWAL_Q;
drop trigger TRG_AU_NYEC_ETL_INIT_RENEWAL_Q;

drop package NYEC_INITIATE_RENEWAL;

--

delete from BPM_UPDATE_EVENT_QUEUE where BSL_ID = 6;

delete from PROCESS_BPM_QUEUE_JOB_CONFIG 
where BSL_ID = 6;

delete from BPM_SOURCE_LKUP 
where 
  BSL_ID = 6
  and NAME = 'NYEC_ETL_MONITOR_RENEWAL';

commit;

--

drop view D_NYEC_IR_CLOCKDOWN_IND_SV;
drop view F_NYEC_IR_BY_DATE_SV;
drop view D_NYEC_IR_CURRENT_SV;

drop table D_NYEC_IR_CLOCKDOWN_IND;
drop table F_NYEC_IR_BY_DATE;
drop table D_NYEC_IR_CURRENT;

drop sequence SEQ_DNIRCI_ID;
drop sequence SEQ_FNIRBD_ID;