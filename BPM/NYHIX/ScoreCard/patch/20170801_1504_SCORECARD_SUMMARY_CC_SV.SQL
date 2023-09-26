CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_SV
AS WITH ATTEND_Metrics AS
  (
   select a.staff_staff_id,
          a.staff_staff_name,
          h.staff_natid,
          a.dates_month,
          a.dates_month_num,
          a.dates_year,
     --     a.balance,
     --     a.total_balance,
          a.sc_attendance_id
     from dp_scorecard.scorecard_attendance_mthly_sv a
     join dp_scorecard.scorecard_hierarchy_sv h on a.staff_staff_id=h.staff_staff_id
  )
 select distinct a11.staff_staff_id,
        a11.staff_staff_name,
        a11.staff_natid,
        a11.dates_month,
        a11.dates_month_num,
        a11.dates_year,
        a10.exclusion_flag,
        a10.tot_calls_answered,
        a10.tot_short_calls_answered,
        a10.tot_tot_return_to_queue,
        (a10.tot_tot_return_to_queue + a10.Tot_Return_to_Queue_Timeout) as Tot_Ret_to_Queue_Total ,
        a10.tot_average_handle_time,
        a10.tot_sched_productive_time,
        a10.tot_actual_productive_time,
        a10.tot_talk_time,
        a10.tot_wrap_up_time,
        a10.tot_logged_in_time,
        a10.tot_not_ready_time,
        a10.tot_break_time,
        a10.tot_lunch_time,
        a10.qcs_performed,
        a10.avg_qc_score,
        a10.tot_incidents_completed,
        a10.days_incidents_completed,
        a10.tot_defects_completed,
        a10.days_defects_completed,
        a10.lag_time_tot_sched_prod_time,
        a10.tot_call_records,
        a10.tot_customer_count,
        a10.tot_call_wrap_up_count,
        a10.tot_wrap_up_error,
        a10.days_short_calls_gt_10,
        a10.days_calls_answered,
        a10.avg_attendance_balance      as balance,
        a10.avg_attendance_total_balance               as total_balance,
        a10.adherence,
        COALESCE(corrective_action_flag,0) as corrective_action_flag ,
        COALESCE(one_on_one_flag,0) as one_on_one_flag,
        COALESCE(observation_flag,0) as observation_flag,
        nvl(Recorded_Call_Review_flag,0)    as Recorded_Call_Review_flag,
        nvl(Live_Phone_Observation_flag,0)  Live_Phone_Observation_flag,        
        COALESCE(mer_flag,0) as mer_flag
        from ATTEND_Metrics a11
   LEFT OUTER JOIN dp_scorecard.sc_summary_cc a10 ON a11.staff_staff_id=a10.staff_staff_id
   and  a11.dates_month_num=a10.dates_month_num;
   
grant select on   DP_SCORECARD.SCORECARD_SUMMARY_CC_SV to maxdat;
 
grant select on   DP_SCORECARD.SCORECARD_SUMMARY_CC_SV to maxdat_read_only;
