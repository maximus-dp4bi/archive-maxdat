delete from cc_f_agent_activity_by_date
where f_agent_activity_by_date_id in (select f_agent_activity_by_date_id from cc_f_agent_activity_by_date f, cc_d_dates d, cc_d_agent a
where f.d_date_id=d.d_date_id
and f.d_agent_id=a.d_agent_id
and a.login_id in ('59752', '52410', '45003')
and d.d_date_id=5495
and f.d_program_id=0
and f.d_project_id=0
);

commit;