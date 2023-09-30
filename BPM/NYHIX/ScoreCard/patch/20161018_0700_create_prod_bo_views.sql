
CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_PROD_BO_MTHLY_SV
AS
with total_logged as
(
select staff_id, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort/*event_subname_sort*/, metric as total_logged from dp_scorecard.sc_summary_bo
where event_subname='Total Logged'
),
activity_time as
(
select staff_id, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort/*event_subname_sort*/, metric as activity_time from dp_scorecard.sc_summary_bo
where event_subname='Total Activity Time'
),
targets as
(
select scorecard_group, target, ops_group from
    (select distinct
           case
             when upper(scorecard_group) like 'OTHER%' then
              'All Other Tasks'
             else
              scorecard_group
           end as scorecard_group,
           target,
           ops_group
      from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
     where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))
)
select a10.staff_id,
       a10.month_id,
       a10.month_name,
       a10.event_name_sort as event_sort_id,
       a10.event_name || ' >= 100%' as event_name,
       a10.total_logged,
       a11.activity_time,
       (to_char(trunc((a11.activity_time * 3600) / 3600), 'FM999999990') || ':' || to_char(trunc(mod((a11.activity_time * 3600), 3600) / 60), 'FM00') || ':' || to_char(mod((a11.activity_time * 3600), 60), 'FM00')) as activity_time_in_hhmmss,
       (select target from targets where scorecard_group = a10.event_name) as target,
       (select ops_group from targets where scorecard_group = a10.event_name) as ops_group
  from total_logged a10
  left outer join activity_time a11
    on a10.staff_id = a11.staff_id
   and a10.month_id = a11.month_id
   and a10.event_name = a11.event_name
;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_MTHLY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_MTHLY_SV TO MAXDAT;


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
select scorecard_group, target, ops_group from
    (select distinct
           case
             when upper(scorecard_group) like 'OTHER%' then
              'All Other Tasks'
             else
              scorecard_group
           end as scorecard_group,
           target,
           ops_group
      from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
     where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))
)
select a10.staff_id,
       a10.dates,
       a10.event_name_sort as event_sort_id,
       a10.event_name,
       a10.total_logged,
       a11.activity_time,
       (to_char(trunc((a11.activity_time * 3600) / 3600), 'FM999999990') || ':' || to_char(trunc(mod((a11.activity_time * 3600), 3600) / 60), 'FM00') || ':' || to_char(mod((a11.activity_time * 3600), 60), 'FM00')) as activity_time_in_hhmmss,
       (select target from targets where scorecard_group = a10.event_name) as target,
       (select ops_group from targets where scorecard_group = a10.event_name) as ops_group
  from total_logged a10
  left outer join activity_time a11
    on a10.staff_id = a11.staff_id
   and a10.dates = a11.dates
   and a10.event_name = a11.event_name
;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_SV TO MAXDAT;



