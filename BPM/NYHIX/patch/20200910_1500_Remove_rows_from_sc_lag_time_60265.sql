--NYHIX60265
Delete FROM DP_SCORECARD.Sc_Lag_Time
WHERE (AGENT_ID IN ('299583')
AND TRUNC(LAG_DATE) in (to_date('08/21/2020','mm/dd/yyyy'),
to_date('08/24/2020','mm/dd/yyyy')))
OR (AGENT_ID IN ('141632')
AND TRUNC(LAG_DATE) in (to_date('08/24/2020','mm/dd/yyyy'),
to_date('08/25/2020','mm/dd/yyyy'),
to_date('08/26/2020','mm/dd/yyyy')));
COMMIT;