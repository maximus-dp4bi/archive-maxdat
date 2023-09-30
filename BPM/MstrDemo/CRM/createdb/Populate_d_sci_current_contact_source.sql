
--Populate Contact Source
--85% Manual
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Manual' contact_source
       ,'MANUAL' contact_source_cd
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
          ORDER BY curr.contact_source_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 85 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_source = tmp.contact_source
     ,contact_source_cd = tmp.contact_source_cd;

--15% Auto
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Auto' contact_source
       ,'AUTO' contact_source_cd
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
          ORDER BY curr.contact_source_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 15 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_source = tmp.contact_source
     ,contact_source_cd = tmp.contact_source_cd;  
     
--commit;     