-- NYHIX-56066


    DELETE FROM DP_SCORECARD.Sc_Lag_Time WHERE (AGENT_ID IN ('257937') AND TRUNC(LAG_DATE) in ('10-JAN-20','16-JAN-20'));

    commit;