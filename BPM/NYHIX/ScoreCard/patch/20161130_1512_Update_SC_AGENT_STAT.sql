update sc_agent_stat
set actual_productive_time ='00:00:00'
where (as_date = to_date('11/04/2016','mm/dd/yyyy') and agent_id = 117681 and supervisor_id = 103144)
or (as_date = to_date('11/10/2016','mm/dd/yyyy') and agent_id = 117681 and supervisor_id = 103144) 
;

commit;
