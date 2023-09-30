DROP VIEW DP_SCORECARD.SCORECARD_QUALITY_SV;

/* Formatted on 4/25/2019 10:39:12 AM (QP5 v5.326) */
CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_QUALITY_SV
(
    STAFF_STAFF_ID,
    STAFF_STAFF_NAME,
    STAFF_NATID,
    SCORECARD_SCORE_TYPE,
    SCORE_TOTAL,
    EVAL_DATE,
    EVALUATION_REFERENCE,
    EVALUATOR_ID,
    EVALUATOR,
    EVALUATION_DATE_TIME,
    CALL_DATE
)
BEQUEATH DEFINER
AS
    SELECT -- Modified for NYSOH - Scorecard - CR 1662 - QC Table Update
           -- Modified for NYHIX-42454 CR 1822- Scorecard Quality tab Evaluation date
           S.staff_staff_id,
           S.staff_staff_name,
           S.staff_natid,
           F.SCORECARD_SCORE_TYPE,
           E.SCORE_TOTAL,
           CASE
               WHEN (   e.call_date IS NULL
                     OR e.call_date = TO_DATE ('1/1/1753', 'mm/dd/yyyy'))
               THEN
                   E.EVALUATION_DATE_TIME
               ELSE
                   e.call_date
           END
               AS EVAL_DATE,
           E.EVALUATION_REFERENCE,
           E.evaluator_id,
           ST.LAST_NAME || ', ' || ST.FIRST_NAME
               EVALUATOR,
           E.EVALUATION_DATE_TIME,
           E.CALL_DATE
      FROM dp_scorecard.scorecard_hierarchy_sv  S
           JOIN DP_SCORECARD.ENGAGE_ACTUALS_SV E
               ON S.staff_natid = E.AGENT_ID
           JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F
               ON E.EVALUATION_FORM = F.EVALUATION_FORM
           LEFT JOIN
           (SELECT DISTINCT national_id, LAST_NAME, FIRST_NAME
              FROM MAXDAT.PP_WFM_STAFF
             WHERE     delete_date IS NULL
                   AND (national_id, last_update_dt) IN
                           (  SELECT national_id, MAX (last_update_dt)
                                FROM MAXDAT.PP_WFM_STAFF
                               WHERE delete_date IS NULL
                            GROUP BY national_id)) ST
               ON ST.NATIONAL_ID = E.EVALUATOR_ID
     WHERE     F.SCORECARD_SCORE_TYPE = 'QC'
           --AND TRUNC(EVALUATION_DATE_TIME) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
           AND CASE
                   WHEN (   e.call_date IS NULL
                         OR e.call_date = TO_DATE ('1/1/1753', 'mm/dd/yyyy'))
                   THEN
                       E.EVALUATION_DATE_TIME
                   ELSE
                       e.call_date
               END >=
               TRUNC (ADD_MONTHS (SYSDATE, -12), 'MM');


GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_SV TO MAXDAT_MSTR_TRX_RPT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_SV TO RESTORE;
