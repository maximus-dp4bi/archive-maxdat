
--Populate Created by Operations Group
--85% Reached Successfully
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Reached Successfully' contact_outcome
       ,'SUCCESS' contact_outcome_cd
      FROM (
      SELECT * FROM (
          SELECT sci.*
              ,s.first_name||' '||s.last_name created_by
              ,su.first_name||' '||su.last_name last_update_by_name
              ,w.first_name||' '||w.last_name supp_worker_name
              ,s.first_name created_by_first_name
              ,s.last_name created_by_last_name
              ,'CSR' created_by_user_role     
          FROM sci_current_stg sci
           JOIN d_sci_current curr ON sci.contact_record_id = curr.contact_record_id
           JOIN crm_staff_stg s ON sci.supp_created_by = s.staff_id 
           JOIN crm_staff_stg su ON sci.supp_update_by = su.staff_id
           JOIN crm_staff_stg w ON sci.supp_update_by = w.staff_id 
          WHERE sci.supp_contact_type_cd = 'OUTBOUND'
          ORDER BY curr.contact_outcome_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 85 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_outcome = tmp.contact_outcome
     ,contact_outcome_cd = tmp.contact_outcome_cd;

--1% Invalid Phone
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Invalid Phone' contact_outcome
       ,'INVALID_PHONE' contact_outcome_cd
      FROM (
      SELECT * FROM (
          SELECT sci.*
              ,s.first_name||' '||s.last_name created_by
              ,su.first_name||' '||su.last_name last_update_by_name
              ,w.first_name||' '||w.last_name supp_worker_name
              ,s.first_name created_by_first_name
              ,s.last_name created_by_last_name
              ,'CSR' created_by_user_role     
          FROM sci_current_stg sci
           JOIN d_sci_current curr ON sci.contact_record_id = curr.contact_record_id
           JOIN crm_staff_stg s ON sci.supp_created_by = s.staff_id 
           JOIN crm_staff_stg su ON sci.supp_update_by = su.staff_id
           JOIN crm_staff_stg w ON sci.supp_update_by = w.staff_id 
          WHERE sci.supp_contact_type_cd = 'OUTBOUND'
          ORDER BY curr.contact_outcome_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 1 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_outcome = tmp.contact_outcome
     ,contact_outcome_cd = tmp.contact_outcome_cd;

--10% Did Not Reach/Left Voicemail
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Did Not Reach/Left Voicemail' contact_outcome
       ,'LEFT_VOICEMAIL' contact_outcome_cd
      FROM (
      SELECT * FROM (
          SELECT sci.*
              ,s.first_name||' '||s.last_name created_by
              ,su.first_name||' '||su.last_name last_update_by_name
              ,w.first_name||' '||w.last_name supp_worker_name
              ,s.first_name created_by_first_name
              ,s.last_name created_by_last_name
              ,'CSR' created_by_user_role     
          FROM sci_current_stg sci
           JOIN d_sci_current curr ON sci.contact_record_id = curr.contact_record_id
           JOIN crm_staff_stg s ON sci.supp_created_by = s.staff_id 
           JOIN crm_staff_stg su ON sci.supp_update_by = su.staff_id
           JOIN crm_staff_stg w ON sci.supp_update_by = w.staff_id 
          WHERE sci.supp_contact_type_cd = 'OUTBOUND'
          ORDER BY curr.contact_outcome_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 10 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_outcome = tmp.contact_outcome
     ,contact_outcome_cd = tmp.contact_outcome_cd;

--4% Did Not Reach/No Voicemail
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Did Not Reach/No Voicemail' contact_outcome
       ,'NO_VOICEMAIL' contact_outcome_cd
      FROM (
      SELECT * FROM (
          SELECT sci.*
              ,s.first_name||' '||s.last_name created_by
              ,su.first_name||' '||su.last_name last_update_by_name
              ,w.first_name||' '||w.last_name supp_worker_name
              ,s.first_name created_by_first_name
              ,s.last_name created_by_last_name
              ,'CSR' created_by_user_role     
          FROM sci_current_stg sci
           JOIN d_sci_current curr ON sci.contact_record_id = curr.contact_record_id
           JOIN crm_staff_stg s ON sci.supp_created_by = s.staff_id 
           JOIN crm_staff_stg su ON sci.supp_update_by = su.staff_id
           JOIN crm_staff_stg w ON sci.supp_update_by = w.staff_id 
          WHERE sci.supp_contact_type_cd = 'OUTBOUND'
          ORDER BY curr.contact_outcome_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 4 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_outcome = tmp.contact_outcome
     ,contact_outcome_cd = tmp.contact_outcome_cd;
     
--commit;     