--- NYHIX-37812 

delete FROM DP_SCORECARD.Sc_Lag_Time
WHERE AGENT_ID IN ('123915')
AND TRUNC(LAG_DATE) = '02-JAN-18';
commit;