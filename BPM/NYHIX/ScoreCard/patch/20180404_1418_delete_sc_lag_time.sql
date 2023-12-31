--- NYHIX-39674 

delete FROM DP_SCORECARD.Sc_Lag_Time
where AGENT_ID =125854 AND TRUNC(LAG_DATE)  BETWEEN '01-MAR-18' AND '09-MAR-18';

commit;

SELECT *
FROM DP_SCORECARD.Sc_Lag_Time
WHERE ((AGENT_ID IN ('125854') AND TRUNC(LAG_DATE) BETWEEN '01-MAR-18' AND '09-MAR-18'))
ORDER BY AGENT_ID, LAG_DATE;