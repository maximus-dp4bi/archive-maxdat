--- NYHIX-42371
SELECT * -- 1 records
FROM   DP_SCORECARD.Sc_Lag_Time 
WHERE  AGENT_ID = 129738
AND    TRUNC(LAG_DATE) = to_date('12-JUL-2018','DD-MON-YYYY');

delete from DP_SCORECARD.Sc_Lag_Time
where  agent_id = 129738 
and    TRUNC(LAG_DATE) = to_date('12-JUL-2018','DD-MON-YYYY');

commit;

SELECT *  -- 0 records
FROM   DP_SCORECARD.Sc_Lag_Time
WHERE  AGENT_ID = 129738
AND    TRUNC(LAG_DATE) = to_date('12-JUL-2018','DD-MON-YYYY');
