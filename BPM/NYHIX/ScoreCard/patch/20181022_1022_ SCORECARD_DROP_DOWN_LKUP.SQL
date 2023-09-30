UPDATE dp_scorecard.scorecard_drop_down_lkup
SET DROP_DOWN_VALUE='3 - Meets Expectations'
where target_column='QPP_EVALUATION_RATING'
AND DROP_DOWN_ORDER=3;
 
commit; 