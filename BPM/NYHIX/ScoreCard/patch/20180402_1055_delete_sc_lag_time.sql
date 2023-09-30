--- NYHIX-39585 - NYSOH - Scorecard - Schedule Removal - PRD - 04.02.18

Delete FROM DP_SCORECARD.Sc_Lag_Time
where AGENT_ID =125902 AND TRUNC(LAG_DATE) BETWEEN '12-MAR-18' AND '19-MAR-18';

delete from DP_SCORECARD.Sc_Lag_Time
where AGENT_ID =125517 AND TRUNC(LAG_DATE) ='14-MAR-18';

delete from DP_SCORECARD.Sc_Lag_Time
where AGENT_ID =135311 AND TRUNC(LAG_DATE)='14-MAR-18';
commit;

SELECT *
FROM DP_SCORECARD.Sc_Lag_Time
WHERE ((AGENT_ID IN ('125902') AND TRUNC(LAG_DATE) BETWEEN '12-MAR-18' AND '19-MAR-18')
or (AGENT_ID IN ('125517') AND TRUNC(LAG_DATE) IN ('14-MAR-18'))
or (AGENT_ID IN ('135311') AND TRUNC(LAG_DATE) IN ('14-MAR-18')))
ORDER BY AGENT_ID, LAG_DATE;