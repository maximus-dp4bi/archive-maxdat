-- CORRECT  table IS dp_scorecard.PP_WFM_TASK_AUDIT_PPK_TASK_ID
drop table dp_scorecard.PP_WFM_TASK_AUDIT_PPK_TASK;

-- Table is NOT USED  was part of an test version of the sync process
drop table dp_scorecard.PP_WFM_TASK_AUDIT_SC_DELETES;

-- USED BY
-- DP_SCORECARD	PACKAGE BODY	PP_WFM_TASK_BO_30_DAY_SYNC_PKG	VALID
drop table DP_SCORECARD.PP_WFM_TASK_BO_SYNC_W30;


alter TABLE DP_SCORECARD.SC_ATTENDANCE
drop column   CALC_DATE; 

alter TABLE DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY
drop column   CALC_DATE; 

-- Test table
DROP TABLE DP_SCORECARD.PP_WFM_TASK_ID_EXTRACT;


-- DROP TEST VIEW
DROP VIEW DP_SCORECARD.SCORECARD_QUALITY_MTHLY_RUSVXX;

DROP VIEW DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV
AS
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
/

drop procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC_v1;

