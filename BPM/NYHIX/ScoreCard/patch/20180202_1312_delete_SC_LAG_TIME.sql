--- NYHIX-37905 

delete FROM DP_SCORECARD.Sc_Lag_Time
 WHERE AGENT_ID = 111414
 AND TRUNC(LAG_DATE) = '19-JAN-18';

delete from DP_SCORECARD.Sc_Lag_Time
where agent_ID =128732
 AND TRUNC(LAG_DATE) = '11-JAN-18';
 
delete from DP_SCORECARD.Sc_Lag_Time
where AGENT_ID =127291
 AND TRUNC(LAG_DATE) IN ('07-NOV-17','08-NOV-17','13-NOV-17','14-NOV-17');

commit;
