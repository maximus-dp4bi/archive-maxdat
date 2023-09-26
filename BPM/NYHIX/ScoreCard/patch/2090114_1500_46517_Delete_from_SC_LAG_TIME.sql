delete from DP_SCORECARD.Sc_Lag_Time
WHERE (AGENT_ID IN ( '130271') AND TRUNC(LAG_DATE) = '03-DEC-18');

commit;

/