--truncate table d_sci_current;

--Populate d_sci_current
INSERT INTO d_sci_current
 (complete_dt
,contact_end_dt
,contact_record_id
,contact_start_dt
,contact_type
,create_dt
,ext_telephony_ref
,gwf_work_identified
,handle_time
,language
,language_cd
,last_update_date
,note_present
,supp_contact_type_cd
,supp_created_by
,supp_update_by
,supp_worker_id
,translation_req
,created_by
,last_update_by_name
,supp_worker_name
,created_by_first_name
,created_by_last_name
,created_by_user_role)
SELECT complete_dt
,contact_end_dt
,contact_record_id
,contact_start_dt
,contact_type
,create_dt
,ext_telephony_ref
,gwf_work_identified
,handle_time
,language
,language_cd
,last_update_date
,note_present
,supp_contact_type_cd
,supp_created_by
,supp_update_by
,supp_worker_id
,translation_req
,created_by
,last_update_by_name
,supp_worker_name
,created_by_first_name
,created_by_last_name
,created_by_user_role
FROM (
SELECT sci.*
    ,s.first_name||' '||s.last_name created_by
    ,su.first_name||' '||su.last_name last_update_by_name
    ,w.first_name||' '||w.last_name supp_worker_name
    ,s.first_name created_by_first_name
    ,s.last_name created_by_last_name
    ,'CSR' created_by_user_role 
FROM sci_current_stg sci
 JOIN crm_staff_stg s ON sci.supp_created_by = s.staff_id
 JOIN crm_staff_stg su ON sci.supp_update_by = su.staff_id
 JOIN crm_staff_stg w ON sci.supp_update_by = w.staff_id);

--Populate Consumer
--91% Consumer
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Consumer' consumer_type
       ,'CONSUMER' consumer_type_cd
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
          ORDER BY curr.consumer_type_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 90 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET consumer_type = tmp.consumer_type
     ,consumer_type_cd = tmp.consumer_type_cd;
 
 --5% Provider
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Provider' consumer_type
       ,'PROVIDER' consumer_type_cd
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
          ORDER BY curr.consumer_type_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 5 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET consumer_type = tmp.consumer_type
     ,consumer_type_cd = tmp.consumer_type_cd;
 
 --3% Agency
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Agency' consumer_type
       ,'AGENCY' consumer_type_cd
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
          ORDER BY curr.consumer_type_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 3 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET consumer_type = tmp.consumer_type
     ,consumer_type_cd = tmp.consumer_type_cd;
     
 
 --2% Media
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Media' consumer_type
       ,'MEDIA' consumer_type_cd
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
          ORDER BY curr.consumer_type_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 2 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET consumer_type = tmp.consumer_type
     ,consumer_type_cd = tmp.consumer_type_cd;    
 