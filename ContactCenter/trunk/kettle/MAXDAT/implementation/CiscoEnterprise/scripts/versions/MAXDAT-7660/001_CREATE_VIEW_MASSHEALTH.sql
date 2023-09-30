alter session set current_schema = cisco_enterprise_cc;

create or replace view CC_F_QINTERVAL_MASSHEALTH_SV
  AS select
   dt.d_date as "Date"
   ,i.interval_start_time_of_day24 as "Interval_Start_Time"
   ,q.queue_number as "Queue_ID"
   ,q.queue_name as "Queue_Name"
   ,q.queue_type as "Queue_Type"
   ,f.contacts_offered as "Offered"
   ,f.calls_answered as "Answered"
   ,f.answer_wait_time_total "Answer_Wait_Time"
   ,f.talk_time_total as "Talk_Time"
   ,f.hold_time_total as "Hold_Time"
   ,f.after_call_work_time_total as "Wrap_Time"
   ,f.contacts_abandoned as "Contacts_Abandoned"
   ,f.incomplete_calls + f.short_calls + f.calls_routed_non_agent + f.calls_rona + f.return_release + f.agent_error_count + f.error_count +
    f.icr_default_routed + f.network_default_routed + f.return_busy + f.return_ring as "Call_Error"
   ,f.contacts_abandoned - f.abandon_threshold as "Contacts_Aband_>30sec"
   ,f.abandon_time_total as "Time_to_Abandon"
 from
   cisco_enterprise_cc.cc_f_actuals_queue_interval f
 inner join
   cisco_enterprise_cc.cc_d_contact_queue q on f.d_contact_queue_id = q.d_contact_queue_id
 inner join
   cisco_enterprise_cc.cc_d_dates dt on f.d_date_id = dt.d_date_id
 inner join
   cisco_enterprise_cc.cc_d_interval i on f.d_interval_id = i.d_interval_id
 inner join
   cisco_enterprise_cc.cc_d_project pj on q.d_project_id = pj.project_id
 inner join
   cisco_enterprise_cc.cc_d_program pg on q.d_program_id = pg.program_id
 where
   pj.project_name = 'Mass Health';
    
GRANT SELECT ON CC_F_QINTERVAL_MASSHEALTH_SV TO MASSHEALTH_VIEW_S;
GRANT SELECT ON CC_F_QINTERVAL_MASSHEALTH_SV TO MAXDAT_READ_ONLY;