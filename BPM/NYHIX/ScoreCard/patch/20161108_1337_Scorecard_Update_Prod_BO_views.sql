CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_PROD_BO_SV
AS
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

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_SV TO MAXDAT_READ_ONLY;



CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_PROD_BO_MTHLY_SV
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
       a10.event_name || ' >= 100%' as event_name,
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

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_MTHLY_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_MTHLY_SV TO MAXDAT_READ_ONLY;

