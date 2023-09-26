
--Populate Consumer Role
--62% Primary Individual
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Primary Individual' consumer_role
       ,'PRIMARY_INDIVIDUAL' consumer_role_cd
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
          WHERE curr.consumer_type_cd = 'CONSUMER' 
          ORDER BY curr.consumer_role_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 62 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET consumer_role = tmp.consumer_role
     ,consumer_role_cd = tmp.consumer_role_cd;

--22% Case Member     
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Case Member' consumer_role
       ,'CASE_MEMBER' consumer_role_cd
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
          WHERE curr.consumer_type_cd = 'CONSUMER' 
          ORDER BY curr.consumer_role_cd NULLS FIRST ,sci.contact_record_id )
           FETCH FIRST 22 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET consumer_role = tmp.consumer_role
     ,consumer_role_cd = tmp.consumer_role_cd;     
     

--16% Authorized Representative     
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Authorized Representative' consumer_role
       ,'AUTHORIZED_REP' consumer_role_cd
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
          WHERE curr.consumer_type_cd = 'CONSUMER' 
          ORDER BY curr.consumer_role_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 16 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET consumer_role = tmp.consumer_role
     ,consumer_role_cd = tmp.consumer_role_cd;      