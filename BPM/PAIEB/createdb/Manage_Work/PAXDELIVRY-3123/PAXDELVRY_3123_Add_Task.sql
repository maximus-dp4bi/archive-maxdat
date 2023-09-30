/*##PAXDELIVRY-3123
#alter session set current_schema = maxdat_support
*/

insert into maxdat_support.d_task_types(task_type_id,task_name,task_description,operations_group,sla_days,sla_days_type,sla_target_days,sla_jeopardy_days,unit_of_work)
values(40138065,'In Person Visit Pre Health Assessment Survey Task','In Person Visit Pre Health Assessment Survey Task','Call Center',48,'H',1,1,'PA IEB Tasks');
Commit;





