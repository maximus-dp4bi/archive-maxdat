--NYHIX60304
DELETE FROM DP_SCORECARD.Sc_Lag_Time
WHERE (AGENT_ID IN ('256591')
AND TRUNC(LAG_DATE) in (to_date('09/03/2020','mm/dd/yyyy')))
OR (AGENT_ID IN ('276402')
AND TRUNC(LAG_DATE) in (to_date('08/31/2020','mm/dd/yyyy')));
COMMIT;