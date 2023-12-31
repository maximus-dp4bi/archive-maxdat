CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_QUALITY_SV
AS
SELECT S.staff_staff_id,
       S.staff_staff_name,
       S.staff_natid,
       F.SCORECARD_SCORE_TYPE,
       E.SCORE_TOTAL,
       Case when (e.call_date is null or e.call_date = to_date('1/1/1753','mm/dd/yyyy')) then E.EVALUATION_DATE_TIME else e.call_date end as EVAL_DATE,
       E.EVALUATION_REFERENCE
  FROM dp_scorecard.scorecard_hierarchy_sv S
  JOIN DP_SCORECARD.ENGAGE_ACTUALS_SV E
    ON S.staff_natid = E.AGENT_ID
  JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F
    ON E.EVALUATION_FORM = F.EVALUATION_FORM
WHERE F.SCORECARD_SCORE_TYPE = 'QC'
   AND TRUNC(EVALUATION_DATE_TIME) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_SV TO MAXDAT;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV
AS
select staff_staff_id,
       staff_staff_name,
       staff_natid,
       dates_month_num,
       dates_year,
       audits as qcs_performed
  from dp_scorecard.scorecard_quality_mthly_sv
;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV TO MAXDAT;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_QUALITY_TL_SV
AS
with QUALITY AS
(
SELECT DISTINCT A.EVALUATOR_ID,
                Case when (A.CALL_DATE is null or A.CALL_DATE = to_date('1/1/1753','mm/dd/yyyy')) then A.EVALUATION_DATE_TIME else A.CALL_DATE end as EVALUATION_DATE_TIME,
                F.SCORECARD_SCORE_TYPE,
                F.SCORECARD_GROUP,
                A.EVALUATION_REFERENCE,
                A.SCORE_TOTAL,
                A.AGENT_ID AS Evaluatee_EID,
                (LAST_NAME || ', ' || FIRST_NAME) as Evaluatee
  FROM DP_SCORECARD.ENGAGE_ACTUALS_SV A
  JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F
    ON A.EVALUATION_FORM = F.EVALUATION_FORM
  JOIN MAXDAT.PP_WFM_STAFF S
    ON A.AGENT_ID = S.NATIONAL_ID
 WHERE F.SCORECARD_SCORE_TYPE = 'QC'
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
  JOIN QUALITY E ON S.staff_natid = E.EVALUATOR_ID
;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_TL_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_TL_SV TO MAXDAT;

