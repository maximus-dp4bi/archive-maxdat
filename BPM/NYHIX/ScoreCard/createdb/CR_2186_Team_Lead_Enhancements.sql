alter table DP_SCORECARD.SCORECARD_DROP_DOWN_LKUP
modify DROP_DOWN_VALUE null;


INSERT INTO DP_SCORECARD.SCORECARD_DROP_DOWN_LKUP (
   TARGET_TABLE, TARGET_COLUMN, DROP_DOWN_ORDER, 
   DROP_DOWN_VALUE, EFFECTIVE_DATE, END_DATE, 
   DROP_DOWN_METRIC, DROP_DOWN_RANGE_LOW, DROP_DOWN_RANGE_HIGH) 
VALUES ( 
'SC_AUDIT_TEAM_LEAD_QUALITY' /* TARGET_TABLE */,
'QPP_QUALITY_SCORE_1_RATING' /* TARGET_COLUMN */,
4 /* DROP_DOWN_ORDER */,
NULL /* DROP_DOWN_VALUE */,
to_date('1/1/2017','dd/mm/yyyy') /* EFFECTIVE_DATE */,
null /* END_DATE */,
null /* DROP_DOWN_METRIC */,
null /* DROP_DOWN_RANGE_LOW */,
null /* DROP_DOWN_RANGE_HIGH */ );

INSERT INTO DP_SCORECARD.SCORECARD_DROP_DOWN_LKUP (
   TARGET_TABLE, TARGET_COLUMN, DROP_DOWN_ORDER, 
   DROP_DOWN_VALUE, EFFECTIVE_DATE, END_DATE, 
   DROP_DOWN_METRIC, DROP_DOWN_RANGE_LOW, DROP_DOWN_RANGE_HIGH) 
VALUES ( 
'SC_AUDIT_TEAM_LEAD_QUALITY' /* TARGET_TABLE */,
'QPP_QUALITY_SCORE_2_RATING' /* TARGET_COLUMN */,
4 /* DROP_DOWN_ORDER */,
NULL /* DROP_DOWN_VALUE */,
to_date('1/1/2017','dd/mm/yyyy') /* EFFECTIVE_DATE */,
null /* END_DATE */,
null /* DROP_DOWN_METRIC */,
null /* DROP_DOWN_RANGE_LOW */,
null /* DROP_DOWN_RANGE_HIGH */ );

commit;

