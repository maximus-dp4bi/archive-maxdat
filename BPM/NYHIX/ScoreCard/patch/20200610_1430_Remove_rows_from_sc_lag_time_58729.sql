-- NYHIX-58729

DELETE FROM DP_SCORECARD.Sc_Lag_Time WHERE (AGENT_ID IN ('204313') AND TRUNC(LAG_DATE) in ('08-MAY-20'));

COMMIT;


