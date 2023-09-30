--- NYHIX-42103
SELECT * -- 1 record
FROM DP_SCORECARD.Sc_Lag_Time 
WHERE (AGENT_ID IN ('137326')
AND TRUNC(LAG_DATE) in ('21-JUN-18')) 

delete from DP_SCORECARD.Sc_Lag_Time
where agent_id = 137326 
and TRUNC(LAG_DATE) in ('21-JUN-18');
commit;

SELECT *  -- 0 records
FROM DP_SCORECARD.Sc_Lag_Time
WHERE (AGENT_ID IN ('137326') AND TRUNC(LAG_DATE) in ('21-JUN-18'))
;