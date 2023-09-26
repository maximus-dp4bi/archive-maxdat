-----
---- Clear out BPM tables and Manage Work V2 related tables.
---- 
---   Prior to execution shutdown the BPM processes
---- 
delete from bpm_update_event_queue where bsl_id=2001;
commit;
delete from bpm_update_event_queue_archive where bsl_id=2001;
commit;
delete from bpm_logging where bsl_id=2001;
commit;
truncate table D_MW_V2_CURRENT;
commit;
truncate table D_MW_V2_HISTORY;
commit;
truncate table CORP_ETL_MW_V2;
commit;
truncate table CORP_ETL_MW_V2_WIP;
commit;
