--   Step 3 create a backup for the deletes
create table maxdat.nyhix_mfb_v2_envelope_backup_20230101
as select * from maxdat.nyhix_mfb_v2_envelope
where batch_guid 
in ( select batch_guid from maxdat.nyhix_mfb_v2_envelope_fixes);  

-- Step 4 determine the control count for the deletes
select count(*) -- expect 12385
from maxdat.nyhix_mfb_v2_envelope
where env_receipt_date <> trunc(env_receipt_date ); 

-- Step 5 Delect from maxdat.nyhix_mfb_v2_envelope
delete from maxdat.nyhix_mfb_v2_envelope
where env_receipt_date <> trunc(env_receipt_date ); 

-- Setp 6 -- Commit if rows deleted matches the control count.
-- If counts do not match STOP and notify DEVELOPER

-- Step 7 EXECUTE THE "FIX" PACKAGE
--EXEC MAXDAT.NYHIX_MFB_V2_ENVELOPE_PKG_FIX.Load_ENVELOPE(SEQ_JOB_ID.nextval);
declare
       seq_num number;
    begin
       select SEQ_JOB_ID.nextval into seq_num from dual;
       MAXDAT.NYHIX_MFB_V2_ENVELOPE_PKG_FIX.Load_ENVELOPE(seq_num);
   end;

-- Step 8 -- Validate results

select distinct batch_guid --<< Expect 0
from maxdat.nyhix_mfb_v2_envelope
where env_receipt_date <> trunc(env_receipt_date ); 

select count(*) -- Expect 0
from maxdat.nyhix_mfb_v2_envelope
where env_receipt_date <> trunc(env_receipt_date ); 


