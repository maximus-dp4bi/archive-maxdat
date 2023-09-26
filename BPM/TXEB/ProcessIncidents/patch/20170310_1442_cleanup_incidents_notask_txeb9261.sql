BEGIN
  FOR x IN(SELECT incident_id, max(step_instance_id) task_id
           FROM corp_etl_process_incidents i
            INNER JOIN step_instance_stg s 
              ON i.incident_id = s.ref_id 
              AND ref_type = 'INCIDENT_HEADER'
           WHERE current_task_id is null
           GROUP BY incident_id)
  LOOP    
    UPDATE corp_etl_process_incidents
    SET current_task_id = x.task_id
    WHERE incident_id = x.incident_id;
  END LOOP;
END;
/
COMMIT;