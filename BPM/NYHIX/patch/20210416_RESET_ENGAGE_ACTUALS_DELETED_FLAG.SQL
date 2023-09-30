-- from the DP_SCORECARD schema
alter session set current_schema = DP_SCORECARD;

update dp_scorecard.engage_actuals 
	set deleted_flag = null
where to_char(evaluation_date_time,'yyyymm') > '202009';

commit;