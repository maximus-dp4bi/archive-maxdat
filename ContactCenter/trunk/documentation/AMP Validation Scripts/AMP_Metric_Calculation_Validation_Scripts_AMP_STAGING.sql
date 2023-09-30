

variable start_date VARCHAR2;
exec :start_date := '06/01/2014';

variable end_date VARCHAR2;
exec :end_date := '06/30/2014';

variable project_name VARCHAR2;
exec :project_name := 'IL'


----------------------------------------------------------------------------------------------------------
--CC_F_ACTUALS_IVR_INTERVAL-------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

--CALLS_CREATED
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, SUM(CONTACTS_CREATED) as CALLS_CREATED
FROM CC_F_ACTUALS_IVR_INTERVAL aii
INNER JOIN D_PROJECT proj on aii.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on aii.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_DATES dd on aii.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--CALLS_CONTAINED_IN_IVR
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, SUM(CONTACTS_CONTAINED_IN_IVR) as CALLS_CONTAINED_IN_IVR
FROM CC_F_ACTUALS_IVR_INTERVAL aii
INNER JOIN D_PROJECT proj on aii.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on aii.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_DATES dd on aii.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

----------------------------------------------------------------------------------------------------------
--CC_F_ACTUALS_QUEUE_INTERVAL-----------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

--CALLS_OFFERED
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, SUM(CONTACTS_OFFERED) AS CALLS_OFFERED
FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_CONTACT_QUEUE cq on faqi.D_CONTACT_QUEUE_ID = cq.D_CONTACT_QUEUE_ID
INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND cq.QUEUE_TYPE = 'Inbound'
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--CALLS_HANDLED
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, SUM(CONTACTS_HANDLED) AS CALLS_HANDLED
FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_CONTACT_QUEUE cq on faqi.D_CONTACT_QUEUE_ID = cq.D_CONTACT_QUEUE_ID
INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND cq.QUEUE_TYPE = 'Inbound'
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--WEB_CHATS_OFFERED
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, SUM(CONTACTS_OFFERED) AS WEB_CHATS_OFFERED
FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_CONTACT_QUEUE cq on faqi.D_CONTACT_QUEUE_ID = cq.D_CONTACT_QUEUE_ID
INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND cq.QUEUE_TYPE = 'Web Chat'
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--WEB_CHATS_HANDLED
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, SUM(CONTACTS_HANDLED) AS WEB_CHATS_HANDLED
FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_CONTACT_QUEUE cq on faqi.D_CONTACT_QUEUE_ID = cq.D_CONTACT_QUEUE_ID
INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND cq.QUEUE_TYPE = 'Web Chat'
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--VOICEMAILS_OFFERED
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, SUM(CONTACTS_OFFERED) AS VOICEMAILS_OFFERED
FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_CONTACT_QUEUE cq on faqi.D_CONTACT_QUEUE_ID = cq.D_CONTACT_QUEUE_ID
INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND cq.QUEUE_TYPE = 'VMail'
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--VOICEMAILS_HANDLED
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, SUM(CONTACTS_HANDLED) AS VOICEMAILS_HANDLED
FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_CONTACT_QUEUE cq on faqi.D_CONTACT_QUEUE_ID = cq.D_CONTACT_QUEUE_ID
INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND cq.QUEUE_TYPE = 'VMail'
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--OUTBOUND_CALLS_ATTEMPTED
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, SUM(CONTACTS_OFFERED) AS OUTBOUND_CALLS_ATTEMPTED
FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_CONTACT_QUEUE cq on faqi.D_CONTACT_QUEUE_ID = cq.D_CONTACT_QUEUE_ID
INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND cq.QUEUE_TYPE = 'Outbound'
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--PEAK_DAY_PERCENTAGE
--**WEEKLY-ONLY METRIC**
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(PROGRAM_NAME,0,10) PROGRAM_NAME
  , (((MAX(sub.CONTACTS_OFFERED)/SUM(CONTACTS_OFFERED)))*100) as PEAK_DAY_PERCENTAGE
FROM (
  SELECT dd.D_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, sum(faqi.CONTACTS_OFFERED) as CONTACTS_OFFERED, sum(faqi.CONTACTS_HANDLED) as CONTACTS_HANDLED
  FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
  INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
  INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
  INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
  INNER JOIN CC_D_CONTACT_QUEUE cq on faqi.d_contact_queue_id = cq.d_contact_queue_id
  WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
  AND QUEUE_TYPE = 'Inbound'
  AND proj.PROJECT_NAME LIKE :project_name||'%'
  GROUP  BY dd.D_DATE, proj.PROJECT_NAME, prog.PROGRAM_NAME
  HAVING ((SUM(faqi.CONTACTS_HANDLED) > 0) AND (SUM(faqi.CONTACTS_OFFERED) > 0))
  ) sub
GROUP BY sub.PROJECT_NAME, sub.PROGRAM_NAME;

--PEAK_WEEK_PERCENTAGE
--**MONTHLY-ONLY METRIC**
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(supaSub.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(supaSub.PROGRAM_NAME,0,10) PROGRAM_NAME
  , ((MAX(supaSub.WEEKLY_CONTACTS_OFFERED)/supaSub.TOTAL_CONTACTS_OFFERED)*100) as PEAK_WEEK_PERCENTAGE
FROM (
    SELECT sub.PROJECT_NAME, sub.PROGRAM_NAME, sub.WEEK_OF_YR
      ,SUM(CONTACTS_OFFERED) as WEEKLY_CONTACTS_OFFERED, SUM(SUM(CONTACTS_OFFERED)) OVER (PARTITION BY sub.PROJECT_NAME, sub.PROGRAM_NAME) as TOTAL_CONTACTS_OFFERED
    FROM (
      SELECT dd.D_DATE, to_number(to_char(dd.D_DATE+1,'IW')) as WEEK_OF_YR, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, sum(faqi.CONTACTS_OFFERED) as CONTACTS_OFFERED, sum(faqi.CONTACTS_HANDLED) as CONTACTS_HANDLED
      FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
      INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
      INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
      INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
      INNER JOIN CC_D_CONTACT_QUEUE cq on faqi.d_contact_queue_id = cq.d_contact_queue_id
      WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
      AND QUEUE_TYPE = 'Inbound'
      AND proj.PROJECT_NAME LIKE :project_name||'%'
      GROUP  BY dd.D_DATE, to_number(to_char(dd.D_DATE+1,'IW')), proj.PROJECT_NAME, prog.PROGRAM_NAME
      HAVING ((SUM(faqi.CONTACTS_HANDLED) > 0) AND (SUM(faqi.CONTACTS_OFFERED) > 0))
      ) sub
    GROUP BY sub.PROJECT_NAME, sub.PROGRAM_NAME, sub.WEEK_OF_YR) supaSub
GROUP BY supaSub.PROJECT_NAME, supaSub.PROGRAM_NAME, supaSub.TOTAL_CONTACTS_OFFERED;

--AVERAGE_HANDLE_TIME  
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME
	, (SUM((TALK_TIME_TOTAL + HOLD_TIME_TOTAL + AFTER_CALL_WORK_TIME_TOTAL))/SUM(CONTACTS_HANDLED)) AS AVG_HANDLE_TIME
FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--MAX_HANDLE_TIME  
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, MAX(MAX_HANDLE_TIME) as MAX_HANDLE_TIME
FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--AVERAGE_SPEED_TO_ANSWER
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME
	, (SUM(ANSWER_WAIT_TIME_TOTAL)/SUM(CONTACTS_HANDLED)) AS AVG_SPEED_TO_ANSWER
FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--MAX_SPEED_TO_ANSWER
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, MAX(MAX_SPEED_OF_ANSWER) as MAX_SPEED_TO_ANSWER
FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--AB_RATE
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME
	, ((SUM(CONTACTS_ABANDONED)/SUM(CONTACTS_OFFERED))*100) AS AB_RATE
FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_CONTACT_QUEUE cq on faqi.D_CONTACT_QUEUE_ID = cq.D_CONTACT_QUEUE_ID
INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND cq.QUEUE_TYPE = 'Inbound'
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--AVERAGE_TIME_CLIENTS_WAIT_BEFORE_ABANDON
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME
	, (SUM(ABANDON_TIME_TOTAL)/SUM(CONTACTS_ABANDONED)) AS AVERAGE_ABANDON_WAIT_TIME
FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

----------------------------------------------------------------------------------------------------------
--CC_F_AGENT_BY_DATE--------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

--OCCUPANCY
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME
	, ((SUM(HANDLE_TIME_SECONDS)/SUM(LOGIN_SECONDS))*100) AS OCCUPANCY
FROM CC_F_AGENT_BY_DATE abd
INNER JOIN CC_D_PROJECT_TARGETS dpt on abd.D_PROJECT_TARGETS_ID = dpt.D_PROJECT_TARGETS_ID
INNER JOIN D_PROJECT proj on dpt.PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on abd.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_DATES dd on abd.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--UTILIZATION
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME
	, (((SUM(HANDLE_TIME_SECONDS)+SUM(IDLE_SECONDS))/SUM(LOGIN_SECONDS))*100) AS UTILIZATION
FROM CC_F_AGENT_BY_DATE abd
INNER JOIN CC_D_PROJECT_TARGETS dpt on abd.D_PROJECT_TARGETS_ID = dpt.D_PROJECT_TARGETS_ID
INNER JOIN D_PROJECT proj on dpt.PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on abd.D_PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_DATES dd on abd.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;


--MAX_NUM_OF_AGENTS_ON_PAYROLL
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME
  , MAX(sub.AGENT_PAYROLL_DAILY_COUNT) as MAX_NUM_AGENTS_ON_PAYROLL
FROM (
  SELECT dd.D_DATE
    , da.D_PROJECT_ID
    , COALESCE(abd.D_PROGRAM_ID, 0) as D_PROGRAM_ID
    , COALESCE(abd.D_GEOGRAPHY_MASTER_ID, 0) as D_GEOGRAPHY_MASTER_ID
    , COUNT(DISTINCT da.LOGIN_ID) as AGENT_PAYROLL_DAILY_COUNT
  FROM CC_D_AGENT da
  CROSS JOIN CC_D_DATES dd
  LEFT JOIN CC_F_AGENT_BY_DATE abd on da.D_AGENT_ID = abd.D_AGENT_ID
  WHERE da.D_AGENT_ID <> 0
  AND D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') and to_date(:end_date,'mm/dd/yyyy')
  AND (da.HIRE_DATE <= D_DATE AND (TERMINATION_DATE >= D_DATE OR TERMINATION_DATE IS NULL))
  GROUP BY dd.D_DATE, da.D_PROJECT_ID, abd.D_PROGRAM_ID, abd.D_GEOGRAPHY_MASTER_ID
  )sub
INNER JOIN D_PROJECT proj on sub.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on sub.D_PROGRAM_ID = prog.D_PROGRAM_ID
WHERE PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;


--MAX_NUM_OF_AGENTS_IN_TRAINING
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(PROGRAM_NAME,0,10) PROGRAM_NAME
  , COALESCE(MAX(sub.training_agent_count_by_date),0) AS MAX_TRAINING_AGENTS
FROM (
    SELECT proj.PROJECT_NAME, prog.PROGRAM_NAME, dd.D_DATE, COUNT(DISTINCT(aabd.D_AGENT_ID)) as training_agent_count_by_date
    FROM CC_F_AGENT_ACTIVITY_BY_DATE aabd
    INNER JOIN D_PROJECT proj on aabd.D_PROJECT_ID = proj.D_PROJECT_ID
    INNER JOIN D_PROGRAM prog on aabd.D_PROGRAM_ID = prog.D_PROGRAM_ID
    INNER JOIN CC_D_ACTIVITY_TYPE at on aabd.D_ACTIVITY_TYPE_ID = at.D_ACTIVITY_TYPE_ID
    INNER JOIN CC_D_DATES dd on aabd.D_DATE_ID = dd.D_DATE_ID
    WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
    AND at.ACTIVITY_TYPE_CATEGORY = 'Training'
    AND proj.PROJECT_NAME LIKE :project_name||'%'
    GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME, dd.D_DATE
    )sub 
GROUP BY sub.PROJECT_NAME, sub.PROGRAM_NAME;


--MAX_NUM_OF_AGENTS_SCHEDULED_TO_HANDLE_CONTACTS
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(PROGRAM_NAME,0,10) PROGRAM_NAME
  , COALESCE(MAX(sub.scheduled_agent_count_by_date),0) AS MAX_SCHEDULED_AGENTS
FROM (
    SELECT proj.PROJECT_NAME, prog.PROGRAM_NAME, dd.D_DATE, COUNT(DISTINCT(abd.D_AGENT_ID)) as scheduled_agent_count_by_date
    FROM CC_F_AGENT_BY_DATE abd
    INNER JOIN CC_D_PROJECT_TARGETS dpt on abd.D_PROJECT_TARGETS_ID = dpt.D_PROJECT_TARGETS_ID
    INNER JOIN D_PROJECT proj on dpt.PROJECT_ID = proj.D_PROJECT_ID
    INNER JOIN D_PROGRAM prog on abd.D_PROGRAM_ID = prog.D_PROGRAM_ID
    INNER JOIN CC_D_DATES dd on abd.D_DATE_ID = dd.D_DATE_ID
    WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
    AND abd.SCHEDULED_SHIFT_MINUTES > 0
    AND proj.PROJECT_NAME LIKE :project_name||'%'
    GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME, dd.D_DATE
    )sub 
GROUP BY sub.PROJECT_NAME, sub.PROGRAM_NAME;

----------------------------------------------------------------------------------------------------------
--CC_F_AGENT_ACTIVITY_BY_DATE-----------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------


--MAX_NUM_OF_AGENTS_AVAILABLE
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(PROGRAM_NAME,0,10) PROGRAM_NAME
  , COALESCE(MAX(sub.avail_agent_count_by_date),0) AS MAX_AVAIL_AGENTS
FROM (
    SELECT proj.PROJECT_NAME, prog.PROGRAM_NAME, dd.D_DATE, COUNT(DISTINCT(aabd.D_AGENT_ID)) as avail_agent_count_by_date
    FROM CC_F_AGENT_ACTIVITY_BY_DATE aabd
    INNER JOIN D_PROJECT proj on aabd.D_PROJECT_ID = proj.D_PROJECT_ID
    INNER JOIN D_PROGRAM prog on aabd.D_PROGRAM_ID = prog.D_PROGRAM_ID
    INNER JOIN CC_D_ACTIVITY_TYPE at on aabd.D_ACTIVITY_TYPE_ID = at.D_ACTIVITY_TYPE_ID
    INNER JOIN CC_D_DATES dd on aabd.D_DATE_ID = dd.D_DATE_ID
    WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
    AND at.IS_AVAILABLE_FLAG = '1'
    AND proj.PROJECT_NAME LIKE :project_name||'%'
    GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME, dd.D_DATE
    )sub 
GROUP BY sub.PROJECT_NAME, sub.PROGRAM_NAME;

--UNPLANNED_ABSENTEEISM_PERCENTAGE
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(PROGRAM_NAME,0,10) PROGRAM_NAME
  , ((COALESCE(SUM(sub.UNPLANNED_PTO_MINS),0)/SUM(ACTIVITY_MINUTES))*100) AS UNPLANNED_ABSENT_PERCENTAGE
FROM CC_F_AGENT_ACTIVITY_BY_DATE aabd
  INNER JOIN D_PROJECT proj on aabd.D_PROJECT_ID = proj.D_PROJECT_ID
  INNER JOIN D_PROGRAM prog on aabd.D_PROGRAM_ID = prog.D_PROGRAM_ID
  INNER JOIN CC_D_ACTIVITY_TYPE at on aabd.D_ACTIVITY_TYPE_ID = at.D_ACTIVITY_TYPE_ID
  INNER JOIN CC_D_DATES dd on aabd.D_DATE_ID = dd.D_DATE_ID
  LEFT JOIN (
    SELECT aabd.F_AGENT_ACTIVITY_BY_DATE_ID, ACTIVITY_MINUTES AS UNPLANNED_PTO_MINS
    FROM CC_F_AGENT_ACTIVITY_BY_DATE aabd
    INNER JOIN D_PROJECT proj on aabd.D_PROJECT_ID = proj.D_PROJECT_ID
    INNER JOIN D_PROGRAM prog on aabd.D_PROGRAM_ID = prog.D_PROGRAM_ID
    INNER JOIN CC_D_ACTIVITY_TYPE at on aabd.D_ACTIVITY_TYPE_ID = at.D_ACTIVITY_TYPE_ID
    INNER JOIN CC_D_DATES dd on aabd.D_DATE_ID = dd.D_DATE_ID
    WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
    AND at.ACTIVITY_TYPE_CATEGORY = 'Unscheduled PTO'
  ) sub on (aabd.F_AGENT_ACTIVITY_BY_DATE_ID = sub.F_AGENT_ACTIVITY_BY_DATE_ID)
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--PLANNED_ABSENTEEISM_PERCENTAGE
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(PROGRAM_NAME,0,10) PROGRAM_NAME
  , ((COALESCE(SUM(sub.PLANNED_PTO_MINS),0)/SUM(ACTIVITY_MINUTES))*100) AS PLANNED_ABSENT_PERCENTAGE
FROM CC_F_AGENT_ACTIVITY_BY_DATE aabd
  INNER JOIN D_PROJECT proj on aabd.D_PROJECT_ID = proj.D_PROJECT_ID
  INNER JOIN D_PROGRAM prog on aabd.D_PROGRAM_ID = prog.D_PROGRAM_ID
  INNER JOIN CC_D_ACTIVITY_TYPE at on aabd.D_ACTIVITY_TYPE_ID = at.D_ACTIVITY_TYPE_ID
  INNER JOIN CC_D_DATES dd on aabd.D_DATE_ID = dd.D_DATE_ID
  LEFT JOIN (
    SELECT aabd.F_AGENT_ACTIVITY_BY_DATE_ID, ACTIVITY_MINUTES AS PLANNED_PTO_MINS
    FROM CC_F_AGENT_ACTIVITY_BY_DATE aabd
    INNER JOIN D_PROJECT proj on aabd.D_PROJECT_ID = proj.D_PROJECT_ID
    INNER JOIN D_PROGRAM prog on aabd.D_PROGRAM_ID = prog.D_PROGRAM_ID
    INNER JOIN CC_D_ACTIVITY_TYPE at on aabd.D_ACTIVITY_TYPE_ID = at.D_ACTIVITY_TYPE_ID
    INNER JOIN CC_D_DATES dd on aabd.D_DATE_ID = dd.D_DATE_ID
    WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
    AND at.ACTIVITY_TYPE_CATEGORY = 'Scheduled PTO'
  ) sub on (aabd.F_AGENT_ACTIVITY_BY_DATE_ID = sub.F_AGENT_ACTIVITY_BY_DATE_ID)
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--PLANNED_UNPAID_ABSENTEEISM_PERCENTAGE
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(PROGRAM_NAME,0,10) PROGRAM_NAME
  , ((COALESCE(SUM(sub.PLANNED_PTO_MINS),0)/SUM(ACTIVITY_MINUTES))*100) AS PLANNED_UNPAID_ABSENT_PCT
FROM CC_F_AGENT_ACTIVITY_BY_DATE aabd
  INNER JOIN D_PROJECT proj on aabd.D_PROJECT_ID = proj.D_PROJECT_ID
  INNER JOIN D_PROGRAM prog on aabd.D_PROGRAM_ID = prog.D_PROGRAM_ID
  INNER JOIN CC_D_ACTIVITY_TYPE at on aabd.D_ACTIVITY_TYPE_ID = at.D_ACTIVITY_TYPE_ID
  INNER JOIN CC_D_DATES dd on aabd.D_DATE_ID = dd.D_DATE_ID
  LEFT JOIN (
    SELECT aabd.F_AGENT_ACTIVITY_BY_DATE_ID, ACTIVITY_MINUTES AS PLANNED_PTO_MINS
    FROM CC_F_AGENT_ACTIVITY_BY_DATE aabd
    INNER JOIN D_PROJECT proj on aabd.D_PROJECT_ID = proj.D_PROJECT_ID
    INNER JOIN D_PROGRAM prog on aabd.D_PROGRAM_ID = prog.D_PROGRAM_ID
    INNER JOIN CC_D_ACTIVITY_TYPE at on aabd.D_ACTIVITY_TYPE_ID = at.D_ACTIVITY_TYPE_ID
    INNER JOIN CC_D_DATES dd on aabd.D_DATE_ID = dd.D_DATE_ID
    WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
    AND at.ACTIVITY_TYPE_CATEGORY = 'Scheduled PTO'
	AND at.IS_PAID_FLAG = '0'
  ) sub on (aabd.F_AGENT_ACTIVITY_BY_DATE_ID = sub.F_AGENT_ACTIVITY_BY_DATE_ID)
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--AT_WORK_NOT_HANDLING_CONTACTS_PERCENTAGE
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(PROGRAM_NAME,0,10) PROGRAM_NAME
  , ((COALESCE(SUM(sub.NOT_HANDLING_MINS),0)/SUM(ACTIVITY_MINUTES))*100) AS AT_WORK_NOT_HANDLING_PCT
FROM CC_F_AGENT_ACTIVITY_BY_DATE aabd
  INNER JOIN D_PROJECT proj on aabd.D_PROJECT_ID = proj.D_PROJECT_ID
  INNER JOIN D_PROGRAM prog on aabd.D_PROGRAM_ID = prog.D_PROGRAM_ID
  INNER JOIN CC_D_ACTIVITY_TYPE at on aabd.D_ACTIVITY_TYPE_ID = at.D_ACTIVITY_TYPE_ID
  INNER JOIN CC_D_DATES dd on aabd.D_DATE_ID = dd.D_DATE_ID
  LEFT JOIN (
    SELECT aabd.F_AGENT_ACTIVITY_BY_DATE_ID, ACTIVITY_MINUTES AS NOT_HANDLING_MINS
    FROM CC_F_AGENT_ACTIVITY_BY_DATE aabd
    INNER JOIN D_PROJECT proj on aabd.D_PROJECT_ID = proj.D_PROJECT_ID
    INNER JOIN D_PROGRAM prog on aabd.D_PROGRAM_ID = prog.D_PROGRAM_ID
    INNER JOIN CC_D_ACTIVITY_TYPE at on aabd.D_ACTIVITY_TYPE_ID = at.D_ACTIVITY_TYPE_ID
    INNER JOIN CC_D_DATES dd on aabd.D_DATE_ID = dd.D_DATE_ID
    WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
    AND at.ACTIVITY_TYPE_CATEGORY IN ('Other Not Ready', 'Meeting', 'Training')
  ) sub on (aabd.F_AGENT_ACTIVITY_BY_DATE_ID = sub.F_AGENT_ACTIVITY_BY_DATE_ID)
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

----------------------------------------------------------------------------------------------------------
--CC_D_AGENT----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------



--AGENT_ATTRITION
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME
  , COUNT(DISTINCT sub.D_AGENT_ID) as AGENT_ATTRITION
FROM (
  SELECT da.D_AGENT_ID
    , da.D_PROJECT_ID
    , COALESCE(abd.D_PROGRAM_ID, 0) as D_PROGRAM_ID
    , COALESCE(abd.D_GEOGRAPHY_MASTER_ID, 0) as D_GEOGRAPHY_MASTER_ID
    , da.HIRE_DATE
    , da.TERMINATION_DATE
  FROM CC_D_AGENT da
  LEFT JOIN CC_F_AGENT_BY_DATE abd on da.D_AGENT_ID = abd.D_AGENT_ID
  WHERE da.D_AGENT_ID <> 0
  AND da.TERMINATION_DATE >= to_date(:start_date,'mm/dd/yyyy')
  AND da.TERMINATION_DATE <= to_date(:end_date,'mm/dd/yyyy')
  GROUP BY da.D_AGENT_ID, da.D_PROJECT_ID, abd.D_PROGRAM_ID, abd.D_GEOGRAPHY_MASTER_ID, da.HIRE_DATE, da.TERMINATION_DATE
  )sub
INNER JOIN D_PROJECT proj on sub.D_PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on sub.D_PROGRAM_ID = prog.D_PROGRAM_ID
WHERE PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

----------------------------------------------------------------------------------------------------------
--CC_F_FORECAST_INTERVAL----------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

--CALLS_CREATED
--	TODO: Update UOW filter once UOW Category is added
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, SUM(CONTACTS_CREATED) AS CALLS_CREATED
FROM CC_F_FORECAST_INTERVAL ffi
INNER JOIN CC_D_PRODUCTION_PLAN_HORIZON dpph on ffi.D_PRODUCTION_PLAN_HORIZON_ID = dpph.PRODUCTION_PLAN_HRZN_ID
INNER JOIN CC_D_PRODUCTION_PLAN dpp on dpph.PRODUCTION_PLAN_ID = dpp.PRODUCTION_PLAN_ID
INNER JOIN D_PROJECT proj on dpp.PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on dpp.PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_UNIT_OF_WORK uow on ffi.D_UNIT_OF_WORK_ID = uow.UOW_ID
INNER JOIN CC_D_DATES dd on ffi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND uow.UNIT_OF_WORK_NAME NOT IN ('WebChat','IVR')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--CALLS_OFFERED
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, SUM(CONTACTS_OFFERED) AS CALLS_OFFERED
FROM CC_F_FORECAST_INTERVAL ffi
INNER JOIN CC_D_PRODUCTION_PLAN_HORIZON dpph on ffi.D_PRODUCTION_PLAN_HORIZON_ID = dpph.PRODUCTION_PLAN_HRZN_ID
INNER JOIN CC_D_PRODUCTION_PLAN dpp on dpph.PRODUCTION_PLAN_ID = dpp.PRODUCTION_PLAN_ID
INNER JOIN D_PROJECT proj on dpp.PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on dpp.PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_UNIT_OF_WORK uow on ffi.D_UNIT_OF_WORK_ID = uow.UOW_ID
INNER JOIN CC_D_DATES dd on ffi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--CALLS_HANDLED
--	TODO: Update UOW filter once UOW Category is added
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, SUM(CONTACTS_HANDLED) AS CALLS_HANDLED
FROM CC_F_FORECAST_INTERVAL ffi
INNER JOIN CC_D_PRODUCTION_PLAN_HORIZON dpph on ffi.D_PRODUCTION_PLAN_HORIZON_ID = dpph.PRODUCTION_PLAN_HRZN_ID
INNER JOIN CC_D_PRODUCTION_PLAN dpp on dpph.PRODUCTION_PLAN_ID = dpp.PRODUCTION_PLAN_ID
INNER JOIN D_PROJECT proj on dpp.PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on dpp.PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_UNIT_OF_WORK uow on ffi.D_UNIT_OF_WORK_ID = uow.UOW_ID
INNER JOIN CC_D_DATES dd on ffi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND uow.UNIT_OF_WORK_NAME NOT IN ('WebChat','IVR')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--WEB_CHATS_CREATED
--	TODO: Update UOW filter once UOW Category is added
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME, SUM(CONTACTS_CREATED) AS WEB_CHATS_CREATED
FROM CC_F_FORECAST_INTERVAL ffi
INNER JOIN CC_D_PRODUCTION_PLAN_HORIZON dpph on ffi.D_PRODUCTION_PLAN_HORIZON_ID = dpph.PRODUCTION_PLAN_HRZN_ID
INNER JOIN CC_D_PRODUCTION_PLAN dpp on dpph.PRODUCTION_PLAN_ID = dpp.PRODUCTION_PLAN_ID
INNER JOIN D_PROJECT proj on dpp.PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on dpp.PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_UNIT_OF_WORK uow on ffi.D_UNIT_OF_WORK_ID = uow.UOW_ID
INNER JOIN CC_D_DATES dd on ffi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND uow.UNIT_OF_WORK_NAME IN ('WebChat')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--AVERAGE_HANDLE_TIME
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME
  , SUM(MEAN_HANDLE_TIME*CONTACTS_HANDLED) as HANDLE_TIME_SECONDS, SUM(CONTACTS_HANDLED) as CONTACTS_HANDLED, (SUM((MEAN_HANDLE_TIME*CONTACTS_HANDLED))/SUM(CONTACTS_HANDLED)) as AVG_HANDLE_TIME
FROM CC_F_FORECAST_INTERVAL ffi
INNER JOIN CC_D_PRODUCTION_PLAN_HORIZON dpph on ffi.D_PRODUCTION_PLAN_HORIZON_ID = dpph.PRODUCTION_PLAN_HRZN_ID
INNER JOIN CC_D_PRODUCTION_PLAN dpp on dpph.PRODUCTION_PLAN_ID = dpp.PRODUCTION_PLAN_ID
INNER JOIN D_PROJECT proj on dpp.PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on dpp.PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_UNIT_OF_WORK uow on ffi.D_UNIT_OF_WORK_ID = uow.UOW_ID
INNER JOIN CC_D_DATES dd on ffi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--AVERAGE_SPEED_TO_ANSWER
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME
  , SUM(MEAN_SPEED_OF_ANSWER*CONTACTS_HANDLED) as SPEED_OF_ANSWER_SECONDS, SUM(CONTACTS_HANDLED) as CONTACTS_HANDLED, (SUM((MEAN_SPEED_OF_ANSWER*CONTACTS_HANDLED))/SUM(CONTACTS_HANDLED)) as AVG_SPEED_TO_ANSWER
FROM CC_F_FORECAST_INTERVAL ffi
INNER JOIN CC_D_PRODUCTION_PLAN_HORIZON dpph on ffi.D_PRODUCTION_PLAN_HORIZON_ID = dpph.PRODUCTION_PLAN_HRZN_ID
INNER JOIN CC_D_PRODUCTION_PLAN dpp on dpph.PRODUCTION_PLAN_ID = dpp.PRODUCTION_PLAN_ID
INNER JOIN D_PROJECT proj on dpp.PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on dpp.PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_UNIT_OF_WORK uow on ffi.D_UNIT_OF_WORK_ID = uow.UOW_ID
INNER JOIN CC_D_DATES dd on ffi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--AB_RATE
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME
  , SUM(CONTACTS_ABANDONED) as CONTACTS_ABANDONED, SUM(CONTACTS_OFFERED) as CONTACTS_OFFERED, ((SUM(CONTACTS_ABANDONED)/SUM(CONTACTS_OFFERED))*100) as AB_RATE
FROM CC_F_FORECAST_INTERVAL ffi
INNER JOIN CC_D_PRODUCTION_PLAN_HORIZON dpph on ffi.D_PRODUCTION_PLAN_HORIZON_ID = dpph.PRODUCTION_PLAN_HRZN_ID
INNER JOIN CC_D_PRODUCTION_PLAN dpp on dpph.PRODUCTION_PLAN_ID = dpp.PRODUCTION_PLAN_ID
INNER JOIN D_PROJECT proj on dpp.PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on dpp.PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_UNIT_OF_WORK uow on ffi.D_UNIT_OF_WORK_ID = uow.UOW_ID
INNER JOIN CC_D_DATES dd on ffi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--TOTAL_UTILIZATION
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(proj.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(prog.PROGRAM_NAME,0,10) PROGRAM_NAME
  , SUM(LABOR_MINUTES_AVAILABLE) as LABOR_MINUTES_AVAILABLE, SUM(LABOR_MINUTES_TOTAL) as LABOR_MINUTES_TOTAL, ((SUM(LABOR_MINUTES_AVAILABLE)/SUM(LABOR_MINUTES_TOTAL))*100) as TOTAL_UTILIZATION
FROM CC_F_FORECAST_INTERVAL ffi
INNER JOIN CC_D_PRODUCTION_PLAN_HORIZON dpph on ffi.D_PRODUCTION_PLAN_HORIZON_ID = dpph.PRODUCTION_PLAN_HRZN_ID
INNER JOIN CC_D_PRODUCTION_PLAN dpp on dpph.PRODUCTION_PLAN_ID = dpp.PRODUCTION_PLAN_ID
INNER JOIN D_PROJECT proj on dpp.PROJECT_ID = proj.D_PROJECT_ID
INNER JOIN D_PROGRAM prog on dpp.PROGRAM_ID = prog.D_PROGRAM_ID
INNER JOIN CC_D_UNIT_OF_WORK uow on ffi.D_UNIT_OF_WORK_ID = uow.UOW_ID
INNER JOIN CC_D_DATES dd on ffi.D_DATE_ID = dd.D_DATE_ID
WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
AND proj.PROJECT_NAME LIKE :project_name||'%'
GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME;

--MAX_NUM_OF_AGENTS_ON_PAYROLL
SELECT to_date(:start_date,'mm/dd/yyyy') as START_DATE, to_date(:end_date,'mm/dd/yyyy') as END_DATE, SUBSTR(PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(PROGRAM_NAME,0,10) PROGRAM_NAME
  , COALESCE(MAX(sub.agents_on_payroll_by_date),0) AS MAX_AGENTS_ON_PAYROLL
FROM (
    SELECT proj.PROJECT_NAME, prog.PROGRAM_NAME, dd.D_DATE, MAX(HEADCOUNT_TOTAL) as agents_on_payroll_by_date
    FROM CC_F_FORECAST_INTERVAL ffi
    INNER JOIN CC_D_PRODUCTION_PLAN_HORIZON dpph on ffi.D_PRODUCTION_PLAN_HORIZON_ID = dpph.PRODUCTION_PLAN_HRZN_ID
    INNER JOIN CC_D_PRODUCTION_PLAN dpp on dpph.PRODUCTION_PLAN_ID = dpp.PRODUCTION_PLAN_ID
    INNER JOIN D_PROJECT proj on dpp.PROJECT_ID = proj.D_PROJECT_ID
    INNER JOIN D_PROGRAM prog on dpp.PROGRAM_ID = prog.D_PROGRAM_ID
    INNER JOIN CC_D_UNIT_OF_WORK uow on ffi.D_UNIT_OF_WORK_ID = uow.UOW_ID
    INNER JOIN CC_D_DATES dd on ffi.D_DATE_ID = dd.D_DATE_ID
    WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
    AND proj.PROJECT_NAME LIKE :project_name||'%'
    GROUP BY proj.PROJECT_NAME, prog.PROGRAM_NAME, dd.D_DATE
    )sub 
    
GROUP BY sub.PROJECT_NAME, sub.PROGRAM_NAME;

--DAYS_OF_OPERATION
SELECT SUBSTR(sub.PROJECT_NAME,0,10) PROJECT_NAME, SUBSTR(sub.PROGRAM_NAME,0,10) PROGRAM_NAME, COUNT(DISTINCT(sub.D_DATE)) as DAYS_OF_OPERATION
FROM (
  SELECT proj.PROJECT_NAME, prog.PROGRAM_NAME, dd.D_DATE
  FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
  INNER JOIN D_PROJECT proj on faqi.D_PROJECT_ID = proj.D_PROJECT_ID
  INNER JOIN D_PROGRAM prog on faqi.D_PROGRAM_ID = prog.D_PROGRAM_ID
  INNER JOIN CC_D_DATES dd on faqi.D_DATE_ID = dd.D_DATE_ID
  WHERE dd.D_DATE BETWEEN to_date(:start_date,'mm/dd/yyyy') AND to_date(:end_date,'mm/dd/yyyy')
  AND proj.PROJECT_NAME LIKE :project_name||'%'
  GROUP  BY dd.D_DATE, proj.PROJECT_NAME, prog.PROGRAM_NAME
  HAVING SUM(faqi.CONTACTS_HANDLED) > 0
  ) sub
  GROUP BY sub.PROJECT_NAME, sub.PROGRAM_NAME;

