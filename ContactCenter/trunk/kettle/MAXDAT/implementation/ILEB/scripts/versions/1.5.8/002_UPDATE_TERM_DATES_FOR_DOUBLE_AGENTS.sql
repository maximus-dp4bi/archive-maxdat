alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

-- Angela Walls
--Staging:

update cc_s_agent
set termination_date = '11-NOV-14 00:00:00'
where login_id in ('73126', '73216'); 

-- Dimensional

update cc_d_agent
set termination_date = '11-NOV-14 00:00:00'
where login_id in ('73126', '73216');


-- Iesha Davis
-- Staging

update cc_s_agent
set termination_date = '14-JUL-14 00:00:00'
where login_id = '4399'; 

--Dimensional

update cc_d_agent
set termination_date = '14-JUL-14 00:00:00'
where login_id = '4399'; 

--Linda McNutt
-- Staging

update cc_s_agent
set termination_date = '30-JUN-14 00:00:00'
where login_id = '74019'; 

-- Dimensional

update cc_d_agent
set termination_date = '30-JUN-14 00:00:00'
where login_id = '74019'; 


-- Marcellus Johnson
-- Staging

update cc_s_agent
set termination_date = '22-DEC-14 00:00:00'
where login_id = '73880';

update cc_s_agent
set hire_date = '22-DEC-14 00:00:00'
where login_id = '74880';

-- Dimensional

update cc_d_agent
set termination_date = '22-DEC-14 00:00:00'
where login_id = '73880'
and d_agent_id = 1540;

update cc_d_agent
set hire_date = '22-DEC-14 00:00:00'
where login_id = '74880'
and d_agent_id in ( 2943, 2963);


-- Pablo Otavalo
-- Staging

update cc_s_agent
set termination_date = '19-NOV-14 00:00:00'
where login_id = '54748';

-- Dimensional

update cc_d_agent
set termination_date = '19-NOV-14 00:00:00'
where login_id = '54748';

-- Rosemarie Fernandez
-- Staging

update cc_s_agent
set termination_date = '05-JAN-15 00:00:00'
where login_id = '54935';

-- Dimensional

update cc_d_agent
set termination_date = '05-JAN-15 00:00:00'
where login_id = '54935';

commit