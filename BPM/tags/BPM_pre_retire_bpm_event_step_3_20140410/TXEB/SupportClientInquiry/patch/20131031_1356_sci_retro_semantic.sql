/* MAXDAT-882 Retroactive create date for a few Client Inquiry update queue rows on TXEB UAT.
  BPM data fix script:
   1. Remove F_SCI_BY_DATE duplicate record
   2. Update BPM_INSTANCE.START_DATE
   3. Update F_SCI_BY_DATE.D_DATE same as ETL CREATE_DT
   4. Update D_SCI_CURRENT.CREATE_DATE and CONTACT_START_TIME to match ETL CREATE_DT
   5. Reset BPM queue
*/

alter table F_SCI_BY_DATE enable row movement;

declare
  V_BI_ID BPM_INSTANCE.BI_ID%type;
begin
  -- Step 1:
  delete from F_SCI_BY_DATE
   where (SCI_BI_ID = 6833259  and FSCIBD_ID = 6585)
      or (SCI_BI_ID = 13073277 and FSCIBD_ID = 6605)
      or (SCI_BI_ID = 23897449 and FSCIBD_ID = 22470);
        
  for A in (select CONTACT_RECORD_ID, CREATE_DT, CONTACT_START_DT from CORP_ETL_CLIENT_INQUIRY 
                      where CONTACT_RECORD_ID in (26216060,26216061,26233065))
  loop
    -- Step 2:
    update BPM_INSTANCE
       set START_DATE = A.CREATE_DT
     where IDENTIFIER = A.CONTACT_RECORD_ID
    returning BI_ID into V_BI_ID;

    -- Step 3:
    update F_SCI_BY_DATE
       set D_DATE = A.CREATE_DT
         , BUCKET_START_DATE = A.CREATE_DT
     where SCI_BI_ID = V_BI_ID;
    
    -- Step 4:
    update D_SCI_CURRENT
       set CREATE_DATE        = A.CREATE_DT
         , CONTACT_START_TIME = A.CONTACT_START_DT
     where CONTACT_RECORD_ID  = A.CONTACT_RECORD_ID;
    
    -- Step 5:
    update BPM_UPDATE_EVENT_QUEUE
       set WROTE_BPM_EVENT_DATE = NULL
         , PROCESS_BUEQ_ID      = NULL
     where BSL_ID     = 13
       and IDENTIFIER = A.CONTACT_RECORD_ID;
  end loop;
  commit;
end;
/
alter table F_SCI_BY_DATE disable row movement;

/*
SELECT * FROM bpm_instance WHERE bi_id IN (6833259, 13073277, 23897449);
SELECT * FROM d_sci_current WHERE contact_record_id IN (26216060,26216061,26233065);
SELECT * FROM f_sci_by_date WHERE sci_bi_id IN (6833259, 13073277, 23897449);
*/
--
