--- NYHIX-42103
SELECT * -- 1 record
FROM DP_SCORECARD.Sc_Lag_Time 
WHERE (AGENT_ID IN ('128259')
AND TRUNC(LAG_DATE) in ('23-JUN-18')) 

delete from DP_SCORECARD.Sc_Lag_Time
where agent_id = 128259 
and TRUNC(LAG_DATE) in ('23-JUN-18');
commit;

SELECT *  -- 0 records
FROM DP_SCORECARD.Sc_Lag_Time
WHERE (AGENT_ID IN ('128259')
AND TRUNC(LAG_DATE) in ('23-JUN-18'))
;