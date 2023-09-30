/*
Created on 25-Sep-2014 by Raj A.
Description:
This script populates the SLA days attributes from Corp_etl_list_lkup into D_MW_V2_Task_Type.
Added error logging as some task_names are erroring out due to 'Exact fetch returns multiple rows' error.
*/
declare
v_operations_group  d_task_types.operations_group%type;
v_sla_days          d_task_types.sla_days%type;
v_sla_days_type     d_task_types.sla_days_type%type;
v_sla_target_days   d_task_types.sla_target_days%type;
v_sla_jeopardy_days d_task_types.sla_jeopardy_days%type;

begin

for cur_rec in (select * 
                  from d_task_types                  
        				 where (operations_group is null or
                        sla_days is null or
                        sla_days_type is null or
                        sla_target_days is null or
                        sla_jeopardy_days is null
                        )
                  -- and task_name = 'Re-verification Manual Task'    
                  --and task_name NOT IN ('General Reminder Task')              
                  )
loop

v_operations_group := null;
v_sla_days          := null;
v_sla_days_type     := null;
v_sla_target_days   := null;
v_sla_jeopardy_days := null;

     begin
        select distinct ops_group
         INTO v_operations_group
         FROM bpm_d_ops_group_task b,
              step_definition_stg def
       WHERE 1=1
         AND b.task_type = def.NAME
         and def.display_name = cur_rec.task_name;
       
     exception 
     when no_data_found then null;
     when TOO_MANY_ROWS then 
     corp_etl_stage_pkg.log_etl_critical(in_job_name => 'DEPLOYMENT_SCRIPT'
                                          ,in_process_name => 'POP_D_MW_V2_TASK_TYPE'
                                          ,in_nr_of_error  => null
                                          ,in_error_desc   =>   'STEP_DEFINITION_ID'||cur_rec.task_type_id
                                          ,in_error_field  => null
                                          ,in_error_codes  => null
                                          ,in_driver_table_name => 'D_TASK_TYPES'
                                          ,in_driver_key_number => cur_rec.task_name                                          
                                          );
     end;
       
     begin 
       select out_var
         into v_sla_days
         from corp_etl_list_lkup 
        where 1=1
         --and value = cur_rec.task_name
         and ref_id = cur_rec.task_type_id       
         and name = 'ManageWork_SLA_Days';              
      
      exception when no_data_found then null;
     end;           
     
      begin 
       select out_var
         into v_sla_days_type
         from corp_etl_list_lkup 
        where 1=1
         --and value = cur_rec.task_name
         and ref_id = cur_rec.task_type_id       
         and name = 'ManageWork_SLA_Days_Type';              
      
      exception when no_data_found then null;
     end;
     
      begin 
       select out_var
         into v_sla_target_days
         from corp_etl_list_lkup 
        where 1=1
        -- and value = cur_rec.task_name
         and ref_id = cur_rec.task_type_id       
         and name = 'ManageWork_SLA_Target_Days';              
      
      exception when no_data_found then null;
     end;
     
      begin 
       select out_var
         into v_sla_jeopardy_days
         from corp_etl_list_lkup 
        where 1=1
         --and value = cur_rec.task_name
         and ref_id = cur_rec.task_type_id       
         and name = 'ManageWork_SLA_Jeopardy_Days';              
      
      exception when no_data_found then null;
     end;
     
     update d_task_types
        set operations_group    = v_operations_group,
            sla_days          = v_sla_days,
            sla_days_type     = v_sla_days_type,
            sla_target_days   = v_sla_target_days,
            sla_jeopardy_days = v_sla_jeopardy_days
		 where 1=1
       --and task_name = cur_rec.task_name
       and task_type_id = cur_rec.task_type_id;
     commit;
      	  
end loop;

end;
/