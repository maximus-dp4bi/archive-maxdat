-- 2014/01/24 MW has space between STAFF names. Have to remove them.

UPDATE corp_etl_manage_work 
   SET created_by_name     = REPLACE(created_by_name,', ',',') 
      ,escalated_to_name   = REPLACE(escalated_to_name,', ',',')
      ,forwarded_by_name   = REPLACE(forwarded_by_name,', ',',')
      ,group_supervisor_name = REPLACE(group_supervisor_name,', ',',')
      ,team_supervisor_name = REPLACE(team_supervisor_name,', ',',')
      ,owner_name          = REPLACE(owner_name,', ',',')
      ,last_update_by_name = REPLACE(last_update_by_name,', ',',')
 WHERE last_update_date > TO_DATE('1/22/2014','mm/dd/yyyy')
   AND (INSTR(created_by_name    ,', ') > 0 OR
        INSTR(escalated_to_name  ,', ') > 0 OR
        INSTR(forwarded_by_name  ,', ') > 0 OR
        INSTR(group_supervisor_name  ,', ') > 0 OR
        INSTR(team_supervisor_name   ,', ') > 0 OR
        INSTR(owner_name         ,', ') > 0 OR
        INSTR(last_update_by_name,', ') > 0);
COMMIT;

