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
    ON --(
    S.staff_natid = E.AGENT_ID
--    or S.staff_natid = E.EVALUATOR_ID) ---added this to test
  JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F
    ON E.EVALUATION_FORM = F.EVALUATION_FORM
WHERE F.SCORECARD_SCORE_TYPE = 'QC'
   AND TRUNC(EVALUATION_DATE_TIME) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_SV TO MAXDAT;

