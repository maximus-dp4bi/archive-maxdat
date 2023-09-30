CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV
(STAFF_ID, STAFF_NATID, DATES_MONTH_NUM, DATES_YEAR, SORT_ORDER, 
 EVENT_NAME, EVENT_SUBNAME_SORT, EVENT_SUBNAME, METRIC)
AS 
select staff_id,
       (select distinct staff_natid from dp_scorecard.scorecard_hierarchy_sv where staff_staff_id=staff_id) as staff_natid,
       dates_month_num,
       dates_year,
       event_name_sort as sort_order,
       --(event_name || ' >= 100%') as event_name, -- removed by NYHIX-40286
       event_name,
       event_subname_sort,
       event_subname,
       to_char((metric * 100), '999.99') || '%' as metric
  from dp_scorecard.SC_SUMMARY_BO
 where (Event_subname = 'Task Production' or event_subname IS NULL);


GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV TO DP_SCORECARD_READ_ONLY;

--------------------------------------------------------------------------
--------------------------------------------------------------------------


CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_PROD_BO_MTHLY_SV
(STAFF_ID, STAFF_NATID, MONTH_ID, MONTH_NAME, EVENT_SORT_ID, 
 EVENT_NAME, TOTAL_LOGGED, ACTIVITY_TIME, ACTIVITY_TIME_IN_HHMMSS, TARGET, 
 OPS_GROUP)
AS 
with total_logged as
(
select staff_id, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort, metric as total_logged from dp_scorecard.sc_summary_bo
where event_subname='Total Logged'
),
activity_time as
(
select staff_id, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort, metric as activity_time from dp_scorecard.sc_summary_bo
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
       (select staff_natid from dp_scorecard.scorecard_hierarchy_sv where staff_staff_id=a10.staff_id) as staff_natid,
       a10.month_id,
       a10.month_name,
       a10.event_name_sort as event_sort_id,
 --      a10.event_name || ' >= 100%' as event_name, -- removed by NYHIX-40286
       a10.event_name,
       a10.total_logged,
       a11.activity_time,
       (to_char(trunc((a11.activity_time * 3600) / 3600), 'FM999999990') || ':' || to_char(trunc(mod((a11.activity_time * 3600), 3600) / 60), 'FM00') || ':' || to_char(mod((a11.activity_time * 3600), 60), 'FM00')) as activity_time_in_hhmmss,
       (select DISTINCT target from targets where scorecard_group = a10.event_name AND  a10.month_id >= to_char(targets.start_date,'YYYYMM') AND (targets.end_date IS NULL OR a10.month_id <= to_char(targets.end_date,'YYYYMM')) ) as target,
       (select DISTINCT ops_group from targets where scorecard_group = a10.event_name AND  a10.month_id >= to_char(targets.start_date,'YYYYMM') AND (targets.end_date IS NULL OR a10.month_id <= to_char(targets.end_date,'YYYYMM')) ) as ops_group
  from total_logged a10
  left outer join activity_time a11
    on a10.staff_id = a11.staff_id
   and a10.month_id = a11.month_id
   and a10.event_name = a11.event_name;


GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_MTHLY_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_MTHLY_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_MTHLY_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_MTHLY_SV TO MAXDAT_REPORTS;

-------------------------------------------------------------------------
-------------------------------------------------------------------------

CREATE or replace VIEW DP_SCORECARD.SCORECARD_PROD_BO_ROLLUP_SV
AS with total_logged as
(
select supervisor_staff_id, department, building, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort, metric as total_logged, 0 AS activity_time, 0 AS staff_count from dp_scorecard.sc_summary_bo_rollup
where event_subname='Total Logged'
UNION
select supervisor_staff_id, department, building, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort, 0 as total_logged, metric as activity_time, 0 AS staff_count from dp_scorecard.sc_summary_bo_rollup
where event_subname='Total Activity Time'
UNION
select supervisor_staff_id, department, building, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort, 0 as total_logged, 0 AS activity_time, metric as staff_count from dp_scorecard.sc_summary_bo_rollup
where event_subname='Staff Count'
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
select DISTINCT
       a10.supervisor_staff_id,
       a10.department,
       a10.building,
       a10.month_id,
       a10.month_name,
       a10.event_name_sort as event_sort_id,
     --  a10.event_name || ' >= 100%' as event_name, -- removed by NYHIX-40286
       a10.event_name,
       sum(a10.total_logged) as total_logged,
       sum(a10.activity_time) as activity_time,
       sum(a10.staff_count) as staff_count,
       (to_char(trunc((sum(a10.activity_time) * 3600) / 3600), 'FM999999990') || ':' || to_char(trunc(mod((sum(a10.activity_time) * 3600), 3600) / 60), 'FM00') || ':' || to_char(mod((sum(a10.activity_time) * 3600), 60), 'FM00')) as activity_time_in_hhmmss,
       (select DISTINCT target from targets where scorecard_group = a10.event_name AND  a10.month_id >= to_char(targets.start_date,'YYYYMM') AND (targets.end_date IS NULL OR a10.month_id <= to_char(targets.end_date,'YYYYMM')) ) as target,
       (select DISTINCT ops_group from targets where scorecard_group = a10.event_name AND  a10.month_id >= to_char(targets.start_date,'YYYYMM') AND (targets.end_date IS NULL OR a10.month_id <= to_char(targets.end_date,'YYYYMM')) ) as ops_group
  from total_logged a10
  GROUP BY        a10.supervisor_staff_id,
       a10.department,
       a10.building,
       a10.month_id,
       a10.month_name,
       a10.event_name_sort,
       a10.event_name;


GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_ROLLUP_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_ROLLUP_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_ROLLUP_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_ROLLUP_SV TO MAXDAT;

