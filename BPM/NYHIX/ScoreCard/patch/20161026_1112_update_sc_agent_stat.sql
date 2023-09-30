update sc_agent_stat
set logged_in_time ='00:00:00'
where agent_id = 126071
and as_date = to_date('25-OCT-2016 00:00:00','dd-MON-yyyy hh24:mi:ss');

commit;
