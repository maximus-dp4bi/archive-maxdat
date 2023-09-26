
-- NYHIX-39411 - CR 1894 Add Goal Type to Dropdown in all Scorecards

insert into dp_scorecard.sc_goal_type_lkup
  (gtl_id, goal_type, end_date, create_by, create_datetime)
values
  (SEQ_SCGLT_ID.nextval, 'Career', to_date('07-07-2077', 'dd-mm-yyyy'), 'script', sysdate);

commit;
  
select * from dp_scorecard.sc_goal_type_lkup;

