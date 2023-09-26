
update d_task_types
set sla_days_type = 'B'
,sla_days = 1
,sla_target_days = 1
,sla_jeopardy_days = 0
,unit_of_work = task_name
,operations_group = 'Doc Processing'
where task_type_id in(15,9);

update d_task_types
set sla_days_type = 'B'
,sla_days = 2
,sla_target_days = 2
,sla_jeopardy_days = 1
,unit_of_work = task_name
,operations_group = 'Data Entry'
where task_type_id in(1,2,10,3);

update d_task_types
set sla_days_type = 'B'
,sla_days = 2
,sla_target_days = 2
,sla_jeopardy_days = 1
,unit_of_work = task_name
,operations_group = 'Eligibility'
where task_type_id in(5,7);

update d_task_types
set sla_days_type = 'B'
,sla_days = 2
,sla_target_days = 2
,sla_jeopardy_days = 1
,unit_of_work = task_name
,operations_group = 'Enrollment'
where task_type_id in(13);

update d_task_types
set sla_days_type = 'B'
,sla_days = 2
,sla_target_days = 2
,sla_jeopardy_days = 1
,unit_of_work = task_name
,operations_group = 'Quality Control'
where task_type_id in(11);


begin 
for x in(
select t.team_id,m.task_id
from arena_staff_stg s
  join d_teams t on to_number(s.sup_staff_id) = t.team_supervisor_staff_id
  join corp_etl_mw m on m.owner_staff_id = to_number(s.staff_id)) loop

 update corp_etl_mw
 set team_id = x.team_id
 where task_id = x.task_id;
 
 update d_mw_task_instance
 set curr_team_id = x.team_id
 where task_id = x.task_id;
 
 update d_mw_task_history
 set team_id = x.team_id
 where mw_bi_id in(select mw_bi_id from d_mw_task_instance where task_id = x.task_id);
 
end loop;
end;  
/
delete from bpm_update_event_queue;

commit;

 update D_MW_TASK_INSTANCE
    set
      AGE_IN_BUSINESS_DAYS = mw.GET_AGE_IN_BUSINESS_DAYS(CURR_WORK_RECEIPT_DATE,INSTANCE_END_DATE),
      AGE_IN_CALENDAR_DAYS = mw.GET_AGE_IN_CALENDAR_DAYS(CURR_WORK_RECEIPT_DATE,INSTANCE_END_DATE),
      JEOPARDY_FLAG = mw.GET_JEOPARDY_FLAG(TASK_TYPE_ID,
                                        CURR_WORK_RECEIPT_DATE,
                                        INSTANCE_END_DATE
                                       ),
      STATUS_AGE_IN_BUS_DAYS = mw.GET_STATUS_AGE_IN_BUS_DAYS(CURR_STATUS_DATE,INSTANCE_END_DATE),
      STATUS_AGE_IN_CAL_DAYS = mw.GET_STATUS_AGE_IN_CAL_DAYS(CURR_STATUS_DATE,INSTANCE_END_DATE),
      TIMELINESS_STATUS = mw.GET_TIMELINESS_STATUS(
                             INSTANCE_END_DATE,
                             TASK_TYPE_ID,
                             CURR_WORK_RECEIPT_DATE
                             )
    ;
    
commit;    