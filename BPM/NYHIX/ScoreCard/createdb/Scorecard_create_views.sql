/* Run as DP_SCORECARD */
 
show errors;

  CREATE OR REPLACE FORCE VIEW "DP_SCORECARD"."SCORECARD_ATTENDANCE_SCORE_SV" ("MANAGER_STAFF_ID", "MANAGER_NAME", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NAME", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "DATES", "ABSENCE_TYPE", "POINT_VALUE", "BALANCE", "INCENTIVE_BALANCE", "TOTAL_BALANCE", "INCENTIVE_FLAG", "SC_ATTENDANCE_ID", "CREATE_DATETIME", "CREATE_BY", "LAST_UPDATED_BY", "LAST_UPDATED_DATETIME") AS 
  With staff as
(
select
       manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       hire_date,
       0 as sc_attendance_id,
       hire_date as create_datetime
  from dp_scorecard.scorecard_hierarchy
)
, staff_starting_balance as
(
select manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       --hire_date as dates,
       coalesce(ais.start_date,hire_date) as dates,
       'Starting Balance' as absence_type,
       'Starting Balance' as absence_comment_type,
       --40 as point_value,
       coalesce(ais.attendance_points,40) as point_value,
       --40 as balance,
       coalesce(ais.attendance_points,40) as balance,
       --0 as incentive_balance,
       coalesce(ais.incentive_points,0) as incentive_balance,
       --40 as total_balance,
       (coalesce(ais.attendance_points,40) + coalesce(ais.incentive_points,0)) as total_balance,
       NULL as incentive_flag,
       NULL as comments,
       create_datetime,
       null as create_by,
       NULL as last_updated_by,
       null as LAST_UPDATED_DATETIME,
       sc_attendance_id
  from staff s
  left outer join dp_scorecard.sc_attendance_initial_score ais on s.staff_staff_id = ais.staff_id
),
sc_attend_entries as
(
select s.manager_staff_id,
       s.manager_name,
       s.supervisor_staff_id,
       s.supervisor_name,
       s.staff_staff_id,
       s.staff_staff_name,
       sca.entry_date as dates,
       sca.absence_type,
       sca.point_value,
       sca.balance,
       sca.incentive_balance,
       sca.total_balance,
       sca.incentive_flag,
       sca.sc_attendance_id,
       sca.create_datetime,
       sca.create_by,
       sca.last_updated_by,
       sca.LAST_UPDATED_DATETIME
  from staff s
inner join DP_SCORECARD.SC_ATTENDANCE sca
    on s.staff_staff_id = sca.staff_id
)
select manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       dates,
       absence_type,
       point_value,
       balance,
       incentive_balance,
       total_balance,
       incentive_flag,
       sc_attendance_id,
       create_datetime,
       create_by,
       last_updated_by,
       LAST_UPDATED_DATETIME
  from staff_starting_balance
union all
select manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       dates,
       absence_type,
       point_value,
       balance,
       incentive_balance,
       total_balance,
       incentive_flag,
       sc_attendance_id,
       create_datetime,
       create_by,
       last_updated_by,
       LAST_UPDATED_DATETIME
  from sc_attend_entries
;
  
    GRANT select on DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV to MAXDAT_READ_ONLY;
    GRANT select on DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV to MAXDAT;
   
 CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_ATTENDANCE_LKUP_SV AS  
select sc_all_id,
       absence_type,
       case
         when instr(ABSENCE_TYPE, '|') = 0 then
          ABSENCE_TYPE
         else
          substr(ABSENCE_TYPE, 1, instr(ABSENCE_TYPE, '|') - 2)
       end as ABSENCE_TYPE_SHORT_NAME,
       point_value,
       end_date,
       create_by,
       create_datetime,
       incentive_flag
  from dp_scorecard.sc_attendance_absence_lkup;
  
      GRANT select on DP_SCORECARD.SCORECARD_ATTENDANCE_LKUP_SV to MAXDAT_READ_ONLY;
      GRANT select on DP_SCORECARD.SCORECARD_ATTENDANCE_LKUP_SV to MAXDAT;
 
   CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_CORRECT_ACTION_LK_SV AS
select cal_id, correction_action_type, end_date, create_by, create_datetime
  from dp_scorecard.sc_corrective_action_lkup;

GRANT select on DP_SCORECARD.SCORECARD_CORRECT_ACTION_LK_SV to MAXDAT;
GRANT select on DP_SCORECARD.SCORECARD_CORRECT_ACTION_LK_SV to MAXDAT_READ_ONLY;
  
  CREATE OR REPLACE FORCE VIEW "DP_SCORECARD"."SCORECARD_CORRECT_ACTION_SV" ("MANAGER_STAFF_ID", "MANAGER_NAME", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NAME", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "CA_ID", "CA_ENTRY_DATE", "CAL_ID", "CORRECTION_ACTION_TYPE", "UNSATISFACTORY_BEHAVIOR", "COMMENTS", "CREATE_BY", "CREATE_DATETIME", "LAST_UPDATED_BY", "LAST_UPDATED_DATETIME") AS 
  select
          sh.manager_staff_id,
          sh.manager_name,
          sh.supervisor_staff_id,
          sh.supervisor_name,
          sh.staff_staff_id,
          sh.staff_staff_name,
          ca.ca_id,
          ca.ca_entry_date,
          ca.cal_id,
          cal.correction_action_type,
          ca.unsatisfactory_behavior,
          ca.comments,
          ca.create_by,
          ca.create_datetime,
          ca.last_updated_by,
          ca.LAST_UPDATED_DATETIME
      from dp_scorecard.sc_corrective_action ca
      join dp_scorecard.sc_corrective_action_lkup cal on ca.cal_id=cal.cal_id
      join dp_scorecard.scorecard_hierarchy sh on ca.staff_id=sh.staff_staff_id
;
GRANT select on DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV to MAXDAT;


  CREATE OR REPLACE FORCE VIEW "DP_SCORECARD"."SCORECARD_GOAL_SV" ("MANAGER_STAFF_ID", "MANAGER_NAME", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NAME", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "GOAL_ID", "STAFF_ID", "GOAL_ENTRY_DATE", "GTL_ID", "GOAL_DESCRIPTION", "GOAL_DATE", "PROGRESS_NOTE", "CREATE_BY", "CREATE_DATETIME", "LAST_UPDATED_BY", "LAST_UPDATED_DATETIME") AS 
  select
       sh.manager_staff_id,
       sh.manager_name,
       sh.supervisor_staff_id,
       sh.supervisor_name,
       sh.staff_staff_id,
       sh.staff_staff_name,
       g.goal_id,
       g.staff_id,
       g.goal_entry_date,
       g.gtl_id,
       g.goal_description,
       g.goal_date,
       g.progress_note,
       g.create_by,
       g.create_datetime,
       g.last_updated_by,
       g.LAST_UPDATED_DATETIME
  from dp_scorecard.sc_goal g
  join dp_scorecard.sc_goal_type_lkup gtl on g.gtl_id=gtl.gtl_id
  join dp_scorecard.scorecard_hierarchy sh on g.staff_id=sh.staff_staff_id
;

GRANT select on DP_SCORECARD.SCORECARD_GOAL_TYPE_LK_SV to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_GOAL_SV to MAXDAT_READ_ONLY;

GRANT insert, update, delete ON DP_SCORECARD.SC_GOAL TO MAXDAT_MSTR_TRX_RPT;

  
CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_DISCUSSION_LKUP_SV AS  
select dl_id, discussion_topic, end_date, create_by, create_datetime from dp_scorecard.sc_discussion_lkup;

    GRANT select on DP_SCORECARD.SCORECARD_DISCUSSION_LKUP_SV to MAXDAT_READ_ONLY;
    GRANT select on DP_SCORECARD.SCORECARD_DISCUSSION_LKUP_SV to MAXDAT;

CREATE OR REPLACE FORCE VIEW "DP_SCORECARD"."SCORECARD_PERFORM_TRACKER_SV" ("MANAGER_STAFF_ID", "MANAGER_NAME", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NAME", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "PT_ID", "PT_ENTRY_DATE", "DL_ID", "DISCUSSION_TOPIC", "COMMENTS", "CREATE_BY", "CREATE_DATETIME", "LAST_UPDATED_BY", "LAST_UPDATED_DATETIME") AS 
  select
           sh.manager_staff_id,
           sh.manager_name,
           sh.supervisor_staff_id,
           sh.supervisor_name,
           sh.staff_staff_id,
           sh.staff_staff_name,
           pt.pt_id,
           pt.pt_entry_date,
           pt.dl_id,
           dl.discussion_topic,
           pt.comments,
           pt.create_by,
           pt.create_datetime,
           pt.last_updated_by,
           pt.LAST_UPDATED_DATETIME
    from dp_scorecard.sc_performance_tracker pt
    join dp_scorecard.sc_discussion_lkup dl on pt.dl_id=dl.dl_id
    join dp_scorecard.scorecard_hierarchy sh on pt.staff_id=sh.staff_staff_id
;
  
GRANT select on DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV to MAXDAT_READ_ONLY;  
GRANT select on DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV to MAXDAT;  

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_GOAL_TYPE_LK_SV AS
select gtl_id, goal_type, end_date, create_by, create_datetime from dp_scorecard.sc_goal_type_lkup;

GRANT select on DP_SCORECARD.SCORECARD_GOAL_TYPE_LK_SV to MAXDAT_READ_ONLY;  
GRANT select on DP_SCORECARD.SCORECARD_GOAL_TYPE_LK_SV to MAXDAT;  

 
CREATE OR REPLACE VIEW SC_SUMMARY_SV AS
WITH TIME_metrics as 
(
	SELECT to_number(to_char(AS_DATE, 'YYYYMM')) MONTH_ID,
			to_char(AS_DATE, 'Month YYYY') MONTH_DESC,
			to_char(AGENT_ID) AGENT_ID,
			EXCLUSION_FLAG,
			sum(CALLS_ANSWERED) TOT_CALLS_ANSWERED,
			sum(SHORT_CALLS_ANSWERED) TOT_SHORT_CALLS_ANSWERED,
			sum(TOT_RETURN_TO_QUEUE) TOT_TOT_RETURN_TO_QUEUE,
			sum(extract( day from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
				extract( hour from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
				extract( minute from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
				extract( second from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_AVERAGE_HANDLE_TIME,
			sum(extract( day from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
				extract( hour from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
				extract( minute from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
				extract( second from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_SCHED_PRODUCTIVE_TIME,
			sum(extract( day from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
				extract( hour from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
				extract( minute from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
				extract( second from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_ACTUAL_PRODUCTIVE_TIME,
			sum(extract( day from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
				extract( hour from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
				extract( minute from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
				extract( second from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_TALK_TIME,
			sum(extract( day from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
				extract( hour from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
				extract( minute from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
				extract( second from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_WRAP_UP_TIME,
			sum(extract( day from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
				extract( hour from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
				extract( minute from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
				extract( second from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LOGGED_IN_TIME,
			sum(extract( day from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
				extract( hour from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
				extract( minute from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
				extract( second from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_NOT_READY_TIME,
			sum(extract( day from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
				extract( hour from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
				extract( minute from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
				extract( second from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_BREAK_TIME,
			sum(extract( day from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
				extract( hour from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
				extract( minute from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
				extract( second from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LUNCH_TIME
      	FROM DP_SCORECARD.SC_AGENT_STAT_SV	
		GROUP BY to_number(to_char(AS_DATE, 'YYYYMM')), to_char(AS_DATE, 'Month YYYY'), AGENT_ID, EXCLUSION_FLAG 
),
QC_metrics AS 
(
	SELECT to_number(to_char(eas.EVALUATION_DATE_TIME, 'YYYYMM')) MONTH_ID,
		   to_char(eas.EVALUATION_DATE_TIME, 'Month YYYY') MONTH_DESC,
		   to_char(eas.AGENT_ID) AGENT_ID, 
		   count(eas.EVALUATION_REFERENCE_ID) QC_COMPLETED, 
		   sum(eas.SCORE_TOTAL) TOT_SCORE_TOTAL
	FROM DP_SCORECARD.ENGAGE_ACTUALS_SV eas
	join DP_SCORECARD.ENGAGE_FORM_TYPE_SV eft on eas.EVALUATION_FORM = eft.EVALUATION_FORM
	where  eft.SCORECARD_SCORE_TYPE   = 'QC'
	GROUP BY to_number(to_char(eas.EVALUATION_DATE_TIME, 'YYYYMM')),
			 to_char(eas.EVALUATION_DATE_TIME, 'Month YYYY'),
			 eas.AGENT_ID 
),
EMPS as 
(
	SELECT STAFF_STAFF_ID,
		   STAFF_STAFF_NAME,
		   STAFF_NATID
	FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV 
	GROUP BY STAFF_STAFF_ID,
			 STAFF_STAFF_NAME,
			 STAFF_NATID
),
INCDEFS AS 
(
	SELECT trunc(a11.TASK_START) AS_DATE, a11.STAFF_ID, 
	       count((Case when a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) then 1 else null end)) INCIDENTS_COMPLETED,
		   count((Case when a11.EVENT_ID in (1373) then 1 else null end)) DEFECTS_COMPLETED
	FROM MAXDAT.PP_WFM_ACTUALS_SV a11
	WHERE (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379)
				or a11.EVENT_ID in (1373)) 
				and a11.TASK_END is not null 
	group by trunc(TASK_START), 
			 STAFF_ID	
),			
INCDEF_metrics AS 
(
	select to_number(to_char(a11.AS_DATE, 'YYYYMM')) MONTH_ID,
		   to_char(a11.AS_DATE, 'Month YYYY') MONTH_DESC,
		   a12.STAFF_NATID AGENT_ID,
		   sum(a11.INCIDENTS_COMPLETED) TOT_INCIDENTS_COMPLETED,
		   count(a11.INCIDENTS_COMPLETED)  DAYS_INCIDENTS_COMPLETED,
		   sum(a11.DEFECTS_COMPLETED) TOT_DEFECTS_COMPLETED,
           count(a11.DEFECTS_COMPLETED)  DAYS_DEFECTS_COMPLETED
	from  INCDEFS a11
	join  EMPS a12
		on (a11.STAFF_ID = a12.STAFF_STAFF_ID )
	GROUP BY to_number(to_char(a11.AS_DATE, 'YYYYMM')),
			 to_char(a11.AS_DATE, 'Month YYYY'),
			 a12.STAFF_NATID 
),
LAG_metrics AS (
	SELECT to_number(to_char(LAG_DATE, 'YYYYMM')) MONTH_ID,
		   to_char(LAG_DATE, 'Month YYYY') MONTH_DESC,
		   to_char(AGENT_ID) AGENT_ID,
		   sum(extract( day from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
				extract( hour from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
				extract( minute from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
				extract( second from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) LAG_TIME_TOT_SCHED_PROD_TIME
      FROM DP_SCORECARD.SC_LAG_TIME_SV 
	  GROUP BY to_number(to_char(LAG_DATE, 'YYYYMM')),
			   to_char(LAG_DATE, 'Month YYYY'),
			   AGENT_ID 
),
CUST_metrics AS 
(	  
	 SELECT to_number(to_char(CALL_DATE, 'YYYYMM')) MONTH_ID,
			to_char(CALL_DATE, 'Month YYYY') MONTH_DESC,
			EMPLOYEE_ID AGENT_ID,
			count(CALL_RECORD_ID) TOT_CALL_RECORDS,
			sum(CUSTOMER_COUNT) TOT_CUSTOMER_COUNT,
			sum(CALL_WRAP_UP_COUNT) TOT_CALL_WRAP_UP_COUNT
	 FROM DP_SCORECARD.SC_NON_STD_USE_SV 
	 GROUP BY to_number(to_char(CALL_DATE, 'YYYYMM')),
			  to_char(CALL_DATE, 'Month YYYY'), 
			  EMPLOYEE_ID 
),
WUE_metrics AS 
(
	SELECT to_number(to_char(a11.WUE_DATE, 'YYYYMM')) MONTH_ID,
		   to_char(a11.WUE_DATE, 'Month YYYY') MONTH_DESC,
		   to_char(a11.AGENT_ID) AGENT_ID,
		   sum(a11.WRAP_UP_ERROR) TOT_WRAP_UP_ERROR
	FROM DP_SCORECARD.SC_WRAP_UP_ERROR_SV a11
	GROUP BY to_number(to_char(a11.WUE_DATE, 'YYYYMM')),
			 to_char(a11.WUE_DATE, 'Month YYYY'),
			 a11.AGENT_ID 
),
CALL_metrics AS 
(
	SELECT AS_DATE, 
		   AGENT_ID, 
		   EXCLUSION_FLAG, 
		   CASE WHEN sum(SHORT_CALLS_ANSWERED) > 10 THEN 1 ELSE null END short_calls, 
		   sum(CALLS_ANSWERED) TOT_CALLS
	FROM DP_SCORECARD.SC_AGENT_STAT_SV 
	GROUP BY AS_DATE, 
			 AGENT_ID, 
			 EXCLUSION_FLAG
),
CALL_days AS 
(			 
	SELECT to_number(to_char(AS_DATE, 'YYYYMM')) MONTH_ID,
	   to_char(AS_DATE, 'Month YYYY') MONTH_DESC,
       to_char(AGENT_ID) AGENT_ID,
       EXCLUSION_FLAG, 
       count(short_calls) Days_Short_Calls_GT_10,
	   count(TOT_CALLS) DAYS_CALLS_ANSWERED
	FROM CALL_metrics
	GROUP BY to_number(to_char(AS_DATE, 'YYYYMM')),
			 to_char(AS_DATE, 'Month YYYY'),
			 AGENT_ID,
			 EXCLUSION_FLAG 
),
ATTEND_Metrics AS 
( 
SELECT to_number(SAMS.DATES_MONTH_NUM) MONTH_ID, 
		   SAMS.DATES_YEAR MONTH_DESC, 
		   EMPS.STAFF_NATID AGENT_ID,
		   SAMS.BALANCE ATTENDANCE_PTS, 
		   SAMS.TOTAL_BALANCE ATTENDANCE_TOTAL_PTS
	FROM DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_SV SAMS
	JOIN EMPS on SAMS.staff_staff_id = EMPS.STAFF_STAFF_ID
)
SELECT 
  MONTH_ID,
  MONTH_DESC,
  AGENT_ID, 
  EXCLUSION_FLAG,
  TOT_CALLS_ANSWERED,
  TOT_SHORT_CALLS_ANSWERED,
  TOT_TOT_RETURN_TO_QUEUE,
  TOT_AVERAGE_HANDLE_TIME,
  TOT_SCHED_PRODUCTIVE_TIME,
  TOT_ACTUAL_PRODUCTIVE_TIME,
  TOT_TALK_TIME,
  TOT_WRAP_UP_TIME,
  TOT_LOGGED_IN_TIME,
  TOT_NOT_READY_TIME,
  TOT_BREAK_TIME,
  TOT_LUNCH_TIME,	
  to_number(null) QC_COMPLETED, 
  to_number(null) TOT_SCORE_TOTAL,
  to_number(null) TOT_INCIDENTS_COMPLETED,
  to_number(null) DAYS_INCIDENTS_COMPLETED,
  to_number(null) TOT_DEFECTS_COMPLETED,
  to_number(null) DAYS_DEFECTS_COMPLETED,
  to_number(null) LAG_TIME_TOT_SCHED_PROD_TIME,
  to_number(null) TOT_CALL_RECORDS,
  to_number(null) TOT_CUSTOMER_COUNT,
  to_number(null) TOT_CALL_WRAP_UP_COUNT,
  to_number(null) TOT_WRAP_UP_ERROR,
  to_number(null) Days_Short_Calls_GT_10,
  to_number(null) DAYS_CALLS_ANSWERED,
  to_number(null) ATTENDANCE_PTS, 
  to_number(null) ATTENDANCE_TOTAL_PTS
FROM TIME_metrics 
UNION 
SELECT 
  MONTH_ID,
  MONTH_DESC,
  AGENT_ID, 
  'N' EXCLUSION_FLAG,
  to_number(null) TOT_CALLS_ANSWERED,
  to_number(null) TOT_SHORT_CALLS_ANSWERED,
  to_number(null) TOT_TOT_RETURN_TO_QUEUE,
  to_number(null) TOT_AVERAGE_HANDLE_TIME,
  to_number(null) TOT_SCHED_PRODUCTIVE_TIME,
  to_number(null) TOT_ACTUAL_PRODUCTIVE_TIME,
  to_number(null) TOT_TALK_TIME,
  to_number(null) TOT_WRAP_UP_TIME,
  to_number(null) TOT_LOGGED_IN_TIME,
  to_number(null) TOT_NOT_READY_TIME,
  to_number(null) TOT_BREAK_TIME,
  to_number(null) TOT_LUNCH_TIME,	
  QC_COMPLETED, 
  TOT_SCORE_TOTAL,
  to_number(null) TOT_INCIDENTS_COMPLETED,
  to_number(null) DAYS_INCIDENTS_COMPLETED,
  to_number(null) TOT_DEFECTS_COMPLETED,
  to_number(null) DAYS_DEFECTS_COMPLETED,
  to_number(null) LAG_TIME_TOT_SCHED_PROD_TIME,
  to_number(null) TOT_CALL_RECORDS,
  to_number(null) TOT_CUSTOMER_COUNT,
  to_number(null) TOT_CALL_WRAP_UP_COUNT,
  to_number(null) TOT_WRAP_UP_ERROR,
  to_number(null) Days_Short_Calls_GT_10,
  to_number(null) DAYS_CALLS_ANSWERED,
  to_number(null) ATTENDANCE_PTS, 
  to_number(null) ATTENDANCE_TOTAL_PTS
FROM QC_metrics 
UNION
SELECT 
  MONTH_ID,
  MONTH_DESC,
  AGENT_ID, 
  'N' EXCLUSION_FLAG,
  to_number(null) TOT_CALLS_ANSWERED,
  to_number(null) TOT_SHORT_CALLS_ANSWERED,
  to_number(null) TOT_TOT_RETURN_TO_QUEUE,
  to_number(null) TOT_AVERAGE_HANDLE_TIME,
  to_number(null) TOT_SCHED_PRODUCTIVE_TIME,
  to_number(null) TOT_ACTUAL_PRODUCTIVE_TIME,
  to_number(null) TOT_TALK_TIME,
  to_number(null) TOT_WRAP_UP_TIME,
  to_number(null) TOT_LOGGED_IN_TIME,
  to_number(null) TOT_NOT_READY_TIME,
  to_number(null) TOT_BREAK_TIME,
  to_number(null) TOT_LUNCH_TIME,	
  to_number(null) QC_COMPLETED, 
  to_number(null) TOT_SCORE_TOTAL,
  TOT_INCIDENTS_COMPLETED,
  DAYS_INCIDENTS_COMPLETED,
  TOT_DEFECTS_COMPLETED,
  DAYS_DEFECTS_COMPLETED,
  to_number(null) LAG_TIME_TOT_SCHED_PROD_TIME,
  to_number(null) TOT_CALL_RECORDS,
  to_number(null) TOT_CUSTOMER_COUNT,
  to_number(null) TOT_CALL_WRAP_UP_COUNT,
  to_number(null) TOT_WRAP_UP_ERROR,
  to_number(null) Days_Short_Calls_GT_10,
  to_number(null) DAYS_CALLS_ANSWERED,
  to_number(null) ATTENDANCE_PTS, 
  to_number(null) ATTENDANCE_TOTAL_PTS
FROM INCDEF_metrics
UNION
SELECT 
  MONTH_ID,
  MONTH_DESC,
  AGENT_ID, 
  'N' EXCLUSION_FLAG,
  to_number(null)  TOT_CALLS_ANSWERED,
  to_number(null)   TOT_SHORT_CALLS_ANSWERED,
  to_number(null) TOT_TOT_RETURN_TO_QUEUE,
  to_number(null) TOT_AVERAGE_HANDLE_TIME,
  to_number(null) TOT_SCHED_PRODUCTIVE_TIME,
  to_number(null) TOT_ACTUAL_PRODUCTIVE_TIME,
  to_number(null) TOT_TALK_TIME,
  to_number(null) TOT_WRAP_UP_TIME,
  to_number(null) TOT_LOGGED_IN_TIME,
  to_number(null) TOT_NOT_READY_TIME,
  to_number(null) TOT_BREAK_TIME,
  to_number(null) TOT_LUNCH_TIME,	
  to_number(null) QC_COMPLETED, 
  to_number(null) TOT_SCORE_TOTAL,
  to_number(null) TOT_INCIDENTS_COMPLETED,
  to_number(null) DAYS_INCIDENTS_COMPLETED,
  to_number(null) TOT_DEFECTS_COMPLETED,
  to_number(null) DAYS_DEFECTS_COMPLETED,
  LAG_TIME_TOT_SCHED_PROD_TIME,
  to_number(null) TOT_CALL_RECORDS,
  to_number(null) TOT_CUSTOMER_COUNT,
  to_number(null) TOT_CALL_WRAP_UP_COUNT,
  to_number(null) TOT_WRAP_UP_ERROR,
  to_number(null) Days_Short_Calls_GT_10,
  to_number(null) DAYS_CALLS_ANSWERED,
  to_number(null) ATTENDANCE_PTS, 
  to_number(null) ATTENDANCE_TOTAL_PTS
FROM LAG_metrics
UNION
SELECT 
  MONTH_ID,
  MONTH_DESC,
  AGENT_ID, 
  'N' EXCLUSION_FLAG,
  to_number(null) TOT_CALLS_ANSWERED,
  to_number(null) TOT_SHORT_CALLS_ANSWERED,
  to_number(null) TOT_TOT_RETURN_TO_QUEUE,
  to_number(null) TOT_AVERAGE_HANDLE_TIME,
  to_number(null) TOT_SCHED_PRODUCTIVE_TIME,
  to_number(null) TOT_ACTUAL_PRODUCTIVE_TIME,
  to_number(null) TOT_TALK_TIME,
  to_number(null) TOT_WRAP_UP_TIME,
  to_number(null) TOT_LOGGED_IN_TIME,
  to_number(null) TOT_NOT_READY_TIME,
  to_number(null) TOT_BREAK_TIME,
  to_number(null) TOT_LUNCH_TIME,	
  to_number(null) QC_COMPLETED, 
  to_number(null) TOT_SCORE_TOTAL,
  to_number(null) TOT_INCIDENTS_COMPLETED,
  to_number(null) DAYS_INCIDENTS_COMPLETED,
  to_number(null) TOT_DEFECTS_COMPLETED,
  to_number(null) DAYS_DEFECTS_COMPLETED,
  to_number(null) LAG_TIME_TOT_SCHED_PROD_TIME,
  TOT_CALL_RECORDS,
  TOT_CUSTOMER_COUNT,
  TOT_CALL_WRAP_UP_COUNT,
  to_number(null) TOT_WRAP_UP_ERROR,
  to_number(null) Days_Short_Calls_GT_10,
  to_number(null) DAYS_CALLS_ANSWERED,
  to_number(null) ATTENDANCE_PTS, 
  to_number(null) ATTENDANCE_TOTAL_PTS
FROM CUST_metrics
UNION
SELECT 
  MONTH_ID,
  MONTH_DESC,
  AGENT_ID, 
  'N' EXCLUSION_FLAG,
  to_number(null) TOT_CALLS_ANSWERED,
  to_number(null) TOT_SHORT_CALLS_ANSWERED,
  to_number(null) TOT_TOT_RETURN_TO_QUEUE,
  to_number(null) TOT_AVERAGE_HANDLE_TIME,
  to_number(null) TOT_SCHED_PRODUCTIVE_TIME,
  to_number(null) TOT_ACTUAL_PRODUCTIVE_TIME,
  to_number(null) TOT_TALK_TIME,
  to_number(null) TOT_WRAP_UP_TIME,
  to_number(null) TOT_LOGGED_IN_TIME,
  to_number(null) TOT_NOT_READY_TIME,
  to_number(null) TOT_BREAK_TIME,
  to_number(null) TOT_LUNCH_TIME,	
  to_number(null) QC_COMPLETED, 
  to_number(null) TOT_SCORE_TOTAL,
  to_number(null) TOT_INCIDENTS_COMPLETED,
  to_number(null) DAYS_INCIDENTS_COMPLETED,
  to_number(null) TOT_DEFECTS_COMPLETED,
  to_number(null) DAYS_DEFECTS_COMPLETED,
  to_number(null) LAG_TIME_TOT_SCHED_PROD_TIME,
  to_number(null) TOT_CALL_RECORDS,
  to_number(null) TOT_CUSTOMER_COUNT,
  to_number(null) TOT_CALL_WRAP_UP_COUNT,
  TOT_WRAP_UP_ERROR,
  to_number(null) Days_Short_Calls_GT_10,
  to_number(null) DAYS_CALLS_ANSWERED,
  to_number(null) ATTENDANCE_PTS, 
  to_number(null) ATTENDANCE_TOTAL_PTS
FROM WUE_metrics
UNION
SELECT 
  MONTH_ID,
  MONTH_DESC,
  AGENT_ID, 
  EXCLUSION_FLAG,
  to_number(null) TOT_CALLS_ANSWERED,
  to_number(null) TOT_SHORT_CALLS_ANSWERED,
  to_number(null) TOT_TOT_RETURN_TO_QUEUE,
  to_number(null) TOT_AVERAGE_HANDLE_TIME,
  to_number(null) TOT_SCHED_PRODUCTIVE_TIME,
  to_number(null) TOT_ACTUAL_PRODUCTIVE_TIME,
  to_number(null) TOT_TALK_TIME,
  to_number(null) TOT_WRAP_UP_TIME,
  to_number(null) TOT_LOGGED_IN_TIME,
  to_number(null) TOT_NOT_READY_TIME,
  to_number(null) TOT_BREAK_TIME,
  to_number(null) TOT_LUNCH_TIME,	
  to_number(null) QC_COMPLETED, 
  to_number(null) TOT_SCORE_TOTAL,
  to_number(null) TOT_INCIDENTS_COMPLETED,
  to_number(null) DAYS_INCIDENTS_COMPLETED,
  to_number(null) TOT_DEFECTS_COMPLETED,
  to_number(null) DAYS_DEFECTS_COMPLETED,
  to_number(null) LAG_TIME_TOT_SCHED_PROD_TIME,
  to_number(null) TOT_CALL_RECORDS,
  to_number(null) TOT_CUSTOMER_COUNT,
  to_number(null) TOT_CALL_WRAP_UP_COUNT,
  to_number(null) TOT_WRAP_UP_ERROR,
  Days_Short_Calls_GT_10,
  DAYS_CALLS_ANSWERED,
  to_number(null) ATTENDANCE_PTS, 
  to_number(null) ATTENDANCE_TOTAL_PTS
FROM CALL_days
UNION
SELECT 
  MONTH_ID,
  MONTH_DESC,
  AGENT_ID, 
  'N' EXCLUSION_FLAG,
  to_number(null)  TOT_CALLS_ANSWERED,
  to_number(null)   TOT_SHORT_CALLS_ANSWERED,
  to_number(null) TOT_TOT_RETURN_TO_QUEUE,
  to_number(null) TOT_AVERAGE_HANDLE_TIME,
  to_number(null) TOT_SCHED_PRODUCTIVE_TIME,
  to_number(null) TOT_ACTUAL_PRODUCTIVE_TIME,
  to_number(null) TOT_TALK_TIME,
  to_number(null) TOT_WRAP_UP_TIME,
  to_number(null) TOT_LOGGED_IN_TIME,
  to_number(null) TOT_NOT_READY_TIME,
  to_number(null) TOT_BREAK_TIME,
  to_number(null) TOT_LUNCH_TIME,	
  to_number(null) QC_COMPLETED, 
  to_number(null) TOT_SCORE_TOTAL,
  to_number(null) TOT_INCIDENTS_COMPLETED,
  to_number(null)  DAYS_INCIDENTS_COMPLETED,
  to_number(null) TOT_DEFECTS_COMPLETED,
  to_number(null)  DAYS_DEFECTS_COMPLETED,
  to_number(null) LAG_TIME_TOT_SCHED_PROD_TIME,
  to_number(null) TOT_CALL_RECORDS,
  to_number(null) TOT_CUSTOMER_COUNT,
  to_number(null) TOT_CALL_WRAP_UP_COUNT,
  to_number(null) TOT_WRAP_UP_ERROR,
  to_number(null) Days_Short_Calls_GT_10,
  to_number(null) DAYS_CALLS_ANSWERED,
  ATTENDANCE_PTS, 
  ATTENDANCE_TOTAL_PTS
FROM ATTEND_Metrics;
      
GRANT select on SC_SUMMARY_SV to MAXDAT_READ_ONLY;      
GRANT select on SC_SUMMARY_SV to MAXDAT;      

CREATE OR REPLACE FORCE VIEW SC_EXCLUSION_SV
(exclusion_ID
,supervisor_id
,agent_id
,staff_id
,excl_date
,exclusion_flag
,exclusion_comment
,create_date
,Create_by	
) 
as
select 
exclusion_ID
,supervisor_id
,agent_id
,staff_id
,exclusion_date
,exclusion_flag
,exclusion_comment
,create_date
,Create_by
from SC_EXCLUSION
WITH READ ONLY;

grant select on SC_EXCLUSION_SV to MAXDAT_READ_ONLY; 
grant select on SC_EXCLUSION_SV to MAXDAT; 
grant select ON SC_EXCLUSION TO MAXDAT_MSTR_TRX_RPT;

CREATE OR REPLACE FORCE VIEW SC_LAG_TIME_SV
(lag_date
,agent_id
,supervisor_id
,Tot_Sched_Productive_Time
,adherence_flag	
) 
as
select 
lag_date
,agent_id
,supervisor_id
,Tot_Sched_Productive_Time
,adherence_flag
from SC_LAG_TIME
WITH READ ONLY;

grant select on SC_LAG_TIME_SV to MAXDAT_READ_ONLY; 
grant  SELECT, REFERENCES  on SC_LAG_TIME_SV to MAXDAT; 

CREATE OR REPLACE FORCE VIEW scorecard_attendance_mthly_sv 
(MANAGER_STAFF_ID
,MANAGER_NAME
,SUPERVISOR_STAFF_ID
,SUPERVISOR_NAME
,STAFF_STAFF_ID
,STAFF_STAFF_NAME
,DATES_MONTH
,DATES_MONTH_NUM
,DATES_YEAR
,BALANCE
,TOTAL_BALANCE
,SC_ATTENDANCE_ID
) as
select MANAGER_STAFF_ID
,MANAGER_NAME
,SUPERVISOR_STAFF_ID
,SUPERVISOR_NAME
,STAFF_STAFF_ID
,STAFF_STAFF_NAME
,DATES_MONTH
,DATES_MONTH_NUM
,DATES_YEAR
,BALANCE
,TOTAL_BALANCE
,SC_ATTENDANCE_ID
 from scorecard_attendance_mthly
with read only;

grant select on scorecard_attendance_mthly_sv to MAXDAT_READ_ONLY;
grant  SELECT, REFERENCES  on scorecard_attendance_mthly_sv to MAXDAT;  

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_HIERARCHY_SV
AS
WITH QC_DATE AS 
(
SELECT months_between(TRUNC(SYSDATE,'MM'), trunc(min(evaluation_date_time), 'MM')) QC_Months, e.AGENT_ID 
from dp_scorecard.ENGAGE_ACTUALS e 
JOIN dp_scorecard.scorecard_hierarchy h
on e.agent_id = h.staff_natid
WHERE e.DELETED_FLAG != 'Y'
OR e.DELETED_FLAG IS NULL
GROUP BY e.agent_id
)
SELECT -- 6/30/2017 NYHIX-32295 Single row query returns multiple Rows  SVN = 20170630_NYHIX32295_SCORECARD_HIERARCHY_SV.SQL
                -- Added std.DELETE_FLAG = 'N'
                999 AS admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
           h.sr_director_name,
           h.sr_director_staff_id,
           h.sr_director_natid,
           (SELECT termination_date
              FROM MAXDAT.PP_WFM_STAFF_SV S
             WHERE h.sr_director_staff_id = s.Staff_id)
               sr_director_termination_date,
           h.director_name,
           h.director_staff_id,
           h.director_natid,
           (SELECT termination_date
              FROM MAXDAT.PP_WFM_STAFF_SV S
             WHERE h.director_staff_id = s.Staff_id)
               director_termination_date,
           h.sr_manager_name,
           h.sr_manager_staff_id,
           h.sr_manager_natid,
           (SELECT termination_date
              FROM MAXDAT.PP_WFM_STAFF_SV S
             WHERE h.sr_manager_staff_id = s.Staff_id)
               sr_manager_termination_date,
           h.manager_name,
           h.manager_staff_id,
           h.manager_natid,
           (SELECT termination_date
              FROM MAXDAT.PP_WFM_STAFF_SV S
             WHERE h.manager_staff_id = s.Staff_id)
               manager_termination_date,
           h.supervisor_name,
           h.supervisor_staff_id,
           h.supervisor_natid,
           (SELECT termination_date
              FROM MAXDAT.PP_WFM_STAFF_SV S
             WHERE h.supervisor_staff_id = s.Staff_id)
               supervisor_termination_date,
           h.staff_staff_id,
           h.staff_staff_name,
           h.staff_natid,
           h.hire_date,
           h.position,
           h.office,
           h.termination_date,
           H.DEPARTMENT,
           H.BUILDING,
           H.EVENT_NAME,
           CASE WHEN q.QC_MONTHS IS NULL THEN NULL 
                WHEN q.QC_MONTHS = 0 then '0' 
                WHEN q.QC_MONTHS = 1 then '1'
                WHEN q.QC_MONTHS IN (2,3) THEN '2-3'
                WHEN q.QC_MONTHS IN (4,5,6) THEN '4-6'
                WHEN q.QC_MONTHS IN (7,8,9) THEN '7-9'
                WHEN q.QC_MONTHS IN (10,11,12) THEN '10-12'
                WHEN q.QC_MONTHS > 12 THEN 'OVER 12'
                ELSE NULL 
           END QC_TENURE,
           CASE WHEN h.POSITION = 'HSDE' THEN 'HSDE'
                WHEN h.POSITION = 'Eligibility Specialist B' THEN 'V Docs'
                WHEN h.POSITION = 'CSS1' THEN 'SBM'
                WHEN h.POSITION = 'CSS3' THEN 'IND'
                WHEN h.POSITION = 'CSS4' THEN 'WebChat'
                WHEN h.POSITION = 'SWCC-CSR' THEN 'SWCC'
                WHEN h.POSITION = 'SWCC-CSR 2' THEN 'SWCC'
                WHEN h.POSITION = 'Eligibility Specialist C-Appeals' THEN 'Appeals'
                WHEN h.POSITION = 'SHOP 1' THEN 'SBM'
                WHEN h.POSITION = 'SHOP 2' THEN 'SBM'
                WHEN h.POSITION = 'Eligibility Specialist A' THEN 'HSDE-QC/LDS'
                WHEN h.POSITION = 'Quality Control' THEN 'QC'
                WHEN h.POSITION = 'Mailroom' THEN 'Mailroom'
                WHEN h.POSITION = 'Research Specialist' THEN 'Research'
                WHEN h.POSITION = 'NYEC - Mailroom' THEN 'NYEC 1'
                WHEN h.POSITION = 'NAV-QR2' THEN 'IND'
                ELSE null
           End QC_GROUP
      FROM dp_scorecard.scorecard_hierarchy h
      LEFT JOIN QC_DATE q
      ON q.agent_id = h.staff_natid;

GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO MAXDAT_REPORTS;


  GRANT select on DP_SCORECARD.SCORECARD_HIEARCHY_SV to MAXDAT;

CREATE OR REPLACE VIEW scorecard_hierarchy_um_sv
 (
UM_Staff_id 
,UM_Natid 
,UM_Name 
) AS
SELECT 
UM_Staff_id 
,UM_Natid 
,UM_Name 
FROM SCORECARD_HIERARCHY_UM
WITH read only;

GRANT SELECT ON scorecard_hierarchy_um_sv TO MAXDAT;
GRANT SELECT ON scorecard_hierarchy_um_sv TO MAXDAT_READ_ONLY;


CREATE OR REPLACE FORCE VIEW SC_WRAP_UP_ERROR_SV
(WUE_Date		
,Agent_ID		
,Wrap_up_error	
) 
as
select 
WUE_Date		
,Agent_ID		
,Wrap_up_error	
from SC_WRAP_UP_ERROR
WITH READ ONLY;

grant select on SC_WRAP_UP_ERROR_SV to MAXDAT_READ_ONLY; 
grant  SELECT, REFERENCES  on SC_WRAP_UP_ERROR_SV to MAXDAT; 

CREATE OR REPLACE FORCE VIEW SC_NON_STD_USE_SV
(Call_Record_ID 
,Customer_count  
,Call_Wrap_up_count 
,Call_Date  
,Call_Time  
,Employee_ID	
,CALL_DT	
) 
as
select 
Call_Record_ID 
,Customer_count  
,Call_Wrap_up_count 
,Call_Date  
,Call_Time  
,Employee_ID	
,CALL_DT
from SC_NON_STD_USE
WITH READ ONLY;

grant select on SC_NON_STD_USE_SV to MAXDAT_READ_ONLY; 
grant  SELECT, REFERENCES  on SC_NON_STD_USE_SV to MAXDAT; 

CREATE OR REPLACE FORCE VIEW SC_AGENT_STAT_SV
(AS_Date 
,Agent_ID 
,Supervisor_ID 
,Calls_Answered 
,Short_Calls_Answered
,Average_Handle_time 
,Tot_Return_to_Queue 
,Tot_Return_to_Queue_Timeout
,Tot_Sched_Productive_Time 
,Actual_Productive_Time 
,Talk_Time
,Wrap_Up_Time 
,Logged_in_Time 
,Not_Ready_Time
,Break_Time 
,Lunch_Time 
,EXCLUSION_FLAG 
) 
as
select 
AS_Date 
,Agent_ID 
,Supervisor_ID 
,Calls_Answered 
,Short_Calls_Answered
,Average_Handle_time 
,Tot_Return_to_Queue 
,Tot_Return_to_Queue_Timeout
,Tot_Sched_Productive_Time 
,Actual_Productive_Time 
,Talk_Time
,Wrap_Up_Time 
,Logged_in_Time 
,Not_Ready_Time
,Break_Time 
,Lunch_Time 
,EXCLUSION_FLAG
from SC_AGENT_STAT
WITH READ ONLY;

grant select on SC_AGENT_STAT_SV to MAXDAT_READ_ONLY; 
grant select on SC_AGENT_STAT_SV to MAXDAT; 
grant select on SC_AGENT_STAT_SV to MAXDAT_MSTR_TRX_RPT; 

CREATE OR REPLACE FORCE VIEW "DP_SCORECARD"."SC_SUMMARY_CC_SV" ("STAFF_STAFF_ID", "STAFF_STAFF_NAME", "DATES_MONTH", "DATES_MONTH_NUM", "DATES_YEAR", "EXCLUSION_FLAG", "TOT_CALLS_ANSWERED", "TOT_SHORT_CALLS_ANSWERED", "TOT_TOT_RETURN_TO_QUEUE", "TOT_AVERAGE_HANDLE_TIME", "TOT_SCHED_PRODUCTIVE_TIME", "TOT_ACTUAL_PRODUCTIVE_TIME", "TOT_TALK_TIME", "TOT_WRAP_UP_TIME", "TOT_LOGGED_IN_TIME", "TOT_NOT_READY_TIME", "TOT_BREAK_TIME", "TOT_LUNCH_TIME", "QCS_PERFORMED", "AVG_QC_SCORE", "TOT_INCIDENTS_COMPLETED", "DAYS_INCIDENTS_COMPLETED", "TOT_DEFECTS_COMPLETED", "DAYS_DEFECTS_COMPLETED", "LAG_TIME_TOT_SCHED_PROD_TIME", "TOT_CALL_RECORDS", "TOT_CUSTOMER_COUNT", "TOT_CALL_WRAP_UP_COUNT", "TOT_WRAP_UP_ERROR", "DAYS_SHORT_CALLS_GT_10", "DAYS_CALLS_ANSWERED") AS 
  select DISTINCT "STAFF_STAFF_ID",
       "STAFF_STAFF_NAME",
       "DATES_MONTH",
       "DATES_MONTH_NUM",
       "DATES_YEAR",
       "EXCLUSION_FLAG",
       "TOT_CALLS_ANSWERED",
       "TOT_SHORT_CALLS_ANSWERED",
       "TOT_TOT_RETURN_TO_QUEUE",
       "TOT_AVERAGE_HANDLE_TIME",
       "TOT_SCHED_PRODUCTIVE_TIME",
       "TOT_ACTUAL_PRODUCTIVE_TIME",
       "TOT_TALK_TIME",
       "TOT_WRAP_UP_TIME",
       "TOT_LOGGED_IN_TIME",
       "TOT_NOT_READY_TIME",
       "TOT_BREAK_TIME",
       "TOT_LUNCH_TIME",
       "QCS_PERFORMED",
       "AVG_QC_SCORE",
       "TOT_INCIDENTS_COMPLETED",
       "DAYS_INCIDENTS_COMPLETED",
       "TOT_DEFECTS_COMPLETED",
       "DAYS_DEFECTS_COMPLETED",
       "LAG_TIME_TOT_SCHED_PROD_TIME",
       "TOT_CALL_RECORDS",
       "TOT_CUSTOMER_COUNT",
       "TOT_CALL_WRAP_UP_COUNT",
       "TOT_WRAP_UP_ERROR",
       "DAYS_SHORT_CALLS_GT_10",
       "DAYS_CALLS_ANSWERED"
  from dp_scorecard.sc_summary_cc
;
 grant select on dp_scorecard.sc_summary_cc_sv to MAXDAT;
 grant select on dp_scorecard.sc_summary_cc_sv to maxdat_read_only;
 
 CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_SUMMARY_BO_EVENTS_SV AS
select staff_id,
       dates_month_num,
       dates_year,
       event_name_sort as sort_order,
       (event_name || ' >= 100%') as event_name,
       event_subname_sort,
       event_subname,
       to_char((metric * 100), '999.99') || '%' as metric
  from dp_scorecard.SC_SUMMARY_BO
 where (Event_subname = 'Task Production' or event_subname IS NULL);

GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV to MAXDAT;  
GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV to MAXDAT_READ_ONLY;  


CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_PRODUCTION_BO_SV AS
select staff_id,
       dates,
       event_name_sort as sort_order,
       event_name,
       event_subname_sort,
       event_subname,
       case when event_subname = 'Total Logged' then to_char(metric)
         when event_subname = 'Total Activity Time' then 
           to_char(trunc(round(metric * 3600,0)/3600), 'FM999999990')  || ':' || to_char(trunc(mod(round(metric * 3600,0),3600)/60), 'FM00') || ':' || to_char(mod(round(metric * 3600,0),60), 'FM00')
         else to_char((metric * 100), '999.99') || '%' end as metric 
  from dp_scorecard.sc_production_bo;

GRANT select on DP_SCORECARD.SCORECARD_PRODUCTION_BO_SV to MAXDAT;  
GRANT select on DP_SCORECARD.SCORECARD_PRODUCTION_BO_SV to MAXDAT_READ_ONLY;  

CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_SUMMARY_TL_SV AS
 WITH QC_metrics AS
 (
 select staff_staff_id,
           staff_staff_name,
           staff_natid,
           dates_month_num,
           dates_year,
           qcs_performed
      from dp_scorecard.scorecard_quality_tl_mthly_sv
 ),
ATTEND_Metrics AS
 (
  select staff_staff_id,
         staff_staff_name,
         dates_month,
         dates_month_num,
         dates_year,
         balance,
         total_balance,
         sc_attendance_id
    from dp_scorecard.scorecard_attendance_mthly_sv
 )
 SELECT
   all_staff.staff_staff_id,
   all_staff.staff_staff_name,
   all_staff.dates_month,
   all_staff.dates_month_num,
   all_staff.dates_year,
   am.balance,
   am.total_balance,
   qc.qcs_performed
 FROM (select distinct staff_staff_id,
         staff_staff_name,
         dates_month,
         dates_month_num,
         dates_year from dp_scorecard.scorecard_attendance_mthly_sv
         /*where staff_staff_id=1181*/) all_staff
 left outer join ATTEND_Metrics am on all_staff.staff_staff_id = am.staff_staff_id and all_staff.dates_month_num=am.dates_month_num 
 left outer join QC_metrics qc on all_staff.staff_staff_id = qc.staff_staff_id and all_staff.dates_month_num=qc.dates_month_num 
 order by all_staff.staff_staff_id,
         all_staff.dates_month_num
;

GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_TL_SV to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_TL_SV to MAXDAT;

CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_SUMMARY_CC_SV AS
WITH ATTEND_Metrics AS
 (
  select staff_staff_id,
         staff_staff_name,
         dates_month,
         dates_month_num,
         dates_year,
         balance,
         total_balance,
         sc_attendance_id
    from dp_scorecard.scorecard_attendance_mthly_sv
 )
select a10.staff_staff_id,
       a10.staff_staff_name,
       a10.dates_month,
       a10.dates_month_num,
       a10.dates_year,
       a10.exclusion_flag,
       a10.tot_calls_answered,
       a10.tot_short_calls_answered,
       a10.tot_tot_return_to_queue,
       a10.tot_average_handle_time,
       a10.tot_sched_productive_time,
       a10.tot_actual_productive_time,
       a10.tot_talk_time,
       a10.tot_wrap_up_time,
       a10.tot_logged_in_time,
       a10.tot_not_ready_time,
       a10.tot_break_time,
       a10.tot_lunch_time,
       a10.qcs_performed,
       a10.avg_qc_score,
       a10.tot_incidents_completed,
       a10.days_incidents_completed,
       a10.tot_defects_completed,
       a10.days_defects_completed,
       a10.lag_time_tot_sched_prod_time,
       a10.tot_call_records,
       a10.tot_customer_count,
       a10.tot_call_wrap_up_count,
       a10.tot_wrap_up_error,
       a10.days_short_calls_gt_10,
       a10.days_calls_answered,
       a11.balance,
       a11.total_balance
  from dp_scorecard.sc_summary_cc a10
  LEFT OUTER JOIN ATTEND_Metrics a11 ON a10.staff_staff_id=a11.staff_staff_id and  a10.dates_month_num=a11.dates_month_num  order by a10.staff_staff_id,
       a10.dates_month_num;
       
GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_CC_SV to MAXDAT_READ_ONLY;  
GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_CC_SV to MAXDAT;  

CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_INCIDENTS_SV AS
With incidents as 
(
  SELECT a11.STAFF_ID as staff_staff_id,
         trunc(a11.TASK_START) AS_DATE,
         count((Case when a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) then 1 else null end)) INCIDENTS_COMPLETED,
         count((Case when a11.EVENT_ID in (1373) then 1 else null end)) DEFECTS_COMPLETED
    FROM MAXDAT.PP_WFM_ACTUALS_SV a11
   WHERE TRUNC(a11.task_start) >= TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM')
     and (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) or
          a11.EVENT_ID in (1373))
     and a11.TASK_END is not null
   group by a11.staff_id, trunc(a11.TASK_START)
)
select a10.staff_staff_id, a10.staff_staff_name, as_date, INCIDENTS_COMPLETED, DEFECTS_COMPLETED
FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
join incidents i on a10.staff_staff_id=i.staff_staff_id;  

GRANT select on DP_SCORECARD.SCORECARD_INCIDENTS_SV to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_INCIDENTS_SV to MAXDAT;

--This is for Team Lead Quality:
  CREATE OR REPLACE FORCE VIEW "DP_SCORECARD"."SCORECARD_QUALITY_TL_SV" ("STAFF_STAFF_ID", "STAFF_STAFF_NAME", "STAFF_NATID", "EVALUATEE_EID", "EVALUATEE", "SCORECARD_SCORE_TYPE", "SCORE_TOTAL", "EVAL_DATE", "EVALUATION_REFERENCE") AS 
  with QUALITY AS
(
SELECT
A.EVALUATOR_ID, A.EVALUATION_DATE_TIME, F.SCORECARD_SCORE_TYPE, F.SCORECARD_GROUP, A.EVALUATION_REFERENCE, A.SCORE_TOTAL, 
A.AGENT_ID AS Evaluatee_EID, (LAST_NAME||', '|| FIRST_NAME) as Evaluatee
FROM DP_SCORECARD.ENGAGE_ACTUALS A
JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F ON A.EVALUATION_FORM = F.EVALUATION_FORM
JOIN MAXDAT.PP_WFM_STAFF S ON A.AGENT_ID=S.NATIONAL_ID 
)
SELECT distinct S.staff_staff_id,
       S.staff_staff_name,
       S.staff_natid,
       E.Evaluatee_EID,
       E.Evaluatee,
       E.SCORECARD_SCORE_TYPE,
       E.SCORE_TOTAL,
       E.EVALUATION_DATE_TIME as EVAL_DATE,
       E.EVALUATION_REFERENCE
  FROM dp_scorecard.scorecard_hierarchy_sv S
  JOIN QUALITY E ON S.staff_natid = E.EVALUATOR_ID;

GRANT select on DP_SCORECARD.SCORECARD_QUALITY_TL_SV to MAXDAT;
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_TL_SV to MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_QUALITY_TL_MTHLY_SV AS
With just_months as
(
      SELECT
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'MM/DD/YYYY') as dates,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'Month') as dates_month,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'YYYYMM') as dates_month_num,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'Month YYYY') as dates_year,
      0  as qcs_performed
    FROM Dual
    CONNECT BY Level <= MONTHS_BETWEEN(trunc(SYSDATE), TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM')) + 1
),
quality_by_month as
(
SELECT staff_staff_id,
       staff_staff_name,
       staff_natid,
       to_char(TRUNC(EVAL_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(EVAL_DATE), 'Month YYYY') as dates_year,
       count(*) over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as qcs_performed
  from dp_scorecard.scorecard_quality_tl_sv 
),
combined as
(
  select r.staff_staff_id,
         r.staff_staff_name,
         r.staff_natid,
         r.dates_month_num,
         r.dates_year,
         r.qcs_performed
         from quality_by_month r
  union
  select r.staff_staff_id,
         r.staff_staff_name,
         r.staff_natid,
         jm.dates_month_num,
         jm.dates_year,
         jm.qcs_performed
       from quality_by_month r, just_months jm
),
ranked as
(
select staff_staff_id,
         staff_staff_name,
         staff_natid,
         dates_month_num,
         dates_year,
         qcs_performed,
         rank() over(partition by staff_staff_id, dates_month_num order by qcs_performed desc) as rnk
         from combined order by staff_staff_id, dates_month_num
)
select staff_staff_id,
         staff_staff_name,
         staff_natid,
         dates_month_num,
         dates_year,
         qcs_performed
         from ranked where rnk=1;  
     
         
         
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV to MAXDAT;    
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV to MAXDAT_READ_ONLY;    

CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_QUALITY_SV AS
SELECT S.staff_staff_id,
       S.staff_staff_name,
       S.staff_natid,
       F.SCORECARD_SCORE_TYPE,
       E.SCORE_TOTAL,
       E.EVALUATION_DATE_TIME as EVAL_DATE,
       E.EVALUATION_REFERENCE
  FROM dp_scorecard.scorecard_hierarchy_sv S
  JOIN DP_SCORECARD.ENGAGE_ACTUALS E
    ON S.staff_natid = E.AGENT_ID
  JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F
    ON E.EVALUATION_FORM = F.EVALUATION_FORM
 WHERE F.SCORECARD_SCORE_TYPE = 'QC'
   AND TRUNC(EVALUATION_DATE_TIME) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM');
   
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_SV to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_SV to MAXDAT;
   
CREATE OR REPLACE VIEW dp_scorecard.SCORECARD_QUALITY_MTHLY_SV AS
with just_months as
(
      SELECT
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'MM/DD/YYYY') as dates,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'Month') as dates_month,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'YYYYMM') as dates_month_num,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'Month YYYY') as dates_year,
      0 as avg_qc_score,
      0  as qcs_performed
    FROM Dual
    CONNECT BY Level <= MONTHS_BETWEEN(trunc(SYSDATE), TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM')) + 1
),
quality_by_month as
(
SELECT distinct staff_staff_id,
       staff_staff_name,
       staff_natid,
       to_char(TRUNC(EVAL_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(EVAL_DATE), 'Month YYYY') as dates_year,
       avg(SCORE_TOTAL) over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as avg_qc_score,
       count(*) over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as qcs_performed
  from dp_scorecard.SCORECARD_QUALITY_SV    
),
combined as
(
  select r.staff_staff_id,
         r.staff_staff_name,
         r.staff_natid,
         r.dates_month_num,
         r.dates_year,
         r.avg_qc_score,
         r.qcs_performed
         from quality_by_month r
  union
  select r.staff_staff_id,
         r.staff_staff_name,
         r.staff_natid,
         jm.dates_month_num,
         jm.dates_year,
         jm.avg_qc_score,
         jm.qcs_performed
       from quality_by_month r, just_months jm
),
ranked as
(
select staff_staff_id,
         staff_staff_name,
         staff_natid,
         dates_month_num,
         dates_year,
         avg_qc_score,
         qcs_performed,
         rank() over(partition by staff_staff_id, dates_month_num order by qcs_performed desc) as rnk
         from combined order by staff_staff_id, dates_month_num
)
select staff_staff_id,
         staff_staff_name,
         staff_natid,
         dates_month_num,
         dates_year,
         avg_qc_score,
         qcs_performed
         from ranked where rnk=1;    

GRANT select on DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV to MAXDAT_READ_ONLY; 
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV to MAXDAT; 

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_QUALITY_TL_SV AS
with QUALITY AS
(
SELECT
A.EVALUATOR_ID, A.EVALUATION_DATE_TIME, F.SCORECARD_SCORE_TYPE, F.SCORECARD_GROUP, A.EVALUATION_REFERENCE, A.SCORE_TOTAL, 
A.AGENT_ID AS Evaluatee_EID, (LAST_NAME||', '|| FIRST_NAME) as Evaluatee
FROM DP_SCORECARD.ENGAGE_ACTUALS A
JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F ON A.EVALUATION_FORM = F.EVALUATION_FORM
JOIN MAXDAT.PP_WFM_STAFF S ON A.AGENT_ID=S.NATIONAL_ID 
)
SELECT distinct S.staff_staff_id,
       S.staff_staff_name,
       S.staff_natid,
       E.Evaluatee_EID,
       E.Evaluatee,
       E.SCORECARD_SCORE_TYPE,
       E.SCORE_TOTAL,
       E.EVALUATION_DATE_TIME as EVAL_DATE,
       E.EVALUATION_REFERENCE
  FROM dp_scorecard.scorecard_hierarchy_sv S
  JOIN QUALITY E ON S.staff_natid = E.EVALUATOR_ID;

GRANT select on DP_SCORECARD.SCORECARD_QUALITY_TL_SV to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_TL_SV to MAXDAT; 

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV AS
select supervisor_staff_id,
       to_date(dates_month_num,'YYYYMM') as d_date,
       dates_month,
       dates_month_num,
       dates_year,
       exclusion_flag,
       tot_calls_answered,
       tot_short_calls_answered,
       tot_tot_return_to_queue,
       tot_average_handle_time,
       tot_sched_productive_time,
       tot_actual_productive_time,
       tot_talk_time,
       tot_wrap_up_time,
       tot_logged_in_time,
       tot_not_ready_time,
       tot_break_time,
       tot_lunch_time,
       qcs_performed,
       avg_qc_score,
       tot_incidents_completed,
       days_incidents_completed,
       tot_defects_completed,
       days_defects_completed,
       lag_time_tot_sched_prod_time,
       tot_call_records,
       tot_customer_count,
       tot_call_wrap_up_count,
       tot_wrap_up_error,
       days_short_calls_gt_10,
       days_calls_answered,
       adherence,
       tot_return_to_queue_timeout,
       avg_attendance_balance,
       avg_attendance_total_balance
  from dp_scorecard.sc_summary_cc_rollup;
  
 
GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_SUMMARY_CC_ROLLUP_SV to MAXDAT;


