update sc_agent_stat
set TOT_RETURN_TO_QUEUE_TIMEOUT = 0
where TOT_RETURN_TO_QUEUE_TIMEOUT is null;

commit;
