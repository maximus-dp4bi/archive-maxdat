--- NYHIX-42817
SELECT * -- 1 records
FROM   DP_SCORECARD.Sc_Lag_Time 
WHERE  AGENT_ID = 87822
AND    TRUNC(LAG_DATE) = to_date('27-JUL-2018','DD-MON-YYYY');

delete from DP_SCORECARD.Sc_Lag_Time
where  agent_id = 87822 
and    TRUNC(LAG_DATE) = to_date('27-JUL-2018','DD-MON-YYYY');

commit;

SELECT *  -- 0 records
FROM   DP_SCORECARD.Sc_Lag_Time
WHERE  AGENT_ID = 87822
AND    TRUNC(LAG_DATE) = to_date('27-JUL-2018','DD-MON-YYYY');
