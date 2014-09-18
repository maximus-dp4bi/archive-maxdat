-- 2014/01/28 Put space on STAFF names.

DECLARE
  v_cnt INTEGER := 0;
BEGIN
  FOR a IN (SELECT cemw_id, task_id, status_date, stage_done_date, cancel_work_flag, complete_date
              FROM corp_etl_manage_work cmw
             WHERE ((INSTR(created_by_name,',') > 0         AND INSTR(created_by_name    ,', ') = 0) OR
                    (INSTR(escalated_to_name  ,',') > 0     AND INSTR(escalated_to_name  ,', ') = 0) OR
                    (INSTR(forwarded_by_name  ,',') > 0     AND INSTR(forwarded_by_name  ,', ') = 0) OR
                    (INSTR(group_supervisor_name  ,',') > 0 AND INSTR(group_supervisor_name  ,', ') = 0) OR
                    (INSTR(team_supervisor_name,',') > 0    AND INSTR(team_supervisor_name   ,', ') = 0) OR
                    (INSTR(owner_name         ,',') > 0     AND INSTR(owner_name         ,', ') = 0) OR
                    (INSTR(last_update_by_name,',') > 0     AND INSTR(last_update_by_name,', ') = 0))
            )
  LOOP
    UPDATE corp_etl_manage_work
       SET created_by_name     = CASE INSTR(created_by_name,', ')
                                 WHEN 0 THEN REPLACE(created_by_name,',',', ') 
                                 ELSE created_by_name
                                 END 
          ,escalated_to_name   = CASE INSTR(escalated_to_name,', ')
                                 WHEN 0 THEN REPLACE(escalated_to_name,',',', ') 
                                 ELSE escalated_to_name
                                 END
          ,forwarded_by_name   = CASE INSTR(forwarded_by_name,', ')
                                 WHEN 0 THEN REPLACE(forwarded_by_name,',',', ') 
                                 ELSE forwarded_by_name
                                 END
          ,group_supervisor_name = CASE INSTR(group_supervisor_name,', ')
                                 WHEN 0 THEN REPLACE(group_supervisor_name,',',', ') 
                                 ELSE group_supervisor_name
                                 END
          ,team_supervisor_name = CASE INSTR(team_supervisor_name,', ')
                                 WHEN 0 THEN REPLACE(team_supervisor_name,',',', ') 
                                 ELSE team_supervisor_name
                                 END
          ,owner_name          = CASE INSTR(owner_name,', ')
                                 WHEN 0 THEN REPLACE(owner_name,',',', ') 
                                 ELSE owner_name
                                 END
          ,last_update_by_name = CASE INSTR(last_update_by_name,', ')
                                 WHEN 0 THEN REPLACE(last_update_by_name,',',', ') 
                                 ELSE last_update_by_name
                                 END
     WHERE cemw_id = a.cemw_id;
    --
    IF v_cnt = 1000
    THEN v_cnt := 0; COMMIT;
    ELSE v_cnt := v_cnt + 1;
    END IF;
  END LOOP;
  COMMIT;

  FOR b IN (SELECT mw_bi_id, "Task ID", "Created By Name", "Current Owner Name"
                 , "Current Escalated To Name", "Current Forwarded By Name"
                 , "Current Team Supervisor Name", "Current Last Update By Name"
              FROM d_mw_current cr
             WHERE ((INSTR("Created By Name"             ,',') > 0  AND INSTR("Created By Name"             ,', ') = 0) OR
                    (INSTR("Current Escalated To Name"   ,',') > 0  AND INSTR("Current Escalated To Name"   ,', ') = 0) OR
                    (INSTR("Current Forwarded By Name"   ,',') > 0  AND INSTR("Current Forwarded By Name"   ,', ') = 0) OR
                    (INSTR("Current Team Supervisor Name",',') > 0  AND INSTR("Current Team Supervisor Name",', ') = 0) OR
                    (INSTR("Current Owner Name"          ,',') > 0  AND INSTR("Current Owner Name"          ,', ') = 0) OR
                    (INSTR("Current Last Update By Name" ,',') > 0  AND INSTR("Current Last Update By Name" ,', ') = 0))
            )
  LOOP
    UPDATE d_mw_current
       SET "Created By Name"     = CASE INSTR("Created By Name",', ')
                                 WHEN 0 THEN REPLACE("Created By Name",',',', ') 
                                 ELSE "Created By Name"
                                 END
          ,"Current Escalated To Name"   = CASE INSTR("Current Escalated To Name",', ')
                                 WHEN 0 THEN REPLACE("Current Escalated To Name",',',', ') 
                                 ELSE "Current Escalated To Name"
                                 END
          ,"Current Forwarded By Name"   = CASE INSTR("Current Forwarded By Name",', ')
                                 WHEN 0 THEN REPLACE("Current Forwarded By Name",',',', ') 
                                 ELSE "Current Forwarded By Name"
                                 END
          ,"Current Team Supervisor Name" = CASE INSTR("Current Team Supervisor Name",', ')
                                 WHEN 0 THEN REPLACE("Current Team Supervisor Name",',',', ') 
                                 ELSE "Current Team Supervisor Name"
                                 END
          ,"Current Owner Name"  = CASE INSTR("Current Owner Name",', ')
                                 WHEN 0 THEN REPLACE("Current Owner Name",',',', ') 
                                 ELSE "Current Owner Name"
                                 END
          ,"Current Last Update By Name" = CASE INSTR("Current Last Update By Name",', ')
                                 WHEN 0 THEN REPLACE("Current Last Update By Name",',',', ') 
                                 ELSE "Current Last Update By Name"
                                 END
     WHERE mw_bi_id = b.mw_bi_id;
    --
    IF v_cnt = 1000
    THEN v_cnt := 0; COMMIT; 
    ELSE v_cnt := v_cnt + 1;
    END IF;
  END LOOP;
  COMMIT;
END;
/
