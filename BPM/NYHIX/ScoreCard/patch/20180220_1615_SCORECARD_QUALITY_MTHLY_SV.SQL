DROP VIEW DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV;

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
         to_number(get_numeric(r.staff_natid)) as staff_natid,
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
         FULL outer join all_columns2 ac on r.staff_staff_id=ac.staff_staff_id and r.dates_month_num=ac.dates_month_num
         )  
SELECT "STAFF_STAFF_ID","STAFF_STAFF_NAME","STAFF_NATID","DATES_MONTH_NUM","DATES_YEAR","AVG_QC_SCORE","QCS_PERFORMED","AUDITS","AUDITS_SUP_EVALED","QC_SCORE","SUP_SCORE","DEVIATION_SCORE","QC_EVALS","QC_EVALS_SCORE","DISPUTES","NON_DISPUTE_SCORE" FROM FINAL_QRY
WHERE STAFF_STAFF_ID IS NOT NULL
AND DATES_MONTH_NUM IS NOT NULL;


GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV TO DP_SCORECARD_READ_ONLY;

