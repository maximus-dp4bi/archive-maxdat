-- Insert existing Task types with Unassigned Team Name

INSERT INTO D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Task Type", "Team Name")
select SEQ_DMWTT_ID.nextval, "Group Name", "Task Type", "Team Name"
  from 
(select "Group Name", "Task Type", 'UNASSIGNED' "Team Name"
  from d_mw_task_type
 Where "Team Name" != 'UNASSIGNED' 
 group by "Group Name", "Task Type" 
) a;


-- Following Script was used to update F_MW_BY_DATE table 
-- allowing deletion of record in D_MW_TASK_TYPE table

DECLARE
  Start_dt Date := sysdate; 
  End_Dt Date;
  New_Task_type_id number;
  
  BEGIN

     For I in ( Select DMWTT_ID Curr_task_type_id , "Group Name" Curr_Group_Name
                     , "Task Type" Curr_Task_Type, "Team Name" Curr_Team_Name
                  From D_MW_TASK_TYPE 
                 Where "Team Name" != 'UNASSIGNED' 
              )
     Loop

          -- Get New Task Type id value       
           Begin

              New_Task_type_id := null;
             
              Select MIN(DMWTT_ID) INTO New_Task_type_id
                From D_MW_TASK_TYPE s
               Where s."Group Name" = I.Curr_Group_Name
                 and s."Task Type"  = I.Curr_Task_Type
                 and "Team Name" = 'UNASSIGNED';
                 
            Exception when others then
               New_Task_type_id := null;               
             end;

           -- Update F_MW_BY_DATE table with New Task Type ID 
           
          If New_Task_type_id is not null  then 

           Update F_MW_BY_DATE
              Set DMWTT_ID = New_Task_type_id
            where DMWTT_ID = I.Curr_task_type_id;

            If sql%rowcount > 0 then 
                --dbms_output.put_line ('Updated '|| sql%rowcount ||' rows for DCN '|| I.CURR_TEAM_NAME );
                Delete From d_mw_task_type where DMWTT_ID = I.Curr_Task_Type_Id;
            end if;


          End if;   

          commit;
          
     End Loop;                 
                   

      dbms_output.put_line ('Process Started at :'|| to_char(Start_dt,'mm/dd/yyyy hh:mi:ss') || ' and  Ended at :'|| to_char(sysdate,'mm/dd/yyyy hh:mi:ss'));
  
    END;