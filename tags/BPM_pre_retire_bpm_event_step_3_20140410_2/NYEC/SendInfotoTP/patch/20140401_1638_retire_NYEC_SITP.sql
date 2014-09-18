drop trigger TRG_AI_NYEC_SEND_INFO_TO_TP_Q;
drop trigger TRG_AU_NYEC_SEND_INFO_TO_TP_Q;

drop package NYEC_SEND_INFO_TO_TP;

--

delete from BPM_UPDATE_EVENT_QUEUE where BSL_ID = 8;

delete from PROCESS_BPM_QUEUE_JOB_CONFIG 
where BSL_ID = 8;

delete from BPM_SOURCE_LKUP 
where 
  BSL_ID = 8
  and NAME = 'NYEC_ETL_SENDINFOTRADPART';

commit;

--

drop view F_NYEC_SITP_BY_DATE_SV;
drop view D_NYEC_SITP_CURRENT_SV;

drop table F_NYEC_SITP_BY_DATE;
drop table D_NYEC_SITP_CURRENT;

drop sequence SEQ_FNSITPBD_ID;