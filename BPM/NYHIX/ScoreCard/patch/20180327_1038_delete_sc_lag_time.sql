--- NYHIX-39184 - NYSOH - Scorecard - Schedule Removal - PRD - 03.21.18


delete from DP_SCORECARD.Sc_Lag_Time where 
 AGENT_ID = '136434' AND TRUNC(LAG_DATE) IN ('01-MAR-18','02-MAR-18');
 
commit;