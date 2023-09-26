CREATE OR REPLACE PROCEDURE DP_SCORECARD.LOAD_SCORECARD_HIERARCHY
AS
BEGIN
delete scorecard_hierarchy where 1=1;
commit;

insert into scorecard_hierarchy ("ADMIN_ID", "SR_DIRECTOR_NAME", "SR_DIRECTOR_STAFF_ID", "SR_DIRECTOR_NATID", "DIRECTOR_NAME", "DIRECTOR_STAFF_ID", "DIRECTOR_NATID", "SR_MANAGER_NAME", "SR_MANAGER_STAFF_ID", "SR_MANAGER_NATID", "MANAGER_NAME", "MANAGER_STAFF_ID", "MANAGER_NATID", "SUPERVISOR_NAME", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NATID", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "STAFF_NATID", "HIRE_DATE", "POSITION", "OFFICE", "TERMINATION_DATE")
  with sr_directors as
(
select staff_id as sr_director_staff_id, national_id as sr_director_natid, (LAST_NAME||', '|| FIRST_NAME) as sr_director_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where code in ('Sr. Director'))
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, directors as
(
select staff_id as director_staff_id, national_id as director_natid, (LAST_NAME||', '|| FIRST_NAME) as director_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where code in ('Director'))
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, sr_managers as
(
select staff_id as sr_manager_staff_id, national_id as sr_manager_natid, (LAST_NAME||', '|| FIRST_NAME) as sr_manager_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where code in ('Sr. Manager'))
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, managers as
(
select staff_id as manager_staff_id, national_id as manager_natid, (LAST_NAME||', '|| FIRST_NAME) as manager_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where job_classification_code_id in (1057,1018,1044))--'Manager','CC Management','Enrollment & Eligibility Operations Manager'
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, supervisors as
(
select staff_id as supervisor_staff_id, national_id as supervisor_natid, (LAST_NAME||', '|| FIRST_NAME) as supervisor_name  from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where job_classification_code_id in (1058,1031)) --'Supervisor','E&E Supervisor'
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, srdir_to_dir as
(
--sr director to director
select srdirs.sr_director_name, srdirs.sr_director_staff_id, srdirs.sr_director_natid, dirs.director_name, dirs.director_staff_id, dirs.director_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join sr_directors srdirs on sts.supervisor_id=srdirs.sr_director_staff_id
join directors dirs on sts.staff_id=dirs.director_staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, dir_to_srmgr as
(
--director to sr manager
select dirs.director_name, dirs.director_staff_id, dirs.director_natid, srmgrs.sr_manager_name, srmgrs.sr_manager_staff_id, srmgrs.sr_manager_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join directors dirs on sts.supervisor_id=dirs.director_staff_id
join sr_managers srmgrs on sts.staff_id=srmgrs.sr_manager_staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, srmgr_to_mgr as
(
--sr manager to manager
select
srmgrs.sr_manager_name, srmgrs.sr_manager_staff_id, srmgrs.sr_manager_natid, mgrs.manager_name, mgrs.manager_staff_id, mgrs.manager_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join sr_managers srmgrs on sts.supervisor_id=srmgrs.sr_manager_staff_id
join managers mgrs on sts.staff_id=mgrs.manager_staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, mgr_to_sup as
(
--manager to supervisor
select mgrs.manager_name, mgrs.manager_staff_id, mgrs.manager_natid, sups.supervisor_name, sups.supervisor_staff_id, sups.supervisor_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join managers mgrs on sts.supervisor_id=mgrs.manager_staff_id
join supervisors sups on sts.staff_id=sups.supervisor_staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, sup_to_staff as
(
SELECT
S.staff_id as staff_staff_id,
S.NATIONAL_ID as staff_natid,
S.LAST_NAME||', '||S.FIRST_NAME as staff_staff_name,
S.HIRE_DATE,
S.TERMINATION_DATE,
JC.CODE POSITION,
O.NAME OFFICE,
S1.STAFF_ID as supervisor_staff_id,
S1.NATIONAL_ID as supervisor_natid,
S1.LAST_NAME||', '||S1.FIRST_NAME as supervisor_name/*,
S1.HIRE_DATE,
JC1.CODE SUP_POSITION*/
FROM MAXDAT.PP_WFM_STAFF_SV S
LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_SV J ON S.STAFF_ID = J.STAFF_ID
LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV JC ON J.JOB_CLASSIFICATION_CODE_ID = JC.JOB_CLASSIFICATION_CODE_ID
LEFT JOIN DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE_SV SO ON (S.STAFF_ID = SO.STAFF_ID AND SO.END_DATE IS NULL)
LEFT JOIN DP_SCORECARD.PP_WFM_OFFICE_SV O ON SO.OFFICE_ID = O.OFFICE_ID
LEFT JOIN MAXDAT.PP_WFM_SUPERVISOR_TO_STAFF_SV ST ON S.STAFF_ID = ST.STAFF_ID
LEFT JOIN MAXDAT.PP_WFM_STAFF_SV S1 ON ST.SUPERVISOR_ID = S1.STAFF_ID
--LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_SV J1 ON S1.STAFF_ID = J1.STAFF_ID
--LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV JC1 ON J1.JOB_CLASSIFICATION_CODE_ID = JC1.JOB_CLASSIFICATION_CODE_ID
WHERE J.END_DATE IS NULL
--AND J1.END_DATE IS NULL
AND ((ST.END_DATE IS NULL
or st.end_date >= sysdate)
  and st.effective_date <= sysdate)
AND JC.JOB_CLASSIFICATION_CODE_ID IN ('1068','1059','1054','1053','1024','1011','1010','1009','1008','1043','1019','1013','1012','1056','1047','1028','1025','1061','1032','1033','1060','1039','1063','1038','1037','1035','1052','1030','1022','1020','1046','1055','1026','1023','1027','1045','1051','1050','1049','1048','1017','1016','1015','1014')
--AND (S.TERMINATION_DATE IS NULL or S.TERMINATION_DATE > TRUNC(SYSDATE))
)
select 999 as admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
       sdtd.sr_director_name,
       sdtd.sr_director_staff_id,
       sdtd.sr_director_natid,
       dts.director_name,
       dts.director_staff_id,
       dts.director_natid,
       dts.sr_manager_name,
       dts.sr_manager_staff_id,
       dts.sr_manager_natid,
       stm.manager_name,
       stm.manager_staff_id,
       stm.manager_natid,
       mts.supervisor_name,
       mts.supervisor_staff_id,
       mts.supervisor_natid,
       sts.staff_staff_id,
       sts.staff_staff_name,
       sts.staff_natid,
       sts.hire_date,
       sts.position,
       sts.office,
       sts.termination_date
  from srdir_to_dir sdtd
  left outer join dir_to_srmgr dts on sdtd.director_staff_id = dts.director_staff_id
  left outer join  srmgr_to_mgr stm
    on dts.sr_manager_staff_id = stm.sr_manager_staff_id
  left outer join  mgr_to_sup mts
    on stm.manager_staff_id = mts.manager_staff_id
  left outer join  sup_to_staff sts
    on mts.supervisor_staff_id = sts.supervisor_staff_id
  order by
  sdtd.sr_director_name,
       dts.director_name,
       dts.sr_manager_name,
       stm.manager_name,
       mts.supervisor_name,
       sts.staff_staff_name
;
commit;
END LOAD_SCORECARD_HIERARCHY;
/

GRANT EXECUTE ON DP_SCORECARD.LOAD_SCORECARD_HIERARCHY TO MAXDAT;
GRANT EXECUTE ON DP_SCORECARD.LOAD_SCORECARD_HIERARCHY TO MAXDAT_MSTR_TRX_RPT;
GRANT EXECUTE ON DP_SCORECARD.LOAD_SCORECARD_HIERARCHY TO MAXDAT_READ_ONLY;
GRANT EXECUTE ON DP_SCORECARD.LOAD_SCORECARD_HIERARCHY TO MAXDAT_REPORTS;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_HIERARCHY_SV
AS
select 999 as admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
       h.sr_director_name,
       h.sr_director_staff_id,
       h.sr_director_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.sr_director_staff_id = s.Staff_id) sr_director_termination_date,
       h.director_name,
       h.director_staff_id,
       h.director_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.director_staff_id = s.Staff_id) director_termination_date,
       h.sr_manager_name,
       h.sr_manager_staff_id,
       h.sr_manager_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.sr_manager_staff_id = s.Staff_id) sr_manager_termination_date,
       h.manager_name,
       h.manager_staff_id,
       h.manager_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.manager_staff_id = s.Staff_id) manager_termination_date,
       h.supervisor_name,
       h.supervisor_staff_id,
       h.supervisor_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.supervisor_staff_id = s.Staff_id) supervisor_termination_date,
       h.staff_staff_id,
       h.staff_staff_name,
       h.staff_natid,
       h.hire_date,
       h.position,
       h.office,
       h.termination_date,
       (select distinct d.name from dp_scorecard.pp_wfm_staff_to_department std
        join dp_scorecard.pp_wfm_department d on std.department_id=d.department_id
        where trunc(std.effective_date) <= trunc(sysdate) and coalesce(std.end_date,to_date('07/07/7777','mm/dd/yyyy')) > trunc(sysdate) and std.staff_id=h.staff_staff_id) as department,
       (select building from dp_scorecard.scorecard_office_building_lkup obl where obl.office=h.office) as building
  from dp_scorecard.scorecard_hierarchy h
    WITH READ ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO DP_SCORECARD_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO MAXDAT;

CREATE OR REPLACE procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP
AS

begin

    Delete from dp_scorecard.SC_SUMMARY_CC_ROLLUP;
    commit;

insert into dp_scorecard.SC_SUMMARY_CC_ROLLUP (supervisor_staff_id,
   dates_month,
   dates_month_num,
   dates_year,
   EXCLUSION_FLAG,
   TOT_CALLS_ANSWERED,
   TOT_SHORT_CALLS_ANSWERED,
   TOT_TOT_RETURN_TO_QUEUE,
   TOT_RETURN_TO_QUEUE_TIMEOUT,
   TOT_AVERAGE_HANDLE_TIME,
   TOT_SCHED_PRODUCTIVE_TIME,
   TOT_ACTUAL_PRODUCTIVE_TIME,
   TOT_TALK_TIME,
   TOT_WRAP_UP_TIME,
   TOT_LOGGED_IN_TIME,
   TOT_NOT_READY_TIME,
   TOT_BREAK_TIME,
   TOT_LUNCH_TIME,
   qcs_performed,
   avg_qc_score,
   TOT_INCIDENTS_COMPLETED,
   DAYS_INCIDENTS_COMPLETED,
   TOT_DEFECTS_COMPLETED,
   DAYS_DEFECTS_COMPLETED,
   LAG_TIME_TOT_SCHED_PROD_TIME,
   TOT_CALL_RECORDS,
   TOT_CUSTOMER_COUNT,
   TOT_CALL_WRAP_UP_COUNT,
   TOT_WRAP_UP_ERROR,
   Days_Short_Calls_GT_10,
   DAYS_CALLS_ANSWERED,
   ADHERENCE,
   avg_attendance_balance,
   avg_attendance_total_balance,
   staff_count,
   qcs_remaining,
   sum_qc_score,
   count_qc_score,
   TOT_HANDLE_TIME,
   TOT_HANDLE_TIME_COUNT,
   STAFF_TRTQ_COUNT,
   Short_Call_Agent_Count
   )

WITH attendance as
(
select distinct a.SUPERVISOR_STAFF_ID,
                DATES_MONTH,
                DATES_MONTH_NUM,
                DATES_YEAR,
                SUM(BALANCE) over(partition by a.SUPERVISOR_STAFF_ID, dates_month_num) as BALANCE,
                SUM(TOTAL_BALANCE) over(partition by a.SUPERVISOR_STAFF_ID, dates_month_num) as TOTAL_BALANCE,
                --SC_ATTENDANCE_ID,
                COUNT(h.staff_staff_id) over(partition by a.SUPERVISOR_STAFF_ID, dates_month_num) as STAFF_COUNT
from dp_scorecard.scorecard_attendance_mthly_sv a
 join dp_scorecard.scorecard_hierarchy_sv h on a.STAFF_STAFF_ID=h.staff_staff_id
 where to_date(a.DATES_MONTH_NUM,'YYYYMM') >= ADD_MONTHS((LAST_DAY(h.hire_date)+1),-1)
 order by supervisor_staff_id, dates_month_num

),
TIME_metrics as
 (
   SELECT
      distinct
      to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
      to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year,
       a_s.supervisor_staff_id,
       EXCLUSION_FLAG,
       sum(CALLS_ANSWERED) TOT_CALLS_ANSWERED,
       sum(SHORT_CALLS_ANSWERED) TOT_SHORT_CALLS_ANSWERED,
       sum(TOT_RETURN_TO_QUEUE) TOT_TOT_RETURN_TO_QUEUE,
       sum(TOT_RETURN_TO_QUEUE_TIMEOUT) TOT_RETURN_TO_QUEUE_TIMEOUT,
       avg(extract( day from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
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
         extract( second from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LUNCH_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_HANDLE_TIME,
         count(1) as TOT_HANDLE_TIME_COUNT
         FROM dp_scorecard.scorecard_hierarchy_sv a_s
        join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a_s.staff_natid =  a11.AGENT_ID
        Where TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), to_char(TRUNC(a11.AS_DATE), 'Month YYYY'),a_s.supervisor_staff_id, EXCLUSION_FLAG
 ),
 QC_metrics AS
 (
 select distinct supervisor_staff_id,
           dates_month_num,
           dates_year,
           avg_qc_score,
           qcs_performed,
           qcs_remaining,
           sum_qc_score,
           count_qc_score
      from dp_scorecard.scorecard_quality_mthly_ru_sv
 ),
INCDEFS AS
 (
   SELECT a10.supervisor_staff_id,
   trunc(a11.TASK_START) AS_DATE,
       to_char(TRUNC(a11.TASK_START), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.TASK_START), 'Month YYYY') as dates_year,
        count((Case when a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) then 1 else null end)) INCIDENTS_COMPLETED,
        count((Case when a11.EVENT_ID in (1373) then 1 else null end)) DEFECTS_COMPLETED
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join MAXDAT.PP_WFM_ACTUALS_SV a11 on a10.staff_staff_id=a11.staff_id
   WHERE TRUNC(a11.task_start) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
  and (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379)
         or a11.EVENT_ID in (1373))
         and a11.TASK_END is not null and trunc(a11.TASK_START)=trunc(a11.TASK_END)
   group by a10.supervisor_staff_id, trunc(TASK_START)
 ),
 INC_metrics AS
 (
 select
   distinct a11.supervisor_staff_id,
       a11.dates_month_num,
       a11.dates_year,
        sum(a11.INCIDENTS_COMPLETED) OVER (PARTITION BY a11.supervisor_staff_id, a11.dates_month_num) as TOT_INCIDENTS_COMPLETED,
        count(a11.INCIDENTS_COMPLETED) OVER (PARTITION BY a11.supervisor_staff_id, a11.dates_month_num) as DAYS_INCIDENTS_COMPLETED
   from  INCDEFS a11
   where  a11.INCIDENTS_COMPLETED <> 0
 ),
 DEF_metrics AS
 (
 select
   distinct a11.supervisor_staff_id,
       a11.dates_month_num,
       a11.dates_year,
       sum(a11.DEFECTS_COMPLETED) OVER (PARTITION BY a11.supervisor_staff_id, a11.dates_month_num) as TOT_DEFECTS_COMPLETED,
       count(a11.DEFECTS_COMPLETED) OVER (PARTITION BY a11.supervisor_staff_id, a11.dates_month_num) as  DAYS_DEFECTS_COMPLETED
   from  INCDEFS a11
   where  a11.DEFECTS_COMPLETED <> 0
 ) ,
 LAG_metrics AS (
   SELECT
       distinct to_char(TRUNC(a11.LAG_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.LAG_DATE), 'Month YYYY') as dates_year,
        a10.supervisor_staff_id,
        sum(extract( day from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) )
        over (partition by a10.supervisor_staff_id, to_char(TRUNC(a11.LAG_DATE), 'YYYYMM')) as LAG_TIME_TOT_SCHED_PROD_TIME
       FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_LAG_TIME_SV a11 on a10.staff_natid = a11.agent_id
  join (select trunc(as_date) as as_date, agent_id from DP_SCORECARD.SC_AGENT_STAT_SV
        where TRUNC(AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')) a12
        on  a12.agent_id=a10.staff_natid and a12.as_date= TRUNC(a11.LAG_DATE)
  WHERE TRUNC(a11.LAG_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
 CUST_metrics AS
 (
    SELECT distinct
      to_char(TRUNC(a11.CALL_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.CALL_DATE), 'Month YYYY') as dates_year,
       a10.supervisor_staff_id,
       count(CALL_RECORD_ID) over (partition by a10.supervisor_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as  TOT_CALL_RECORDS,
       sum(CUSTOMER_COUNT) over (partition by a10.supervisor_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as TOT_CUSTOMER_COUNT,
       sum(CALL_WRAP_UP_COUNT) over (partition by a10.supervisor_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as TOT_CALL_WRAP_UP_COUNT
    FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_NON_STD_USE_SV a11 on to_char(a10.staff_natid) = a11.Employee_ID
  WHERE TRUNC(a11.CALL_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
 WUE_metrics AS
 (
   SELECT distinct
       to_char(TRUNC(a11.WUE_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.WUE_DATE), 'Month YYYY') as dates_year,
        a10.supervisor_staff_id,
        sum(a11.WRAP_UP_ERROR) over (partition by a10.supervisor_staff_id,to_char(TRUNC(a11.WUE_DATE), 'Month YYYY')) as TOT_WRAP_UP_ERROR
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_WRAP_UP_ERROR_SV a11 on a10.staff_natid = a11.AGENT_ID
  WHERE TRUNC(a11.WUE_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
CALL_metrics AS
 (
 SELECT
        a10.supervisor_staff_id,
       dates_month_num,
       dates_year,
        sum(short_calls) as short_calls
       -- sum(TOT_CALLS) TOT_CALLS
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join
  (
  SELECT
       a20.staff_staff_id,
       a21.AS_DATE,
        CASE WHEN sum(a21.SHORT_CALLS_ANSWERED) > 10 THEN 1 ELSE null END short_calls,
     --   sum(a21.CALLS_ANSWERED) TOT_CALLS,
       to_char(TRUNC(a21.AS_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a21.AS_DATE), 'Month YYYY') as dates_year
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a20
  join DP_SCORECARD.SC_AGENT_STAT_SV a21 on a20.staff_natid = a21.AGENT_ID
  WHERE TRUNC(a21.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
   GROUP BY a20.staff_staff_id, a21.AS_DATE
  ) a11 on a10.staff_staff_id = a11.staff_staff_id
   GROUP BY a10.supervisor_staff_id, dates_month_num, dates_year

 ),
 CALL_days AS
 (
   SELECT distinct
        supervisor_staff_id,
        dates_month_num,
        dates_year,
         short_calls as Days_Short_Calls_GT_10
       --  TOT_CALLS as DAYS_CALLS_ANSWERED
   FROM CALL_metrics
  ),
--Unique Days Called
Unique_Calls_Metrics AS
 (
 SELECT
   distinct a11.supervisor_staff_id,
   dates_month_num,
   dates_year,
   count(Unique_Days) as DAYS_CALLS_ANSWERED
    from
    (
     SELECT
               distinct a20.supervisor_staff_id,--a20.staff_staff_id,
               to_char(TRUNC(a21.AS_DATE), 'YYYYMM') as dates_month_num,
               to_char(TRUNC(a21.AS_DATE), 'Month YYYY') as dates_year,
               TRUNC(a21.AS_DATE) as Unique_Days
           FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a20
          join DP_SCORECARD.SC_AGENT_STAT_SV a21 on a20.staff_natid = a21.AGENT_ID
          WHERE TRUNC(a21.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
          --order by a20.supervisor_staff_id, TRUNC(a21.AS_DATE)
    ) a11
   GROUP BY a11.supervisor_staff_id, dates_month_num, dates_year
   --ORDER BY a11.supervisor_staff_id, dates_month_num

 ),

----
  Adherence as
 (
   SELECT distinct
      dates_month_num,
      dates_year,
       supervisor_staff_id,
       EXCLUSION_FLAG,
       SUM(TOT_LOGGED_IN_TIME) as TOT_LOGGED_IN_TIME,
       SUM(TOT_NOT_READY_TIME) as TOT_NOT_READY_TIME
       from
       (
   SELECT distinct
      to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
      to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year,
      to_char(a11.AGENT_ID) AGENT_ID,
      a_s.staff_staff_id,
      a_s.supervisor_staff_id,
       a11.EXCLUSION_FLAG,
       sum(extract( day from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LOGGED_IN_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_NOT_READY_TIME
         FROM dp_scorecard.scorecard_hierarchy_sv a_s
        join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a_s.staff_natid =  a11.AGENT_ID
        join (SELECT TRUNC(a111.LAG_DATE) as LAG_DATE, a101.staff_staff_id, a111.agent_id
                  FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a101
                  join DP_SCORECARD.SC_LAG_TIME_SV a111
                    on a101.staff_natid = a111.agent_id
                 WHERE TRUNC(a111.LAG_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
              ) a12 on a11.agent_Id=a12.agent_Id and a11.AS_Date=a12.lag_date
        where TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')  /*and a11.EXCLUSION_FLAG='N'*/
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), to_char(TRUNC(a11.AS_DATE), 'Month YYYY'),a_s.staff_staff_id, a11.AGENT_ID, a_s.supervisor_staff_id, a11.EXCLUSION_FLAG
    )
    group by dates_month_num,
      dates_year,
       supervisor_staff_id,
       EXCLUSION_FLAG
 ),
Adherence_metric as
 (

   SELECT distinct
      a10.dates_month_num,
      a10.dates_year,
      a10.supervisor_staff_id,
      ((a10.TOT_LOGGED_IN_TIME - a10.TOT_NOT_READY_TIME)/a11.LAG_TIME_TOT_SCHED_PROD_TIME) as ADHERENCE
      FROM Adherence a10
      join LAG_metrics a11 on a10.supervisor_staff_id=a11.supervisor_staff_id and a10.dates_year=a11.dates_year

 ),
TRTQ_Agent_Count as
(
--Description: Identifies the amount of agents that had more than 50 Total Return to Queue's per month
  select a10.supervisor_staff_id,
      dates_month_num,
      dates_year,
      sum(TRTQ) as TRTQ,
      sum(STAFF_TRTQ_COUNT) as STAFF_TRTQ_COUNT
      FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
      join
      (
          SELECT
          H.staff_staff_id,
          to_char(TRUNC(AS_DATE), 'YYYYMM') as dates_month_num,
          to_char(TRUNC(AS_DATE), 'Month YYYY') as dates_year,
          SUM(TOT_RET_TO_QUEUE_TOTAL) TRTQ,
          CASE WHEN SUM(TOT_RET_TO_QUEUE_TOTAL) > 50 THEN '1' ELSE '0' END AS STAFF_TRTQ_COUNT
          FROM DP_SCORECARD.SC_AGENT_STAT_SV S
          JOIN DP_SCORECARD.SCORECARD_HIERARCHY H ON H.STAFF_NATID = S.AGENT_ID
          where TRUNC(AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
          GROUP BY to_char(TRUNC(AS_DATE), 'YYYYMM'), to_char(TRUNC(AS_DATE), 'Month YYYY'), H.staff_staff_id
      ) a11 on a10.staff_staff_id = a11.staff_staff_id
     GROUP BY a10.supervisor_staff_id, dates_month_num, dates_year
),
Short_Call_Agent_Count as
(
--Description: Identifies the distinct amount of agents that had a day with over 10 short calls.
select distinct
supervisor_staff_id,
dates_month_num,
dates_year,
COUNT(DISTINCT AGENT_ID) over (partition by supervisor_staff_id, dates_month_num) as Short_Call_Agent_Count
FROM
  (
      select
       H.supervisor_staff_id,
       agent_id,
       to_char(TRUNC(AS_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(AS_DATE), 'Month YYYY') as dates_year,
       TRUNC(AS_DATE),
       SHORT_CALLS_ANSWERED
        from DP_SCORECARD.SC_AGENT_STAT S
        JOIN DP_SCORECARD.SCORECARD_HIERARCHY H ON H.STAFF_NATID = S.AGENT_ID
       where TRUNC(AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
       and SHORT_CALLS_ANSWERED > 10
       --order by H.supervisor_staff_id,to_char(TRUNC(AS_DATE), 'YYYYMM')
  )
)
 SELECT
   distinct all_staff.supervisor_staff_id,
   all_staff.dates_month,
   all_staff.dates_month_num,
   all_staff.dates_year,
   tm.EXCLUSION_FLAG,
   tm.TOT_CALLS_ANSWERED,
   tm.TOT_SHORT_CALLS_ANSWERED,
   tm.TOT_TOT_RETURN_TO_QUEUE,
   tm.TOT_RETURN_TO_QUEUE_TIMEOUT,
   tm.TOT_AVERAGE_HANDLE_TIME,
   tm.TOT_SCHED_PRODUCTIVE_TIME,
   tm.TOT_ACTUAL_PRODUCTIVE_TIME,
   tm.TOT_TALK_TIME,
   tm.TOT_WRAP_UP_TIME,
   tm.TOT_LOGGED_IN_TIME,
   tm.TOT_NOT_READY_TIME,
   tm.TOT_BREAK_TIME,
   tm.TOT_LUNCH_TIME,
   qc.qcs_performed,
   qc.avg_qc_score,
   im.TOT_INCIDENTS_COMPLETED,
   im.DAYS_INCIDENTS_COMPLETED,
   dm.TOT_DEFECTS_COMPLETED,
   dm.DAYS_DEFECTS_COMPLETED,
   lt.LAG_TIME_TOT_SCHED_PROD_TIME,
   cm.TOT_CALL_RECORDS,
   cm.TOT_CUSTOMER_COUNT,
   cm.TOT_CALL_WRAP_UP_COUNT,
   wm.TOT_WRAP_UP_ERROR,
   cd.Days_Short_Calls_GT_10,
   ucm.DAYS_CALLS_ANSWERED,
   a.ADHERENCE,
   a.balance,
   a.total_balance,
   a.staff_count,
   qc.qcs_remaining,
   qc.sum_qc_score,
   qc.count_qc_score,
   tm.TOT_HANDLE_TIME,
   tm.TOT_HANDLE_TIME_COUNT,
   tac.STAFF_TRTQ_COUNT,
   scac.Short_Call_Agent_Count
 FROM (select distinct supervisor_staff_id,
         dates_month,
         dates_month_num,
         dates_year from dp_scorecard.scorecard_attendance_mthly_sv
         ) all_staff
 left outer join attendance a on all_staff.supervisor_staff_id = a.supervisor_staff_id and all_staff.dates_month_num=a.dates_month_num
 left outer join TIME_metrics tm on all_staff.supervisor_staff_id = tm.supervisor_staff_id and all_staff.dates_month_num=tm.dates_month_num
 left outer join QC_metrics qc on all_staff.supervisor_staff_id = qc.supervisor_staff_id and all_staff.dates_month_num=qc.dates_month_num
 left outer join INC_metrics im on all_staff.supervisor_staff_id = im.supervisor_staff_id and all_staff.dates_month_num=im.dates_month_num
 left outer join DEF_metrics dm on all_staff.supervisor_staff_id = dm.supervisor_staff_id and all_staff.dates_month_num=dm.dates_month_num
 left outer join LAG_metrics lt on all_staff.supervisor_staff_id = lt.supervisor_staff_id and all_staff.dates_month_num=lt.dates_month_num
 left outer join CUST_metrics cm on all_staff.supervisor_staff_id = cm.supervisor_staff_id and all_staff.dates_month_num=cm.dates_month_num
left outer join WUE_metrics wm on all_staff.supervisor_staff_id = wm.supervisor_staff_id and all_staff.dates_month_num=wm.dates_month_num
left outer join CALL_days cd on all_staff.supervisor_staff_id = cd.supervisor_staff_id and all_staff.dates_month_num=cd.dates_month_num
left outer join Adherence_metric a on all_staff.supervisor_staff_id = a.supervisor_staff_id and all_staff.dates_month_num=a.dates_month_num
left outer join Unique_Calls_Metrics ucm on all_staff.supervisor_staff_id = ucm.supervisor_staff_id and all_staff.dates_month_num=ucm.dates_month_num
left outer join TRTQ_Agent_Count tac on all_staff.supervisor_staff_id = tac.supervisor_staff_id and all_staff.dates_month_num=tac.dates_month_num
left outer join Short_Call_Agent_Count scac  on all_staff.supervisor_staff_id = scac.supervisor_staff_id and all_staff.dates_month_num=scac.dates_month_num;
/*where all_staff.supervisor_staff_id in (select distinct supervisor_staff_id from dp_scorecard.scorecard_hierarchy_sv where manager_staff_id=1378);*/

commit;
END LOAD_SC_SUMMARY_CC_ROLLUP;
/

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP TO MAXDAT_READ_ONLY;
GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP TO MAXDAT;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_INCIDENTS_SV
AS
With incidents as
 (
   SELECT a11.STAFF_ID as staff_staff_id,
          trunc(a11.TASK_START) AS_DATE,
          count((Case when a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) then 1 else null end)) INCIDENTS_COMPLETED,
          count((Case when a11.EVENT_ID in (1373) then 1 else null end)) DEFECTS_COMPLETED
     FROM MAXDAT.PP_WFM_ACTUALS_SV a11
    WHERE TRUNC(a11.task_start) >= TRUNC(SYSDATE-60) and trunc(a11.TASK_END)=trunc(a11.TASK_START)
      and (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) or
           a11.EVENT_ID in (1373))
      and trunc(a11.TASK_END)=trunc(a11.TASK_START)
    group by a11.staff_id, trunc(a11.TASK_START)
 )
 select a10.staff_staff_id, a10.staff_staff_name, as_date, INCIDENTS_COMPLETED, DEFECTS_COMPLETED
 FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
 join incidents i on a10.staff_staff_id=i.staff_staff_id
;

GRANT SELECT ON DP_SCORECARD.SCORECARD_INCIDENTS_SV TO DP_SCORECARD_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_INCIDENTS_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_INCIDENTS_SV TO MAXDAT;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_SV
AS
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

GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_SV TO DP_SCORECARD_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_SV TO MAXDAT;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_SUMMARY_TL_SV
AS
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

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_TL_SV TO DP_SCORECARD_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_TL_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_TL_SV TO MAXDAT;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV
AS
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
  from sc_attend_entries;

GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV TO DP_SCORECARD_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV TO MAXDAT;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_GOAL_SV
AS
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

GRANT SELECT ON DP_SCORECARD.SCORECARD_GOAL_SV TO DP_SCORECARD_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_GOAL_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_GOAL_SV TO MAXDAT;


CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV
AS
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

GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO DP_SCORECARD_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO MAXDAT;

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

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_SV TO DP_SCORECARD_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_SV TO MAXDAT;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_PRODUCTION_BO_SV
AS
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
  from dp_scorecard.sc_production_bo
;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PRODUCTION_BO_SV TO DP_SCORECARD_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PRODUCTION_BO_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PRODUCTION_BO_SV TO MAXDAT;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV
AS
select staff_id,
       dates_month_num,
       dates_year,
       event_name_sort as sort_order,
       (event_name || ' >= 100%') as event_name,
       event_subname_sort,
       event_subname,
       to_char((metric * 100), '999.99') || '%' as metric
  from dp_scorecard.SC_SUMMARY_BO
 where (Event_subname = 'Task Production' or event_subname IS NULL)
;

GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV TO DP_SCORECARD_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_SUMMARY_BO_EVENTS_SV TO MAXDAT;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV
AS
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

GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO DP_SCORECARD_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO MAXDAT;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_PROD_DP_BO_SV
AS
select dates, staff_id,  event_name, event_name_sort as event_sort_id, metric as productivity from dp_scorecard.sc_production_bo
where event_name='Daily Production'
UNION
select dates, staff_id,  event_name, event_name_sort as event_sort_id, metric as productivity from dp_scorecard.sc_production_bo
where event_name='Daily Adherence';

GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO DP_SCORECARD_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_DP_BO_SV TO MAXDAT;

