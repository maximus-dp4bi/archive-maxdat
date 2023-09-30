DROP TABLE DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME CASCADE CONSTRAINTS;

CREATE TABLE DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME
(
  NATIONAL_ID           VARCHAR2(250 BYTE),
  STAFF_ID              NUMBER(38),
  LOGGED_DATE           DATE,
  TOTAL_LOGGED_IN_TIME  NUMBER(10,2),
  LUNCH_TIME            NUMBER(10,2),
  BREAK_TIME            NUMBER(10,2),
  TRAINING_TIME         NUMBER(10,2),
  DAILY_PRODUCTION      NUMBER,
  DAILY_ADHERENCE       NUMBER
)
TABLESPACE MAXDAT_DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


CREATE INDEX DP_SCORECARD.PP_WFM_LOGGED_IN_TM_IDX1 ON DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME
(NATIONAL_ID)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

CREATE INDEX DP_SCORECARD.PP_WFM_LOGGED_IN_TM_IDX2 ON DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME
(STAFF_ID)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

CREATE INDEX DP_SCORECARD.PP_WFM_LOGGED_IN_TM_IDX3 ON DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME
(LOGGED_DATE)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

GRANT SELECT ON DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME TO DP_SCORECARD_READ_ONLY;

--------------------------------------------------------------------
--------------------------------------------------------------------

--DROP VIEW DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME_SV
(NATIONAL_ID, STAFF_ID, LOGGED_DATE, TOTAL_LOGGED_IN_TIME, LUNCH_TIME, 
 BREAK_TIME, TRAINING_TIME, DAILY_PRODUCTION, DAILY_ADHERENCE)
AS 
SELECT NATIONAL_ID,STAFF_ID,LOGGED_DATE,TOTAL_LOGGED_IN_TIME,LUNCH_TIME,BREAK_TIME,TRAINING_TIME, 
			DAILY_PRODUCTION,
			DAILY_ADHERENCE
FROM DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME;


GRANT SELECT ON DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME TO DP_SCORECARD_READ_ONLY;

---------------------------------------------------------------------
---------------------------------------------------------------------

-- DROP VIEW DP_SCORECARD.SCORECARD_PROD_DP_BO_SV;

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


GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO MAXDAT_READ_ONLY;


