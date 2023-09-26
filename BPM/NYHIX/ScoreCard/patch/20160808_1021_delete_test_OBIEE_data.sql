delete from dp_scorecard.sc_agent_stat
where trunc(create_date) = to_date('05-AUG-2016','dd-MON-yyyy');

delete from dp_scorecard.sc_non_std_use
where trunc(create_date) = to_date('05-AUG-2016','dd-MON-yyyy');

delete from dp_scorecard.sc_lag_time
where trunc(create_date) = to_date('05-AUG-2016','dd-MON-yyyy');

delete from dp_scorecard.sc_wrap_up_error
where trunc(create_date) = to_date('05-AUG-2016','dd-MON-yyyy');

commit;