
--Populate Contact WrapUp Time
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,178 contact_wrapup_time       
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
          ORDER BY curr.contact_wrapup_time NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 10 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_wrapup_time = tmp.contact_wrapup_time
     ;

MERGE INTO d_sci_current d
USING (SELECT p.*
       ,245 contact_wrapup_time       
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
          ORDER BY curr.contact_wrapup_time NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 15 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_wrapup_time = tmp.contact_wrapup_time
     ;    
     

MERGE INTO d_sci_current d
USING (SELECT p.*
       ,220 contact_wrapup_time       
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
          ORDER BY curr.contact_wrapup_time NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 7 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_wrapup_time = tmp.contact_wrapup_time
     ;  
     
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,275 contact_wrapup_time       
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
          ORDER BY curr.contact_wrapup_time NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 3 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_wrapup_time = tmp.contact_wrapup_time
     ;   
     
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,297 contact_wrapup_time       
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
          ORDER BY curr.contact_wrapup_time NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 15 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_wrapup_time = tmp.contact_wrapup_time
     ;           
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,200 contact_wrapup_time       
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
          ORDER BY curr.contact_wrapup_time NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 10 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_wrapup_time = tmp.contact_wrapup_time
     ;           

MERGE INTO d_sci_current d
USING (SELECT p.*
       ,240 contact_wrapup_time       
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
          ORDER BY curr.contact_wrapup_time NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 5 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_wrapup_time = tmp.contact_wrapup_time
     ;           

MERGE INTO d_sci_current d
USING (SELECT p.*
       ,180 contact_wrapup_time       
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
          ORDER BY curr.contact_wrapup_time NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 5 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_wrapup_time = tmp.contact_wrapup_time
     ;    
     
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,288 contact_wrapup_time       
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
          ORDER BY curr.contact_wrapup_time NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 15 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_wrapup_time = tmp.contact_wrapup_time
     ;   
     
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,265 contact_wrapup_time       
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
          ORDER BY curr.contact_wrapup_time NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 15 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_wrapup_time = tmp.contact_wrapup_time
     ;          
                    
     