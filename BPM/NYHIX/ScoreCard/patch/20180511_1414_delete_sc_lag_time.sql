--- NYHIX-40176 
delete from  DP_SCORECARD.Sc_Lag_Time
where agent_id = 101810 and trunc(lag_date) in ('02-APR-18', '05-APR-18');

commit;


SELECT *
FROM DP_SCORECARD.Sc_Lag_Time
WHERE (AGENT_ID IN ('101810') AND TRUNC(LAG_DATE) in ('02-APR-18', '05-APR-18'))
;


