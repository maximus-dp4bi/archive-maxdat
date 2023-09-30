
--Populate Supervisor/Team
MERGE INTO d_sci_current d
USING (SELECT sci.contact_record_id,t.team_id,t.team_name,t.supervisor_staff_id, sup.first_name||' '||sup.last_name supervisor_last_name
       FROM d_sci_current sci
        JOIN d_sci_staff_team st ON sci.supp_created_by = st.staff_id
        JOIN d_sci_team t ON st.team_id = t.team_id
        JOIN d_sci_staff sup ON t.supervisor_staff_id = sup.staff_id
      ) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET createdby_sup_staff_id = tmp.supervisor_staff_id
     ,createdby_sup_staff_name = tmp.supervisor_last_name
     ,createdby_team_name = tmp.team_name
     ,createdby_team_id = team_id;
    
--commit;     