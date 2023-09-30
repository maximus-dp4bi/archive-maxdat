--NYHIX60207
Delete FROM DP_SCORECARD.Sc_Lag_Time
WHERE (AGENT_ID IN ('250435') AND TRUNC(LAG_DATE) in (to_date('08/10/2020','mm/dd/yyyy'),to_date('08/14/2020','mm/dd/yyyy')));
COMMIT;