--- NYHIX-34998

delete from DP_SCORECARD.SC_LAG_TIME
where AGENT_ID = '105287'
AND TRUNC(LAG_DATE) IN ('11-SEP-17', '12-SEP-17');

delete FROM DP_SCORECARD.SC_LAG_TIME
WHERE AGENT_ID = '105612'
AND TRUNC(LAG_DATE) IN ('11-SEP-17', '13-SEP-17');
commit;