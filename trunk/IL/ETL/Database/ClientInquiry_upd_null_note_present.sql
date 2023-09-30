-- 8/13/13 For ILEB-1310 Fix Active null NOTE_PRESENT; should be little over 600 records.
UPDATE corp_etl_client_inquiry SET note_present = 'N'
 WHERE instance_status = 'Active' AND note_present IS NULL
   AND contact_record_id >= 190619;
COMMIT;
/