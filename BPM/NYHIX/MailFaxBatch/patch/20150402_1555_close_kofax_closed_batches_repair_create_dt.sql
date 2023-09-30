-- Add missing Kofax batch records to staging table. - Repair to use CREATE_DT before COMPLETE_DT

-- Delete stuck queue rows from incorrect update.
delete
from BPM_UPDATE_EVENT_QUEUE
where BSL_ID = 16 and EVENT_DATE <= to_date('2015-04-02 15:43:15','YYYY-MM-DD HH24:MI:SS');

commit;

-- Set complete date to now (later than CREATE_DT).
update CORP_ETL_MFB_BATCH 
set 
  BATCH_COMPLETE_DT = sysdate,
  COMPLETE_DT = sysdate
where CREATION_USER_NAME = 'Randall Kolb';

commit;

