DROP VIEW DP_SCORECARD.SCORECARD_PROD_DP_BO_SV;

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
 where da.event_name = 'Daily Adherence';


GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO MAXDAT_READ_ONLY;
