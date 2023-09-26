--DROP VIEW DP_SCORECARD.SCORECARD_PROD_DP_BO_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_PROD_DP_BO_SV
(DATES, STAFF_ID, STAFF_NATID, EVENT_NAME, EVENT_SORT_ID, 
 PRODUCTIVITY)
AS 
select dates,
       staff_id,
       (select distinct staff_natid
          from dp_scorecard.scorecard_hierarchy_sv
         where staff_staff_id = staff_id) as staff_natid,
       event_name,
       event_name_sort as event_sort_id,
       metric as productivity
  from dp_scorecard.sc_production_bo
 where event_name = 'Daily Production'
 and trunc(dates) >= trunc(sysdate - 31)
UNION
select da.dates,
       da.staff_id,
       (select distinct staff_natid
          from dp_scorecard.scorecard_hierarchy_sv
         where staff_staff_id = da.staff_id) as staff_natid,
       da.event_name,
       da.event_name_sort as event_sort_id,
       da.metric as productivity
  from dp_scorecard.sc_production_bo da
  join (select dates, staff_id
          from dp_scorecard.sc_production_bo
         where event_name = 'Daily Production'
         and trunc(dates) >= trunc(sysdate - 31)) dp
    on da.dates = dp.dates
   and da.staff_id = dp.staff_id
 where da.event_name = 'Daily Adherence'
UNION
--			TOTAL_LOGGED_IN_TIME,
select logged_date,
       staff_id,
       national_id, 
       'Total Logged in Time' as event_name,
       3 as event_sort_id,
       total_logged_in_time as productivity
  from DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME
  where trunc(logged_date) >= trunc(sysdate - 31) 
UNION
--			LUNCH_TIME,
select logged_date,
       staff_id,
       national_id, 
       'Lunch Time' as event_name,
       3 as event_sort_id,
       lunch_time as productivity
  from DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME
  where trunc(logged_date) >= trunc(sysdate - 31) 
UNION
--			BREAK_TIME,
select logged_date,
       staff_id,
       national_id, 
       'Break Time' as event_name,
       3 as event_sort_id,
       break_time as productivity
  from DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME
  where trunc(logged_date) >= trunc(sysdate - 31) 
UNION
--			TRAINING_TIME
select logged_date,
       staff_id,
       national_id, 
       'Training Time' as event_name,
       3 as event_sort_id,
       training_time as productivity
  from DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME
  where trunc(logged_date) >= trunc(sysdate - 31);


GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO MAXDAT_REPORTS;