-- NYHIX-57924


    DELETE FROM DP_SCORECARD.Sc_Lag_Time WHERE (AGENT_ID IN ('137323') AND TRUNC(LAG_DATE) in ('17-APR-20'));

    commit;