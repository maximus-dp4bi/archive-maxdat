
 DECLARE  
  CURSOR temp_cur IS
   select task_id, created_by_name,escalated_to_name,forwarded_by_name,group_supervisor_name,last_update_by_name,owner_name,team_supervisor_name
   from corp_etl_manage_work
   where 1=1
   --and task_id = 55249857
   and (complete_date is  not null or cancel_work_date is not null)
   --and (complete_date is  null and cancel_work_date is  null)
   and (  (created_by_name = 'UNKNOWN' or created_by_name = ', ') 
   or  (owner_name = 'UNKNOWN' or owner_name = ', ')
 --  or (escalated_to_name = 'UNKNOWN' or escalated_to_name = ', ')
 --  or   (forwarded_by_name = 'UNKNOWN' or forwarded_by_name = ', ')
   or (group_supervisor_name = 'UNKNOWN' or group_supervisor_name = ', ')
   or (last_update_by_name  = 'UNKNOWN' or last_update_by_name = ', ')   
   or (team_supervisor_name = 'UNKNOWN' or team_supervisor_name = ', ')
   )   
   ;    

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;
  v_group_supervisor_name VARCHAR2(200);
  v_team_supervisor_name VARCHAR2(200);
  v_created_by_name VARCHAR2(200);
  v_escalated_to_name VARCHAR2(200);
  v_forwarded_by_name VARCHAR2(200);
  v_owner_name VARCHAR2(200);
  v_last_update_by_name VARCHAR2(200);
BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FOR indx IN 1..temp_tab.COUNT LOOP
         
         v_group_supervisor_name := temp_tab(indx).group_supervisor_name;
         v_team_supervisor_name := temp_tab(indx).team_supervisor_name;
         v_created_by_name := temp_tab(indx).created_by_name;
         v_escalated_to_name := temp_tab(indx).escalated_to_name;
         v_forwarded_by_name := temp_tab(indx).forwarded_by_name;
         v_owner_name := temp_tab(indx).owner_name;
         v_last_update_by_name := temp_tab(indx).last_update_by_name;
         
         FOR si IN (SELECT step_instance_id, hist_status,
                          CASE WHEN G1.SUPERVISOR_STAFF_ID IS NULL THEN 'UNKNOWN' ELSE S1s.LAST_NAME||', '||S1s.FIRST_NAME END GROUP_SUPERVISOR_NAME,
                          CASE WHEN G3.SUPERVISOR_STAFF_ID IS NULL THEN 'UNKNOWN' ELSE S2s.LAST_NAME||', '||S2s.FIRST_NAME END TEAM_SUPERVISOR_NAME,
                          CASE WHEN si.created_by IS NULL THEN 'UNKNOWN' ELSE S3s.LAST_NAME||', '||S3s.FIRST_NAME END CREATED_BY_NAME,
                          CASE WHEN si.escalate_to IS NULL THEN 'UNKNOWN' ELSE S4s.LAST_NAME||', '||S4s.FIRST_NAME END ESCALATED_TO_NAME,
                          CASE WHEN SI.FORWARDED_BY IS NULL THEN 'UNKNOWN' ELSE S5s.LAST_NAME||', '||S5s.FIRST_NAME END FORWARDED_BY_NAME,
                          CASE WHEN SI.OWNER IS NULL THEN 'UNKNOWN' ELSE S6s.LAST_NAME||', '||S6s.FIRST_NAME END OWNER_NAME,
                          CASE WHEN SI.HIST_CREATE_BY IS NULL THEN 'UNKNOWN' ELSE S7s.LAST_NAME||', '||S7s.FIRST_NAME END LAST_UPDATE_BY_NAME 
                    FROM STEP_INSTANCE_stg SI   
                      LEFT JOIN STEP_DEFINITION_STG SD ON SD.STEP_DEFINITION_ID  = SI.STEP_DEFINITION_ID
                      LEFT OUTER JOIN GROUPS_STG G1 ON G1.GROUP_ID = SI.GROUP_ID
                      LEFT OUTER JOIN GROUPS_STG G3 ON G3.GROUP_ID = SI.TEAM_ID    
                      LEFT JOIN STAFF_stg S1s ON cast(S1s.STAFF_ID as Char(8)) = cast(G1.SUPERVISOR_STAFF_ID as Char(8))
                      LEFT JOIN STAFF_stg S2s ON cast(S2s.STAFF_ID as Char(8)) = cast(G3.SUPERVISOR_STAFF_ID as Char(8))
                      LEFT JOIN STAFF_stg S3s ON cast(S3s.STAFF_ID as Char(8)) = cast(SI.CREATED_BY as Char(8))
                      LEFT JOIN STAFF_stg S4s ON cast(S4s.STAFF_ID as Char(8)) = cast(SI.ESCALATE_TO as Char(8))
                      LEFT JOIN STAFF_stg S5s ON cast(S5s.STAFF_ID as Char(8)) = cast(SI.FORWARDED_BY as Char(8))
                      LEFT JOIN STAFF_stg S6s ON cast(S6s.STAFF_ID as Char(8)) = cast(SI.OWNER as Char(8))
                      LEFT JOIN STAFF_stg S7s ON cast(S7s.STAFF_ID as Char(8)) = cast(SI.HIST_CREATE_BY as Char(8))         
                    WHERE step_instance_id = temp_tab(indx).task_id
                    ORDER BY DECODE(hist_status,'COMPLETED',1,'TERMINATED',2,'CLAIMED',3,4)asc,HIST_CREATE_TS desc,step_instance_history_id desc)
          LOOP
            v_group_supervisor_name := si.GROUP_SUPERVISOR_NAME;
            v_team_supervisor_name := si.TEAM_SUPERVISOR_NAME;
            v_created_by_name := si.CREATED_BY_NAME;
            v_escalated_to_name := si.ESCALATED_TO_NAME;
            v_forwarded_by_name := si.FORWARDED_BY_NAME;
            v_owner_name := si.OWNER_NAME;
            v_last_update_by_name := si.LAST_UPDATE_BY_NAME;
            exit; -- get the latest record only
          END LOOP;
    
       
          IF temp_tab(indx).created_by_name = 'UNKNOWN' or temp_tab(indx).created_by_name = ', ' THEN
            temp_tab(indx).created_by_name := v_created_by_name;
          END IF;  
          
     /*     IF temp_tab(indx).escalated_to_name = 'UNKNOWN' or temp_tab(indx).escalated_to_name = ', ' THEN
            temp_tab(indx).escalated_to_name := v_escalated_to_name;
          END IF;  
        
          IF temp_tab(indx).forwarded_by_name = 'UNKNOWN' or temp_tab(indx).forwarded_by_name = ', ' THEN
            temp_tab(indx).forwarded_by_name := v_forwarded_by_name;
          END IF;  */

          IF temp_tab(indx).group_supervisor_name = 'UNKNOWN' or temp_tab(indx).group_supervisor_name = ', ' THEN
            temp_tab(indx).group_supervisor_name := v_group_supervisor_name;
          END IF;  
        
          IF temp_tab(indx).team_supervisor_name = 'UNKNOWN' or temp_tab(indx).team_supervisor_name = ', ' THEN
            temp_tab(indx).team_supervisor_name := v_team_supervisor_name;
          END IF;  
        
          IF temp_tab(indx).last_update_by_name = 'UNKNOWN' or temp_tab(indx).last_update_by_name = ', ' THEN
            temp_tab(indx).last_update_by_name := v_last_update_by_name;
          END IF;  
          
          IF temp_tab(indx).owner_name = 'UNKNOWN' or temp_tab(indx).owner_name = ', ' THEN
            temp_tab(indx).owner_name := v_owner_name;
          END IF;  
                
         update corp_etl_manage_work
          set created_by_name = temp_tab(indx).created_by_name
          --    ,escalated_to_name = temp_tab(indx).escalated_to_name
          --    ,forwarded_by_name = temp_tab(indx).forwarded_by_name
              ,group_supervisor_name = temp_tab(indx).group_supervisor_name
              ,last_update_by_name = temp_tab(indx).last_update_by_name
              ,owner_name = temp_tab(indx).owner_name
              ,team_supervisor_name = temp_tab(indx).team_supervisor_name
		     where task_id = temp_tab(indx).task_id;		  
      END LOOP;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;