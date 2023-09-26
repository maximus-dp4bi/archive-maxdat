--DROP VIEW DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV
(STAFF_STAFF_ID, STAFF_STAFF_NAME, STAFF_NATID, DATES_MONTH_NUM, DATES_YEAR, 
 AVG_QC_SCORE, QCS_PERFORMED, AUDITS, AUDITS_SUP_EVALED, QC_SCORE, 
 SUP_SCORE, DEVIATION_SCORE, QC_EVALS, QC_EVALS_SCORE, DISPUTES, 
 NON_DISPUTE_SCORE)
AS 
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
       avg(SCORE_TOTAL) as avg_qc_score,	--over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as avg_qc_score,
       count(*)  as qcs_performed 			-- over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as qcs_performed
  from dp_scorecard.SCORECARD_QUALITY_SV
  group by staff_staff_id, staff_natid, staff_staff_name, to_char(TRUNC(EVAL_DATE), 'YYYYMM'), to_char(TRUNC(EVAL_DATE), 'Month YYYY')
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
    --   from quality_by_month r, just_months jm
    FROM DP_SCORECARD.SCORECARD_HIERARCHY R, just_months jm
    WHERE JM.DATES_MONTH_NUM BETWEEN TO_CHAR(R.HIRE_DATE,'YYYYMM') AND TO_CHAR(NVL(R.TERMINATION_DATE,SYSDATE),'YYYYMM')
),
ranked as
(
select staff_staff_id,
         staff_staff_name,
         staff_natid,
         dates_month_num,
         dates_year,
        sum( avg_qc_score) as avg_qc_score,
        sum( qcs_performed) as qcs_performed
         from combined group by staff_staff_id, staff_natid, staff_staff_name, dates_year, dates_month_num --order by staff_staff_id, dates_month_num
),
rank_filter as
(
select staff_staff_id,
         staff_staff_name,
         staff_natid,
         dates_month_num,
         dates_year,
         avg_qc_score,
         qcs_performed
         from ranked --where rnk=1
)
,
all_columns as
(
SELECT
H.STAFF_STAFF_ID,
H.STAFF_NATID,
H.STAFF_STAFF_NAME STAFF,
F.SCORECARD_SCORE_TYPE,  ---THIS IS JUST THERE FOR TESTING PURPOSE
CASE WHEN A.CALL_DATE IS NULL THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') END AS EVAL_MONTH, --ADD
--TRUNC(TO_DATE(A.EVALUATION_DATE_TIME),'MONTH') EVAL_MONTH, -- REMOVE
COUNT(DISTINCT A.EVALUATION_REFERENCE) AUDITS,
COUNT(DISTINCT A1.EVALUATION_REFERENCE) AUDITS_SUP_EVALED, --CHANGE
ROUND(AVG(A1.SCORE_TOTAL),2) QC_SCORE,
--COUNT(DISTINCT S.EVALUATION_REFERENCE) SUP_AUDITS,--REMOVE
ROUND(AVG(S.SCORE_TOTAL),2) SUP_SCORE,
(ROUND(AVG(S.SCORE_TOTAL),2) - ROUND(AVG(A1.SCORE_TOTAL),2)) DEVIATION_SCORE,
E.QC_EVALS,
E.QC_EVALS_SCORE,
X.QC_DISPUTES DISPUTES, --CHANGE
ROUND(((COUNT(DISTINCT A.EVALUATION_REFERENCE)- X.QC_DISPUTES)/(COUNT(DISTINCT A.EVALUATION_REFERENCE))),2) NON_DISPUTE_SCORE
FROM DP_SCORECARD.ENGAGE_ACTUALS_SV A
JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F ON A.EVALUATION_FORM = F.EVALUATION_FORM -- CHANGE
JOIN DP_SCORECARD.SCORECARD_HIERARCHY H ON A.EVALUATOR_ID = H.STAFF_NATID                    --<<<<< EVALUATOR
LEFT JOIN DP_SCORECARD.ENGAGE_ACTUALS_SUP S ON A.EVALUATION_REFERENCE = S.QC_EVALUATION_ID --CHANGEXX
LEFT JOIN DP_SCORECARD.ENGAGE_ACTUALS_SV A1 ON A1.EVALUATION_REFERENCE = S.QC_EVALUATION_ID --CHANGEXX
LEFT JOIN (
  SELECT TO_CHAR(EVALUATION_DATE_TIME,'YYYYMM') QC_MONTH,
  AGENT_ID,
  COUNT(EVALUATION_REFERENCE) QC_EVALS,
  ROUND(AVG(SCORE_TOTAL),2) QC_EVALS_SCORE
  FROM DP_SCORECARD.ENGAGE_ACTUALS_QC_EVAL
  GROUP BY TO_CHAR(EVALUATION_DATE_TIME,'YYYYMM'), AGENT_ID) E
      ON (A.EVALUATOR_ID = E.AGENT_ID AND CASE WHEN A.CALL_DATE IS NULL THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') END = E.QC_MONTH) --CHANGEXX
LEFT JOIN (
  SELECT TO_CHAR(PT_ENTRY_DATE,'YYYYMM') ENTRY_DATE,
  H.STAFF_NATID,
  COUNT(PT_ID) QC_DISPUTES
  FROM DP_SCORECARD.SC_PERFORMANCE_TRACKER T
  LEFT JOIN DP_SCORECARD.SCORECARD_HIERARCHY H ON T.STAFF_ID = H.STAFF_STAFF_ID
  LEFT JOIN DP_SCORECARD.SC_DISCUSSION_LKUP L ON L.DL_ID = T.DL_ID
  WHERE L.DISCUSSION_TOPIC = 'QC Dispute'
  GROUP BY TO_CHAR(PT_ENTRY_DATE,'YYYYMM'), H.STAFF_NATID) X
      ON (X.STAFF_NATID = A.EVALUATOR_ID AND CASE WHEN A.CALL_DATE IS NULL THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') END = x.ENTRY_DATE)  --CHANGE XX
WHERE 1=1
AND F.SCORECARD_SCORE_TYPE = 'QC'
GROUP BY H.STAFF_STAFF_ID,
H.STAFF_NATID,
H.STAFF_STAFF_NAME,
F.SCORECARD_SCORE_TYPE,
CASE WHEN A.CALL_DATE IS NULL THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') END, --ADD
E.QC_EVALS,
E.QC_EVALS_SCORE,
X.QC_DISPUTES
),
all_columns2 as
(
SELECT
STAFF_STAFF_ID,
STAFF_NATID,
SCORECARD_SCORE_TYPE,  ---THIS IS JUST THERE FOR TESTING PURPOSE
EVAL_MONTH as dates_month_num ,
AUDITS,
AUDITS_SUP_EVALED, --CHANGE
QC_SCORE,
SUP_SCORE,
DEVIATION_SCORE,
QC_EVALS,
QC_EVALS_SCORE,
DISPUTES, --CHANGE
NON_DISPUTE_SCORE
FROM all_columns
),
FINAL_QRY AS (
select r.staff_staff_id,
         r.staff_staff_name,
         to_number(r.staff_natid) as staff_natid ,
         r.dates_month_num,
         r.dates_year,
         r.avg_qc_score,
         r.qcs_performed,
         ac.AUDITS, --new
         ac.AUDITS_SUP_EVALED, --new
         ac.QC_SCORE, --new
         ac.SUP_SCORE, --same
         ac.DEVIATION_SCORE, --same
         ac.QC_EVALS, --same
         ac.QC_EVALS_SCORE, --same
         ac.DISPUTES, --NEW
         ac.NON_DISPUTE_SCORE --same
         --NON_DISPUTES  --DELETED
         from rank_filter r
         FULL OUTER JOIN all_columns2 ac on r.staff_staff_id=ac.staff_staff_id and r.dates_month_num=ac.dates_month_num
         )
SELECT STAFF_STAFF_ID,STAFF_STAFF_NAME,STAFF_NATID,DATES_MONTH_NUM,DATES_YEAR,
	AVG_QC_SCORE,QCS_PERFORMED,AUDITS,AUDITS_SUP_EVALED,QC_SCORE,
	SUP_SCORE,DEVIATION_SCORE,QC_EVALS,QC_EVALS_SCORE,
	DISPUTES,NON_DISPUTE_SCORE FROM FINAL_QRY
WHERE STAFF_STAFF_ID IS NOT NULL
AND DATES_MONTH_NUM IS NOT NULL;


GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV TO MAXDAT_READ_ONLY;

-------------------------------------------------------------------

--DROP VIEW DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV
(STAFF_STAFF_ID, STAFF_STAFF_NAME, STAFF_NATID, DATES_MONTH_NUM, DATES_YEAR, 
 QCS_PERFORMED)
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


GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV TO MAXDAT_READ_ONLY;

--------------------------------------------------------------------------------

--DROP VIEW DP_SCORECARD.SCORECARD_EXCLUSION_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_EXCLUSION_SV
(EXCLUSION_ID, SUPERVISOR_STAFF_ID, SUPERVISOR_NAME, STAFF_NATID, STAFF_STAFF_ID, 
 STAFF_STAFF_NAME, EXCLUSION_DATE, EXCLUSION_FLAG, EXCLUSION_COMMENT, CREATE_DATE, 
 CREATE_BY)
AS 
select exclusion_ID,
       supervisor_id as supervisor_staff_id,
       (select distinct supervisor_name from dp_scorecard.scorecard_hierarchy x where x.supervisor_staff_id=supervisor_id) as supervisor_name,
       agent_id as staff_natid,
       staff_id as staff_staff_id,
       (select distinct staff_staff_name from dp_scorecard.scorecard_hierarchy x where x.staff_staff_id=staff_id) as staff_staff_name,
       exclusion_date,
       exclusion_flag,
       exclusion_comment,
       create_date,
       case
         when Create_by_name is null then
          to_char(create_by)
         else
          create_by_name
       end as create_by
  from (select e.exclusion_ID,
               e.supervisor_id,
               e.agent_id,
               e.staff_id,
               e.exclusion_date,
               e.exclusion_flag,
               e.exclusion_comment,
               e.create_date,
               Create_by,
               (select sr_director_name as create_by
                  from dp_scorecard.scorecard_hierarchy_sv
                 where to_char(sr_director_natid) = to_char(e.create_by)
                union
                select director_name as create_by
                  from dp_scorecard.scorecard_hierarchy_sv
                 where to_char(director_natid) = to_char(e.create_by)
                union
                select sr_manager_name as create_by
                  from dp_scorecard.scorecard_hierarchy_sv
                 where to_char(sr_manager_natid) = to_char(e.create_by)
                union
                select manager_name as create_by
                  from dp_scorecard.scorecard_hierarchy_sv
                 where to_char(manager_natid) = to_char(e.create_by)
                union
                select supervisor_name as create_by
                  from dp_scorecard.scorecard_hierarchy_sv
                 where to_char(supervisor_natid) = to_char(e.create_by)) as Create_by_name
          from SC_EXCLUSION e
          where e.exclusion_flag = 'Y'
          and not exists (select 1 from sc_exclusion b
                                   where b.exclusion_date = e.exclusion_date
                                   and b.agent_id = e.agent_id
                                   and b.staff_id = e.staff_id
                                   and b.exclusion_id > e.exclusion_id
                                   and b.exclusion_flag = 'N'));


GRANT SELECT ON DP_SCORECARD.SCORECARD_EXCLUSION_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_EXCLUSION_SV TO MAXDAT_READ_ONLY;