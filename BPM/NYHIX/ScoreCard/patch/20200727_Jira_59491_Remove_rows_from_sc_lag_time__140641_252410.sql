-- NYHIX-59491

DELETE FROM DP_SCORECARD.Sc_Lag_Time WHERE (AGENT_ID IN ('140641') AND TRUNC(LAG_DATE) in ('07-JUL-20'));

COMMIT;

-- NYHIX-59491

DELETE FROM DP_SCORECARD.Sc_Lag_Time WHERE (AGENT_ID IN ('252410') AND TRUNC(LAG_DATE) in ('02-JUL-20'));

COMMIT;


