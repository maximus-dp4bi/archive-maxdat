DELETE FROM DP_SCORECARD.Sc_Lag_Time
WHERE (AGENT_ID IN ('312857') AND TRUNC(LAG_DATE) in ('10-AUG-20','11-AUG-20','12-AUG-20','13-AUG-20'));
COMMIT;