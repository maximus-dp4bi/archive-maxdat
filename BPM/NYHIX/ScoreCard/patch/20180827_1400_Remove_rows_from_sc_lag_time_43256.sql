-- NYHIX-43256
SELECT * -- 1 records
FROM   DP_SCORECARD.Sc_Lag_Time 
WHERE  AGENT_ID = 142114
AND    TRUNC(LAG_DATE) = to_date('04-AUG-18','DD-MON-RR');

delete from DP_SCORECARD.Sc_Lag_Time
where  agent_id = 142114 
and    TRUNC(LAG_DATE) = to_date('04-AUG-18','DD-MON-RR');

commit;

SELECT *  -- 0 records
FROM   DP_SCORECARD.Sc_Lag_Time
WHERE  AGENT_ID = 142114
AND    TRUNC(LAG_DATE) = to_date('04-AUG-18','DD-MON-RR');
