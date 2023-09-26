
--Populate Created by Operations Group
--93% Call Center Agent
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Call Center Agent' createdby_operations_group
       ,'CALL_CENTER' createdby_operations_group_cd
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
          ORDER BY curr.createdby_operations_group_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 93 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET createdby_operations_group = tmp.createdby_operations_group
     ,createdby_operations_group_cd = tmp.createdby_operations_group_cd;

--6% Special Projects
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Special Projects' createdby_operations_group
       ,'SPECIAL_PROJECTS' createdby_operations_group_cd
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
          ORDER BY curr.createdby_operations_group_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 6 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET createdby_operations_group = tmp.createdby_operations_group
     ,createdby_operations_group_cd = tmp.createdby_operations_group_cd;
     
--1% Other
MERGE INTO d_sci_current d
USING (SELECT p.*
       ,'Other' createdby_operations_group
       ,'OTHER' createdby_operations_group_cd
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
          ORDER BY curr.createdby_operations_group_cd NULLS FIRST,sci.contact_record_id )
           FETCH FIRST 1 PERCENT ROWS ONLY) p) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET createdby_operations_group = tmp.createdby_operations_group
     ,createdby_operations_group_cd = tmp.createdby_operations_group_cd;     

--Project Id
UPDATE d_sci_current
SET project_id = 123456789;

INSERT INTO D_PROJECT_CONFIGURATION(project_id,project_name,project_state,project_full_name)
VALUES(123456789,'Demo Project','VA','Demo Project - Virginia');
     
--commit;     