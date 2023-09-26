update sc_agent_stat
set logged_in_time = '00:00:00'
where as_date = to_date('10/25/2016','mm/dd/yyyy')
and agent_id = 126071;

commit;

