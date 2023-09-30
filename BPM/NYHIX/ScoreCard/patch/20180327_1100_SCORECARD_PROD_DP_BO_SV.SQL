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
         and trunc(dates) >= trunc(sysdate - 31)
) dp
    on da.dates = dp.dates
   and da.staff_id = dp.staff_id
 where da.event_name = 'Daily Adherence'
UNION
SELECT dates, STAFF_ID, staff_natid, 
    'Daily Non-Activity Time' AS EVENT_NAME, 
    3 AS event_sort_ID,  
    SUM(metric) AS HANDEL_TIME_IN_SECONDS
FROM (
select dtls.dates,
       dtls.staff_id,
       (select distinct staff_natid
          from dp_scorecard.scorecard_hierarchy_sv
         where staff_staff_id = dtls.staff_id) as staff_natid,
       dtls.HANDLE_TIME_IN_seconds/86400 as METRIC
From
    ( select
        staff_id,
        event_id,
        event_date AS DATES,
        scorecard_group,
        sum(HANDLE_TIME_IN_SECONDS)	AS HANDLE_TIME_IN_seconds
	from DP_SCORECARD.PP_WFM_DAILY_SUMMARY_WRK
	where supervisor_staff_id is NOT NULL
    and scorecard_flag = 'N'
	and trunc(nvl(STAFF_TERMINATION_DATE,sysdate)) >= event_date
    and EVENT_DATE >= trunc(sysdate - 31)
--	and department is not null
--	and building is not null
	GROUP BY
       staff_id, 
        event_id,
        event_date,
        scorecard_group
	) Dtls
where 1=1
)
GROUP BY dates, STAFF_ID, staff_natid
--UNION
----			TOTAL_LOGGED_IN_TIME,
--select logged_date,
--       staff_id,
--       national_id, 
--       'Total Logged in Time' as event_name,
--       3 as event_sort_id,
--       total_logged_in_time as productivity
--  from DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME
--  where trunc(logged_date) >= trunc(sysdate - 31) 
--UNION
----			LUNCH_TIME,
--select logged_date,
--       staff_id,
--       national_id, 
--       'Lunch Time' as event_name,
--       3 as event_sort_id,
--       lunch_time as productivity
--  from DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME
--  where trunc(logged_date) >= trunc(sysdate - 31) 
--UNION
----			BREAK_TIME,
--select logged_date,
--       staff_id,
--       national_id, 
--       'Break Time' as event_name,
--       3 as event_sort_id,
--       break_time as productivity
--  from DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME
--  where trunc(logged_date) >= trunc(sysdate - 31) 
--UNION
----			TRAINING_TIME
--select logged_date,
--       staff_id,
--       national_id, 
--       'Training Time' as event_name,
--       3 as event_sort_id,
--       training_time as productivity
--  from DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME
--  where trunc(logged_date) >= trunc(sysdate - 31)
;


GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO MAXDAT_REPORTS;
