--- NYHIX-43079
SELECT * -- 1 records
FROM   DP_SCORECARD.Sc_Lag_Time 
WHERE  AGENT_ID = 121956
AND    TRUNC(LAG_DATE) = to_date('02-AUG-18','DD-MON-RR');

delete from DP_SCORECARD.Sc_Lag_Time
where  agent_id = 121956 
and    TRUNC(LAG_DATE) = to_date('02-AUG-18','DD-MON-RR');

commit;

SELECT *  -- 0 records
FROM   DP_SCORECARD.Sc_Lag_Time
WHERE  AGENT_ID = 121956
AND    TRUNC(LAG_DATE) = to_date('02-AUG-18','DD-MON-RR');
