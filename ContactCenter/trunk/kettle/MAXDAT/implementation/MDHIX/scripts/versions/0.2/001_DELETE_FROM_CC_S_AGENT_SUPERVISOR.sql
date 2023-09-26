-- This agent was end dated with an old date and was straing up deleted from pipkins.supervisor_to_staff table

delete from cc_s_agent_supervisor
where agent_id = (select agent_id from cc_s_agent
                   where first_name = 'Constance'
                   and last_name = 'Anderson'
                   and agent_id = 259);
                   
commit;                   