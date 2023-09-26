--NYHIX60537
DELETE FROM DP_SCORECARD.Sc_Lag_Time
WHERE (AGENT_ID IN ('263058')
AND TRUNC(LAG_DATE) in (to_date('09/14/2020','mm/dd/yyyy'))
OR AGENT_ID IN ('303854')
AND TRUNC(LAG_DATE) in (to_date('09/17/2020','mm/dd/yyyy'))
OR AGENT_ID IN ('296007')
AND TRUNC(LAG_DATE) in (to_date('09/16/2020','mm/dd/yyyy'),to_date('09/18/2020','mm/dd/yyyy')));
COMMIT;