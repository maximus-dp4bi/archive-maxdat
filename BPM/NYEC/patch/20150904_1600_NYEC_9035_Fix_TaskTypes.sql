BEGIN

Insert into d_mw_task_type (DMWTT_ID, "Group Name", "Group Parent Name", "Group Supervisor Name"
                          , "Task Type", "Team Name", "Team Parent Name", "Team Supervisor Name")
select SEQ_DMWTT_ID.nextval, "Group Name", "Group Parent Name", "Group Supervisor Name"
       , 'State Review Task - TPHI' "Task Type", "Team Name", "Team Parent Name", "Team Supervisor Name"
  from d_mw_task_type
  where "Group Name" = 'State Eligibility Unit'
    and "Task Type" = 'State Review Task - Ineligible Member';

Update d_mw_task_type
   set "Task Type" = 'State Review Task - Budget Ineligible'
 where "Group Name" = 'State Eligibility Unit'
   and "Task Type" = 'State Review Task - Ineligible Member';
   
update bpm_d_ops_group_task
  set Task_Type = 'State Review Task - Budget Ineligible'   
where ops_group = 'State Review'
and Task_Type = 'State Review Task - Ineligible Member' ;  
   
Insert into bpm_d_ops_group_task (ops_group, Task_Type)
values ('State Review','State Review Task - TPHI');

COMMIT;

END;
