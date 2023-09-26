

create or replace view dp_scorecard.scorecard_perf_track_mthly_sv as
WITH Corr_Action as
 (
   select distinct staff_staff_id,
                  to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
                  to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
                  1 as corrective_action_flag
    from dp_scorecard.scorecard_perform_tracker_sv
   where DL_ID in (select dl_id
                     from dp_scorecard.scorecard_discussion_lkup_sv
                    where discussion_topic = 'Corrective Action')
 ),
 One_on_one as
 (
   select distinct staff_staff_id,
                  to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
                  to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
                  1 as one_on_one_flag
    from dp_scorecard.scorecard_perform_tracker_sv
   where DL_ID in (select dl_id
                     from dp_scorecard.scorecard_discussion_lkup_sv
                    where discussion_topic = 'One on One')
 ),
 Observation as
 (
   select distinct staff_staff_id,
                  to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
                  to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
                  1 as observation_flag
    from dp_scorecard.scorecard_perform_tracker_sv
   where DL_ID in (select dl_id
                     from dp_scorecard.scorecard_discussion_lkup_sv
                    where discussion_topic = 'Observation')
 ),
 MER as
 (
   select distinct staff_staff_id,
                  to_char(TRUNC(pt_entry_date), 'YYYYMM') as dates_month_num,
                  to_char(TRUNC(pt_entry_date), 'Month YYYY') as dates_year,
                  1 as mer_flag
    from dp_scorecard.scorecard_perform_tracker_sv
   where DL_ID in (select dl_id
                     from dp_scorecard.scorecard_discussion_lkup_sv
                    where discussion_topic = 'MER')
 )
 SELECT
   distinct all_staff.staff_staff_id,
   all_staff.staff_staff_name,
   all_staff.staff_natid,
   all_staff.dates_month,
   all_staff.dates_month_num,
   all_staff.dates_year,
  coalesce(ca.corrective_action_flag,0) as corrective_action_flag,
   coalesce(ooo.one_on_one_flag,0) as one_on_one_flag,
   coalesce(o.observation_flag,0) as observation_flag,
   coalesce(m.mer_flag,0) as mer_flag
 FROM (select distinct a.staff_staff_id,
         a.staff_staff_name,
         a.staff_natid,
         a.dates_month,
         a.dates_month_num,
         a.dates_year from dp_scorecard.scorecard_attendance_mthly_sv a
         join (select distinct staff_id,month_id from dp_scorecard.scorecard_prod_bo_mthly_sv) b on a.staff_staff_id=b.staff_id and b.month_id=a.dates_month_num
         ) all_staff
left outer join Corr_Action ca on all_staff.staff_staff_id = ca.staff_staff_id and all_staff.dates_month_num=ca.dates_month_num
left outer join One_on_one ooo on all_staff.staff_staff_id = ooo.staff_staff_id and all_staff.dates_month_num=ooo.dates_month_num
left outer join Observation o on all_staff.staff_staff_id = o.staff_staff_id and all_staff.dates_month_num=o.dates_month_num
left outer join MER m on all_staff.staff_staff_id = m.staff_staff_id and all_staff.dates_month_num=m.dates_month_num;

GRANT select on DP_SCORECARD.scorecard_perf_track_mthly_sv to MAXDAT_READ_ONLY; 
GRANT select on DP_SCORECARD.scorecard_perf_track_mthly_sv to MAXDAT; 

commit; 



