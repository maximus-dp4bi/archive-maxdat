Delete  FROM DP_SCORECARD.Sc_Lag_Time
WHERE (AGENT_ID IN ('263580') AND TRUNC(LAG_DATE) in ('25-JUN-20'))
OR (AGENT_ID IN ('250760') AND TRUNC(LAG_DATE) in ('25-JUN-20'))
OR (AGENT_ID IN ('123989') AND TRUNC(LAG_DATE) in ('02-JUL-20'));
COMMIT;