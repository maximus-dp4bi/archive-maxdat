DROP VIEW DP_SCORECARD.SCORECARD_PROD_BO_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_PROD_BO_SV
(STAFF_ID, STAFF_NATID, DATES, EVENT_SORT_ID, EVENT_NAME, 
 TOTAL_LOGGED, ACTIVITY_TIME, ACTIVITY_TIME_IN_HHMMSS, TARGET, OPS_GROUP)
AS 
with total_logged as
(
select staff_id, dates, event_name_sort, event_name, metric as total_logged from dp_scorecard.sc_production_bo
where event_subname='Total Logged' and trunc(dates) >= trunc(sysdate - 31)
),
activity_time as
(
select staff_id, dates, event_name_sort, event_name, metric as activity_time from dp_scorecard.sc_production_bo
where event_subname='Total Activity Time' and trunc(dates) >= trunc(sysdate - 31)
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


GRANT INSERT, SELECT, UPDATE ON DP_SCORECARD.SCORECARD_PROD_BO_SV TO DP_SCORECARD_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SCORECARD_PROD_BO_SV TO DP_SCORECARD_OLTP_SIUD;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_SV TO MAXDAT_READ_ONLY;