--- NYHIX-43615
delete from DP_SCORECARD.Sc_Lag_Time
where agent_id = 125683
and TRUNC(LAG_DATE) in ('13-AUG-18');
commit;


SELECT *
FROM DP_SCORECARD.Sc_Lag_Time
WHERE (AGENT_ID IN ('125683') AND TRUNC(LAG_DATE) in ('13-AUG-18'))
;


