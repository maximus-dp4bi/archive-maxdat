alter table BPM_ATTRIBUTE_STAGING_TABLE drop constraint BAST_BSL_FK;

delete from BPM_SOURCE_LKUP
where
  BSL_ID = 6
  and NAME = 'NYEC_ETL_MONITOR_RENEWAL';
  
commit;

drop table D_NYEC_IR_CLOCKDOWN_IND;