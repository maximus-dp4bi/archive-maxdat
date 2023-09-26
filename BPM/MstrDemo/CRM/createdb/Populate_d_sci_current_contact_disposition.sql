
--Populate Contact Disposition
--4% Escalate
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Escalate' contact_disposition
       ,'ESCALATE' contact_disposition_cd
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
          ORDER BY curr.contact_disposition_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 4 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_disposition = tmp.contact_disposition
     ,contact_disposition_cd = tmp.contact_disposition_cd;

--10% Transfer
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Transfer' contact_disposition
       ,'TRANSFER' contact_disposition_cd
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
          ORDER BY curr.contact_disposition_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 10 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_disposition = tmp.contact_disposition
     ,contact_disposition_cd = tmp.contact_disposition_cd;

--1% Dropped
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Dropped' contact_disposition
       ,'DROPPED' contact_disposition_cd
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
          ORDER BY curr.contact_disposition_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 1 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_disposition = tmp.contact_disposition
     ,contact_disposition_cd = tmp.contact_disposition_cd;

--5% Requested Call Back
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Requested Call Back' contact_disposition
       ,'CALLBACK' contact_disposition_cd
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
          ORDER BY curr.contact_disposition_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 5 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_disposition = tmp.contact_disposition
     ,contact_disposition_cd = tmp.contact_disposition_cd;


--78% Complete
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Complete' contact_disposition
       ,'COMPLETE' contact_disposition_cd
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
          ORDER BY curr.contact_disposition_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 78 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_disposition = tmp.contact_disposition
     ,contact_disposition_cd = tmp.contact_disposition_cd;

--2% Incomplete
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Incomplete' contact_disposition
       ,'INCOMPLETE' contact_disposition_cd
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
          ORDER BY curr.contact_disposition_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 2 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_disposition = tmp.contact_disposition
     ,contact_disposition_cd = tmp.contact_disposition_cd;
--commit;     