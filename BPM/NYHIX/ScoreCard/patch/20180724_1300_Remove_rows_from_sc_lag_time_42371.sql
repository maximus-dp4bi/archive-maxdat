--- NYHIX-42371
SELECT * -- 2 records
FROM   DP_SCORECARD.Sc_Lag_Time 
WHERE  AGENT_ID = 143971
AND    TRUNC(LAG_DATE) IN (to_date('09-JUL-2018','DD-MON-YYYY'), TO_DATE('11-JUL-2018','DD-MON-YYYY'));

delete from DP_SCORECARD.Sc_Lag_Time
where  agent_id = 143971 
and    TRUNC(LAG_DATE) IN (to_date('09-JUL-2018','DD-MON-YYYY'), TO_DATE('11-JUL-2018','DD-MON-YYYY'));

commit;

SELECT *  -- 0 records
FROM   DP_SCORECARD.Sc_Lag_Time
WHERE  AGENT_ID = 143971
AND    TRUNC(LAG_DATE) IN (to_date('09-JUL-2018','DD-MON-YYYY'), TO_DATE('11-JUL-2018','DD-MON-YYYY'));
;