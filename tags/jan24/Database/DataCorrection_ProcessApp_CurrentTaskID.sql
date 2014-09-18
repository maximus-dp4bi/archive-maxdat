/* Update All completed application, Set Current_task_id = NULL */

update Process_App_Stg set current_task_id = null 
 where app_status like 'Completed%' and current_Task_id is not null;

update nyec_etl_process_app set current_task_id = null 
 where app_status like 'Completed%' and current_Task_id is not null;

/* Update All Inprocess application and set Current_Task_id with a  'HUMAN_TASK' or 'VIRTUAL_HUMAN_TASK'  task that is open
 --If one does not exist, it will be null */

Declare 
 v_current_task_id number := 0;
BEGIN

For I in (select app_id, current_task_id from process_app_stg where app_status = 'In Process')
loop

         v_current_task_id := I.current_task_id;

          SELECT MAX(step_instance_id) INTO v_current_task_id
            FROM Step_Instance_Stg s , step_definition_stg sd  
          WHERE s.step_definition_id = sd.step_definition_id
            AND s.Ref_type = 'APP_HEADER' AND s.Ref_id = I.App_ID 
            AND s.Status NOT IN ('TERMINATED','COMPLETED')
            AND sd.step_type_cd IN ('HUMAN_TASK','VIRTUAL_HUMAN_TASK')
            AND exists ( select 'x' from Step_Instance_Stg s1
					                 where s.step_instance_id = s1.step_instance_id
						              having s.step_instance_history_id = max(s1.step_instance_history_id));

          IF nvl(I.current_task_id,'9999999999') != nvl(v_current_task_id,'9999999999') THEN
          
             update process_app_stg set current_task_id = v_current_task_id where app_id = I.app_id;
             update nyec_etl_process_app set current_task_id = v_current_task_id where app_id = I.app_id;             
          
          END IF;

End loop;

COMMIT;

END; 

/