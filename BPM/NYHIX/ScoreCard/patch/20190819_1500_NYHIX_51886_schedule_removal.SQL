DELETE FROM DP_SCORECARD.Sc_Lag_Time
 WHERE (AGENT_ID IN ('125576') AND TRUNC(LAG_DATE) in ('05-Aug-19'))
 OR (AGENT_ID IN ('262495') AND TRUNC(LAG_DATE) in ('01-Aug-19'))
 OR (AGENT_ID IN ('262495') AND TRUNC(LAG_DATE) in ('02-Aug-19'))
 OR (AGENT_ID IN ('262495') AND TRUNC(LAG_DATE) in ('03-Aug-19'))
 OR (AGENT_ID IN ('262495') AND TRUNC(LAG_DATE) in ('04-Aug-19'))
 OR (AGENT_ID IN ('262495') AND TRUNC(LAG_DATE) in ('05-Aug-19'))
 OR (AGENT_ID IN ('262495') AND TRUNC(LAG_DATE) in ('06-Aug-19'))
 OR (AGENT_ID IN ('262495') AND TRUNC(LAG_DATE) in ('07-Aug-19'));
-- Order by AGENT_ID, LAG_DATE;
 
 -- Commit if ONLY ONE row was deleted