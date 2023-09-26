--NYHIX60585
DELETE FROM DP_SCORECARD.Sc_Lag_Time
WHERE (AGENT_ID IN ('127185')
AND TRUNC(LAG_DATE) in (to_date('09/25/2020','mm/dd/yyyy')))
OR (AGENT_ID IN ('283397')
AND TRUNC(LAG_DATE) in (to_date('08/31/2020','mm/dd/yyyy')))
OR (AGENT_ID IN ('265765')
AND TRUNC(LAG_DATE) in (to_date('09/02/2020','mm/dd/yyyy'),
to_date('09/03/2020','mm/dd/yyyy')))
OR (AGENT_ID IN ('124170')
AND TRUNC(LAG_DATE) in (to_date('09/23/2020','mm/dd/yyyy'),
to_date('09/24/2020','mm/dd/yyyy'),
to_date('09/25/2020','mm/dd/yyyy'),
to_date('09/28/2020','mm/dd/yyyy')))
OR (AGENT_ID IN ('273958')
AND TRUNC(LAG_DATE) in (to_date('09/24/2020','mm/dd/yyyy')));
COMMIT;