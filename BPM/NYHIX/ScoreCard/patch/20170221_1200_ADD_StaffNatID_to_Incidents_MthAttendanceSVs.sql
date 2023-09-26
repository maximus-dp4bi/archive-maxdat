--https://jira.maximus.com/browse/NYHIX-28085 SCORECARD_INCIDENTS_SV
CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_INCIDENTS_SV AS
With incidents as
 (
   SELECT a11.STAFF_ID as staff_staff_id,
          trunc(a11.TASK_START) AS_DATE,
          count((Case when a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) then 1 else null end)) INCIDENTS_COMPLETED,
          count((Case when a11.EVENT_ID in (1373) then 1 else null end)) DEFECTS_COMPLETED
     FROM MAXDAT.PP_WFM_ACTUALS_SV a11
    WHERE TRUNC(a11.task_start) >= TRUNC(SYSDATE-365) and trunc(a11.TASK_END)=trunc(a11.TASK_START)
      and (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) or
           a11.EVENT_ID in (1373))
      and trunc(a11.TASK_END)=trunc(a11.TASK_START)
    group by a11.staff_id, trunc(a11.TASK_START)
 )
 select a10.staff_staff_id, a10.staff_natid, a10.staff_staff_name, as_date, INCIDENTS_COMPLETED, DEFECTS_COMPLETED
 FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
 join incidents i on a10.staff_staff_id=i.staff_staff_id;
 
--https://jira.maximus.com/browse/NYHIX-28076 SCORECARD_ATTENDANCE_MTHLY_SV
create or replace view dp_scorecard.scorecard_attendance_mthly_sv as
select a11.MANAGER_STAFF_ID
,a11.MANAGER_NAME
,a11.SUPERVISOR_STAFF_ID
,a11.SUPERVISOR_NAME
,a11.STAFF_STAFF_ID
,a11.STAFF_STAFF_NAME
,a10.STAFF_NATID
,a11.DATES_MONTH
,a11.DATES_MONTH_NUM
,a11.DATES_YEAR
,a11.BALANCE
,a11.TOTAL_BALANCE
,a11.SC_ATTENDANCE_ID
 from dp_scorecard.scorecard_attendance_mthly a11
 join DP_SCORECARD.SCORECARD_HIERARCHY_SV a10 on a10.staff_staff_id=a11.staff_staff_id
with read only;
 
--https://jira.maximus.com/browse/NYHIX-29325
--SELECT * FROM DP_SCORECARD.SCORECARD_SUMMARY_TL_SV          --needed
CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_SUMMARY_TL_SV AS
WITH QC_metrics AS
 (
 select staff_staff_id,
           staff_staff_name,
           staff_natid,
           dates_month_num,
           dates_year,
           qcs_performed
      from dp_scorecard.scorecard_quality_tl_mthly_sv
 ),
ATTEND_Metrics AS
 (
  select staff_staff_id,
         staff_staff_name,
         dates_month,
         dates_month_num,
         dates_year,
         balance,
         total_balance,
         sc_attendance_id
    from dp_scorecard.scorecard_attendance_mthly_sv
 )
 SELECT
   all_staff.staff_staff_id,
   all_staff.staff_staff_name,
   all_staff.STAFF_NATID,
   all_staff.dates_month,
   all_staff.dates_month_num,
   all_staff.dates_year,
   am.balance,
   am.total_balance,
   qc.qcs_performed
 FROM (select distinct staff_staff_id,
         staff_staff_name,
         STAFF_NATID,
         dates_month,
         dates_month_num,
         dates_year from dp_scorecard.scorecard_attendance_mthly_sv
      ) all_staff
 left outer join ATTEND_Metrics am on all_staff.staff_staff_id = am.staff_staff_id and all_staff.dates_month_num=am.dates_month_num
 left outer join QC_metrics qc on all_staff.staff_staff_id = qc.staff_staff_id and all_staff.dates_month_num=qc.dates_month_num;

--SELECT * FROM DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV    --needed
create or replace view dp_scorecard.scorecard_attendance_score_sv as
With staff as
(
select
       manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       staff_natid,
       hire_date,
       0 as sc_attendance_id,
       hire_date as create_datetime
  from dp_scorecard.scorecard_hierarchy
)
, staff_starting_balance as
(
select manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       staff_natid,
       --hire_date as dates,
       coalesce(ais.start_date,hire_date) as dates,
       'Starting Balance' as absence_type,
       'Starting Balance' as absence_comment_type,
       --40 as point_value,
       coalesce(ais.attendance_points,40) as point_value,
       --40 as balance,
       coalesce(ais.attendance_points,40) as balance,
       --0 as incentive_balance,
       coalesce(ais.incentive_points,0) as incentive_balance,
       --40 as total_balance,
       (coalesce(ais.attendance_points,40) + coalesce(ais.incentive_points,0)) as total_balance,
       NULL as incentive_flag,
       NULL as comments,
       create_datetime,
       null as create_by,
       NULL as last_updated_by,
       null as LAST_UPDATED_DATETIME,
       sc_attendance_id
  from staff s
  left outer join dp_scorecard.sc_attendance_initial_score ais on s.staff_staff_id = ais.staff_id
),
sc_attend_entries as
(
select s.manager_staff_id,
       s.manager_name,
       s.supervisor_staff_id,
       s.supervisor_name,
       s.staff_staff_id,
       s.staff_staff_name,
       s.staff_natid,
       sca.entry_date as dates,
       sca.absence_type,
       sca.point_value,
       sca.balance,
       sca.incentive_balance,
       sca.total_balance,
       sca.incentive_flag,
       sca.sc_attendance_id,
       sca.create_datetime,
       sca.create_by,
       sca.last_updated_by,
       sca.LAST_UPDATED_DATETIME
  from staff s
inner join DP_SCORECARD.SC_ATTENDANCE sca
    on s.staff_staff_id = sca.staff_id
)
select manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       staff_natid,
       dates,
       absence_type,
       point_value,
       balance,
       incentive_balance,
       total_balance,
       incentive_flag,
       sc_attendance_id,
       create_datetime,
       create_by,
       last_updated_by,
       LAST_UPDATED_DATETIME
  from staff_starting_balance
union all
select manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       staff_natid,
       dates,
       absence_type,
       point_value,
       balance,
       incentive_balance,
       total_balance,
       incentive_flag,
       sc_attendance_id,
       create_datetime,
       create_by,
       last_updated_by,
       LAST_UPDATED_DATETIME
  from sc_attend_entries;


--SELECT * FROM DP_SCORECARD.SCORECARD_GOAL_SV                --needed 
create or replace view dp_scorecard.scorecard_goal_sv as
select
       sh.manager_staff_id,
       sh.manager_name,
       sh.supervisor_staff_id,
       sh.supervisor_name,
       sh.staff_staff_id,
       sh.staff_staff_name,
       sh.staff_natid,
       g.goal_id,
       g.staff_id,
       g.goal_entry_date,
       g.gtl_id,
       g.goal_description,
       g.goal_date,
       g.progress_note,
       g.create_by,
       g.create_datetime,
       g.last_updated_by,
       g.LAST_UPDATED_DATETIME
  from dp_scorecard.sc_goal g
  join dp_scorecard.sc_goal_type_lkup gtl on g.gtl_id=gtl.gtl_id
  join dp_scorecard.scorecard_hierarchy sh on g.staff_id=sh.staff_staff_id;



--SELECT * FROM DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV     --needed 
create or replace view dp_scorecard.scorecard_perform_tracker_sv as
select
           sh.manager_staff_id,
           sh.manager_name,
           sh.supervisor_staff_id,
           sh.supervisor_name,
           sh.staff_staff_id,
           sh.staff_staff_name,
           sh.staff_natid,
           pt.pt_id,
           pt.pt_entry_date,
           pt.dl_id,
           dl.discussion_topic,
           pt.comments,
           pt.create_by,
           pt.create_datetime,
           pt.last_updated_by,
           pt.LAST_UPDATED_DATETIME
    from dp_scorecard.sc_performance_tracker pt
    join dp_scorecard.sc_discussion_lkup dl on pt.dl_id=dl.dl_id
    join dp_scorecard.scorecard_hierarchy sh on pt.staff_id=sh.staff_staff_id;



--SELECT * FROM DP_SCORECARD.SCORECARD_PROD_BO_SV             --needed 
create or replace view dp_scorecard.scorecard_prod_bo_sv as
with total_logged as
(
select staff_id, dates, event_name_sort, event_name, metric as total_logged from dp_scorecard.sc_production_bo
where event_subname='Total Logged'
),
activity_time as
(
select staff_id, dates, event_name_sort, event_name, metric as activity_time from dp_scorecard.sc_production_bo
where event_subname='Total Activity Time'
),
targets as
(
select scorecard_group, target, ops_group, start_date, end_date from
    (select distinct
           case
             when upper(scorecard_group) like 'OTHER%' then
              'All Other Tasks'
             else
              scorecard_group
           end as scorecard_group,
           target,
           ops_group,
           start_date,
           end_date
      from maxdat.PP_BO_EVENT_TARGET_LKUP
     where SCORECARD_FLAG = 'Y')
)
select a10.staff_id,
       (select distinct staff_natid from dp_scorecard.scorecard_hierarchy_sv where staff_staff_id=a10.staff_id) as staff_natid,
       a10.dates,
       a10.event_name_sort as event_sort_id,
       a10.event_name,
       a10.total_logged,
       a11.activity_time,
       (to_char(trunc((a11.activity_time * 3600) / 3600), 'FM999999990') || ':' || to_char(trunc(mod((a11.activity_time * 3600), 3600) / 60), 'FM00') || ':' || to_char(mod((a11.activity_time * 3600), 60), 'FM00')) as activity_time_in_hhmmss,
       (select DISTINCT target from targets where scorecard_group = a10.event_name AND  a10.dates >= targets.start_date AND (targets.end_date IS NULL OR a10.dates <= targets.end_date) ) as target,
       (select DISTINCT ops_group from targets where scorecard_group = a10.event_name AND  a10.dates >= targets.start_date AND (targets.end_date IS NULL OR a10.dates <= targets.end_date) ) as ops_group
  from total_logged a10
  left outer join activity_time a11
    on a10.staff_id = a11.staff_id
   and a10.dates = a11.dates
   and a10.event_name = a11.event_name;


--SELECT * FROM DP_SCORECARD.SCORECARD_PRODUCTION_BO_SV       --needed 
create or replace view dp_scorecard.scorecard_production_bo_sv as
select staff_id,
       (select distinct staff_natid from dp_scorecard.scorecard_hierarchy_sv where staff_staff_id=staff_id) as staff_natid,
       dates,
       event_name_sort as sort_order,
       event_name,
       event_subname_sort,
       event_subname,
       case when event_subname = 'Total Logged' then to_char(metric)
         when event_subname = 'Total Activity Time' then
           to_char(trunc(round(metric * 3600,0)/3600), 'FM999999990')  || ':' || to_char(trunc(mod(round(metric * 3600,0),3600)/60), 'FM00') || ':' || to_char(mod(round(metric * 3600,0),60), 'FM00')
         else to_char((metric * 100), '999.99') || '%' end as metric
  from dp_scorecard.sc_production_bo;


--SELECT * FROM DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV   --needed 
create or replace view dp_scorecard.scorecard_summary_bo_events_sv as
select staff_id,
       (select distinct staff_natid from dp_scorecard.scorecard_hierarchy_sv where staff_staff_id=staff_id) as staff_natid,
       dates_month_num,
       dates_year,
       event_name_sort as sort_order,
       (event_name || ' >= 100%') as event_name,
       event_subname_sort,
       event_subname,
       to_char((metric * 100), '999.99') || '%' as metric
  from dp_scorecard.SC_SUMMARY_BO
 where (Event_subname = 'Task Production' or event_subname IS NULL);




--SELECT * FROM DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV      --needed
create or replace view dp_scorecard.scorecard_correct_action_sv as
select
          sh.manager_staff_id,
          sh.manager_name,
          sh.supervisor_staff_id,
          sh.supervisor_name,
          sh.staff_staff_id,
          sh.staff_staff_name,
          sh.staff_natid,
          ca.ca_id,
          ca.ca_entry_date,
          ca.cal_id,
          cal.correction_action_type,
          ca.unsatisfactory_behavior,
          ca.comments,
          ca.create_by,
          ca.create_datetime,
          ca.last_updated_by,
          ca.LAST_UPDATED_DATETIME
      from dp_scorecard.sc_corrective_action ca
      join dp_scorecard.sc_corrective_action_lkup cal on ca.cal_id=cal.cal_id
      join dp_scorecard.scorecard_hierarchy sh on ca.staff_id=sh.staff_staff_id;
      
--select * from dp_scorecard.scorecard_prod_dp_bo_sv  
create or replace view dp_scorecard.scorecard_prod_dp_bo_sv as
select dates, staff_id,  
(select distinct staff_natid from dp_scorecard.scorecard_hierarchy_sv where staff_staff_id=staff_id) as staff_natid,
event_name, event_name_sort as event_sort_id, metric as productivity from dp_scorecard.sc_production_bo
where event_name='Daily Production'
UNION
select da.dates, da.staff_id,  
(select distinct staff_natid from dp_scorecard.scorecard_hierarchy_sv where staff_staff_id=da.staff_id) as staff_natid,
da.event_name, da.event_name_sort as event_sort_id, da.metric as productivity
from dp_scorecard.sc_production_bo da
join
(
select dates, staff_id from dp_scorecard.sc_production_bo
where event_name='Daily Production'
) dp on da.dates=dp.dates and da.staff_id=dp.staff_id
where da.event_name='Daily Adherence';

 
