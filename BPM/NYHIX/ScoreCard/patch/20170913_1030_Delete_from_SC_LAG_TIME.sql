 

delete from DP_SCORECARD.SC_LAG_TIME
WHERE AGENT_ID = '130276'
AND TRUNC(LAG_DATE) = '21-AUG-17';

commit;