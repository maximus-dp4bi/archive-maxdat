--- NYHIX-40176 

delete 
 FROM DP_SCORECARD.Sc_Lag_Time
 WHERE AGENT_ID =127148 AND TRUNC(LAG_DATE) = '10-APR-18';


commit;

SELECT *
 FROM DP_SCORECARD.Sc_Lag_Time
 WHERE (AGENT_ID IN ('127148') AND TRUNC(LAG_DATE) = '10-APR-18')
 ;