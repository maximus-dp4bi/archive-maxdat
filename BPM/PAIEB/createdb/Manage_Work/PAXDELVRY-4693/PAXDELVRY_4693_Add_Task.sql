/*##https://jira.maximus.com/browse/PAXDELIVRY-4693
#alter session set current_schema = maxdat_support
*/

insert into maxdat_support.d_task_types(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work)
values(40137614,'Manual PC Outreach Task','Manual PC Outreach Task','Outreach Team',48,'H',1,1,'PA Manual Task');
Commit;





