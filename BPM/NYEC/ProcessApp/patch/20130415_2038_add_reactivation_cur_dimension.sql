drop index DNPACUR_UIX1;
create unique index DNPACUR_UIX1 on D_NYEC_PA_CURRENT ("Application ID","Cur Reactivation Indicator") online tablespace MAXDAT_INDX parallel compute statistics;

update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where
  BSL_ID = 2
  and PROCESS_BUEQ_ID is not null
  and PROCESS_BUEQ_ID <= 3036932;
  
commit;
