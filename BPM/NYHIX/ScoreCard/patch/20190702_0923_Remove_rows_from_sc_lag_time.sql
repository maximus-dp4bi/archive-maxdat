--- NYHIX-41874 
delete from DP_SCORECARD.Sc_Lag_Time
where agent_id = 134875 
and TRUNC(LAG_DATE) in ('09-JUN-18','11-JUN-18');
commit;


SELECT *
FROM DP_SCORECARD.Sc_Lag_Time
WHERE (AGENT_ID IN ('134875') AND TRUNC(LAG_DATE) in ('09-JUN-18','11-JUN-18'))
;