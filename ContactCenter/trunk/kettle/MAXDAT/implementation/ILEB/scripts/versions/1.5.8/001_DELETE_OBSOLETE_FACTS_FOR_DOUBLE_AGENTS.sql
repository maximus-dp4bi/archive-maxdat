alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

-- Angela Walls

delete from cc_f_agent_by_date
where f_agent_by_date_id in
(
select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates d, cc_d_agent a
where f.d_date_id = d.d_date_id
and f.d_agent_id = a.d_agent_id
and d.d_date between '01-DEC-14' and '04-DEC-15'
and a.login_id in ('73126', '73216')
);

delete from cc_f_agent_by_date
where f_agent_by_date_id in
(
select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates d, cc_d_agent a
where f.d_date_id = d.d_date_id
and f.d_agent_id = a.d_agent_id
and d.d_date between '01-DEC-14' and '07-OCT-15'
and a.login_id = '79704'
);

-- Iesha Davis

delete from cc_f_agent_by_date
where f_agent_by_date_id in
(
select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates d, cc_d_agent a
where f.d_date_id = d.d_date_id
and f.d_agent_id = a.d_agent_id
and d.d_date between '01-DEC-14' and '04-DEC-15'
and a.login_id = '4399'
);

-- Linda McNutt

delete from cc_f_agent_by_date
where f_agent_by_date_id in
(
select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates d, cc_d_agent a
where f.d_date_id = d.d_date_id
and f.d_agent_id = a.d_agent_id
and d.d_date between '01-DEC-14' and '04-DEC-15'
and a.login_id = '74019'
);

-- Marcellus Johnson

delete from cc_f_agent_by_date
where f_agent_by_date_id in
(
select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates d, cc_d_agent a
where f.d_date_id = d.d_date_id
and f.d_agent_id = a.d_agent_id
and d.d_date between '23-DEC-14' and '04-DEC-15'
and a.login_id = '73880'
);

delete from cc_f_agent_by_date
where f_agent_by_date_id in
(
select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates d, cc_d_agent a
where f.d_date_id = d.d_date_id
and f.d_agent_id = a.d_agent_id
and d.d_date between '01-DEC-14' and '22-DEC-14'
and a.login_id = '74880'
);

-- Pablo Otavalo

delete from cc_f_agent_by_date
where f_agent_by_date_id in
(
select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates d, cc_d_agent a
where f.d_date_id = d.d_date_id
and f.d_agent_id = a.d_agent_id
and d.d_date between '19-NOV-14' and '04-DEC-15'
and a.login_id = '54748'
);

-- Rosemarie Fernandez

delete from cc_f_agent_by_date
where f_agent_by_date_id in
(
select f_agent_by_date_id from cc_f_agent_by_date f, cc_d_dates d, cc_d_agent a
where f.d_date_id = d.d_date_id
and f.d_agent_id = a.d_agent_id
and d.d_date between '05-JAN-15' and '04-DEC-15'
and a.login_id = '54935'
);

commit;