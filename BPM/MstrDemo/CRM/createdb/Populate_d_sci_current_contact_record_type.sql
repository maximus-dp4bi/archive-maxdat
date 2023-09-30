
--Populate Contact Record Type
--90% Primary Individual
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'General' contact_record_type
       ,'GENERAL' contact_record_type_cd
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
          ORDER BY curr.contact_record_type_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 90 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_record_type = tmp.contact_record_type
     ,contact_record_type_cd = tmp.contact_record_type_cd;

--8% Third Party     
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Third Party' contact_record_type
       ,'THIRD_PARTY' contact_record_type_cd
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
          ORDER BY curr.contact_record_type_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 8 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_record_type = tmp.contact_record_type
     ,contact_record_type_cd = tmp.contact_record_type_cd;  
     
--2% Unidentified     
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Unidentified' contact_record_type
       ,'UNIDENTIFIED' contact_record_type_cd
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
          ORDER BY curr.contact_record_type_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 2 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_record_type = tmp.contact_record_type
     ,contact_record_type_cd = tmp.contact_record_type_cd;      

--commit;     