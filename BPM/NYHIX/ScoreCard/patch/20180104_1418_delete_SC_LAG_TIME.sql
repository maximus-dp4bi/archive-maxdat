--- NYHIX-37234

delete 
FROM DP_SCORECARD.Sc_Lag_Time
WHERE AGENT_ID IN (
'147101',
'147415',
'138090')
AND TRUNC(LAG_DATE) = '14-DEC-17';
commit;
