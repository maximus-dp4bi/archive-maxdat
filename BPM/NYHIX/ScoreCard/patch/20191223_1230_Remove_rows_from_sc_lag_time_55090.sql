-- NYHIX-55090


    DELETE FROM DP_SCORECARD.Sc_Lag_Time WHERE (AGENT_ID IN ('270233') AND TRUNC(LAG_DATE) in ('03-DEC-19'));

    DELETE FROM DP_SCORECARD.Sc_Lag_Time WHERE (AGENT_ID IN ('148062') AND TRUNC(LAG_DATE) in ('21-OCT-19'));

    commit;