
UPDATE DP_SCORECARD.SC_PERFORMANCE_TRACKER
SET DL_ID = 31,
	last_updated_by = 'CR 1653',  -- NYHIX-33518
	last_Updated_datetime = sysdate
WHERE DL_ID = 51;

COMMIT;

UPDATE DP_SCORECARD.SC_DISCUSSION_LKUP
SET END_DATE = SYSDATE -1 
WHERE DL_ID = 51;

COMMIT;

DROP  VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_SV;


CREATE VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_SV
AS WITH ATTEND_Metrics AS
  (
   select a.staff_staff_id,
          a.staff_staff_name,
          h.staff_natid,
          a.dates_month,
          a.dates_month_num,
          a.dates_year,
          a.balance,
          a.total_balance,
          a.sc_attendance_id
     from dp_scorecard.scorecard_attendance_mthly_sv a
     join dp_scorecard.scorecard_hierarchy_sv h on a.staff_staff_id=h.staff_staff_id
  ),
  PERMFORM_TKR as
 (
   select distinct staff_staff_id,
                  to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
                  to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
                  max(case when discussion_topic = 'Corrective Action' then 1 else 0 end )      as corrective_action_flag,
                  max(case when discussion_topic = 'One on One' then 1 else 0 end )             as one_on_one_flag,
                  max(case when discussion_topic = 'Observation' then 1 else 0 end )            as observation_flag,
                  max(case when discussion_topic = 'Recorded Call Review' then 1 else 0 end )   as Recorded_Call_Review_flag,
                  max(case when discussion_topic = 'Real Time Phone Observation' then 1 else 0 end ) as Live_Phone_Observation_flag
    from dp_scorecard.scorecard_perform_tracker_sv PERF
    where discussion_topic in (
                    'Corrective Action',
                    'One on One',
                    'Observation',
                    'Recorded Call Review',
                    'Real Time Phone Observation'
                    )
   group by staff_staff_id,
            to_char(TRUNC(pt_entry_date),'YYYYMM'),
            to_char(TRUNC(pt_entry_date), 'Month YYYY')
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
        a11.balance,
        a11.total_balance,
        a10.adherence,
        COALESCE(a10.corrective_action_flag,0) as corrective_action_flag ,
        COALESCE(a10.one_on_one_flag,0) as one_on_one_flag,
        COALESCE(a10.observation_flag,0) as observation_flag,
        NVL(PT.Recorded_Call_Review_flag,0)     as Recorded_Call_Review_flag,
        NVL(PT.Live_Phone_Observation_flag,0)       as Live_Phone_Observation_flag
        from ATTEND_Metrics a11
   LEFT OUTER JOIN dp_scorecard.sc_summary_cc a10 ON a11.staff_staff_id=a10.staff_staff_id
   and  a11.dates_month_num=a10.dates_month_num
   LEFT OUTER JOIN PERMFORM_TKR PT ON a11.staff_staff_id=pt.staff_staff_id
   and  a11.dates_month_num=pt.dates_month_num;
