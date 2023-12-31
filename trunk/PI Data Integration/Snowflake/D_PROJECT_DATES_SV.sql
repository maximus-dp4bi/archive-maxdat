-- PUREINSIGHTS_DEV."PUBLIC".D_PROJECT_DATES_SV source

create or replace view D_PROJECT_DATES_SV as
WITH DT AS (
SELECT
	*
FROM
	DECISIONPOINT_DEV.PUBLIC.d_dates DT
CROSS JOIN DECISIONPOINT_DEV.CONFIG.C_PROJECTS PROJ
LEFT JOIN DECISIONPOINT_DEV.CONFIG.C_PROJECT_HOLIDAYS HOL   
    ON
	PROJ.PROJECT_ID = HOL.PROJECTID
	AND HOL.HOLIDAYDATE = DT.DATE),
HRS AS (
SELECT
	PROJECT_ID ,
	PROJECT_HOURS_START_DAY,
	PROJECT_HOURS_START_TIME ,
	PROJECT_HOURS_END_DAY,
	PROJECT_HOURS_END_TIME ,
	LEVEL AS DAYOFWEEK
FROM
	(
	SELECT
		LEVEL ,
		DAY
	FROM
		(
		SELECT
			'Day' DAY ) B
	CONNECT BY
		PRIOR LEVEL <= 6)DY,
	DECISIONPOINT_DEV.CONFIG.C_PROJECT_HOURS
WHERE
	LEVEL BETWEEN PROJECT_HOURS_START_DAY AND PROJECT_HOURS_END_DAY
),
OE AS (
SELECT
	PROJECT_ID ,
	OPEN_ENROLLMENT_START_DATE,
	OPEN_ENROLLMENT_END_dATE,
	PROJECT_OE_HOURS_START_TIME ,
	PROJECT_OE_HOURS_END_TIME ,
	PROJECT_OE_HOURS_START_DAY ,
	PROJECT_OE_HOURS_END_DAY,
	LEVEL AS DAYOFWEEK
FROM
	(
	SELECT
		LEVEL ,
		DAY
	FROM
		(
		SELECT
			'Day' DAY ) B
	CONNECT BY
		PRIOR LEVEL <= 6)DY,
	DECISIONPOINT_DEV.CONFIG.C_PROJECT_OPEN_ENROLLMENT_PERIOD
WHERE
	LEVEL BETWEEN PROJECT_OE_HOURS_START_DAY AND PROJECT_OE_HOURS_END_DAY)
SELECT
	DT.DATEID,
	DT.PROJECT_ID,
	DT.CONNECTIONPOINT_PROJECT_ID,
	DT.PUREINSIGHTS_PROJECT_ID,
	DT.PROJECT_NAME,
	DT.PROJECT_GO_LIVE_DATE,
	DT.PROJECT_TIME_ZONE,
	DT.DAYNAME,
	DT.DAYOFMONTH,
	DT.DAYOFWEEK,
	DAYOFYEAR,
	DT.MONTH,
	DT.MONTHNUMBER,
	DT.MONTHSTARTDAY,
	DT.MONTHENDDAY,
	DT.WEEKOFMONTH,
	DT.WEEKOFYEAR,
	DT.WEEKSTARTDAY,
	DT.WEEKENDDAY,
	DT.YEAR,
	DT.YEARSTARTDAY,
	DT.YEARENDDAY,
	DT.QUARTER,
	DT.QUARTERNUMBER,
	DT.QUARTERSTARTDAY,
	DT.QUARTERENDDAY,
	DT.LASTYEARDAY,
	DT.DATE,
	DT.LASTQUARTERDAY,
	DT.LASTMONTHDAY,
	DT.LASTWEEKDAY,
	DT.LAST90DAY,
	DT.LAST30DAY,
	DT.LAST7DAY,
	DT.PREVIOUSDAY,
	DT.DAYOFQUARTER,
	DT.WEEKOFQUARTER,
	DT.DAYNAMELONG,
	DT.MONTHLONG,
	CASE
		WHEN DT.DAYOFWEEK = 1
		OR DT.DAYOFWEEK = 7 THEN 'Y'
		ELSE 'N'
	END AS WEEKEND_FLAG,
	CASE
		WHEN DT.HOLIDAYID IS NOT NULL THEN 'Y'
		ELSE 'N'
	END AS HOLIDAY_FLAG,
	CASE
		WHEN COALESCE (HRS.PROJECT_HOURS_START_DAY,
		OE.PROJECT_OE_HOURS_START_DAY) IS NULL
		OR COALESCE (HRS.PROJECT_HOURS_END_DAY,
		OE.PROJECT_OE_HOURS_END_DAY) IS NULL
		OR DT.DAYOFWEEK < HRS.PROJECT_HOURS_START_DAY
		OR DT.DAYOFWEEK > HRS.PROJECT_HOURS_END_DAY
		OR DT.HOLIDAYID IS NOT NULL THEN 'N'
		ELSE 'Y'
	END AS BUSINESS_DAY_FLAG,
	CASE
		WHEN DT."DATE" BETWEEN OE.OPEN_ENROLLMENT_START_DATE AND OE.OPEN_ENROLLMENT_END_DATE
THEN OE.PROJECT_OE_HOURS_START_TIME
		ELSE HRS.PROJECT_HOURS_START_TIME
	END AS PROJECT_HOURS_START_TIME,
	CASE
		WHEN DT."DATE" BETWEEN OE.OPEN_ENROLLMENT_START_DATE AND OE.OPEN_ENROLLMENT_END_DATE
THEN OE.PROJECT_OE_HOURS_END_TIME
		ELSE HRS.PROJECT_HOURS_END_TIME
	END AS PROJECT_HOURS_END_TIME
FROM
	DT
LEFT OUTER JOIN HRS ON
	DT.PROJECT_ID = HRS.PROJECT_ID
	AND DT.DAYOFWEEK = HRS.DAYOFWEEK
LEFT OUTER JOIN OE ON
	DT.PROJECT_ID = OE.PROJECT_ID
	AND (DT."YEAR" || MONTHNUMBER = YEAR(OE.OPEN_ENROLLMENT_START_DATE)|| MONTH(OE.OPEN_ENROLLMENT_START_DATE)
		OR DT."YEAR" || MONTHNUMBER = YEAR(OE.OPEN_ENROLLMENT_END_DATE)|| MONTH(OE.OPEN_ENROLLMENT_END_DATE))
	AND DT.DAYOFWEEK = OE.DAYOFWEEK
ORDER BY
	DT.PROJECT_ID,
	DT."DATE";