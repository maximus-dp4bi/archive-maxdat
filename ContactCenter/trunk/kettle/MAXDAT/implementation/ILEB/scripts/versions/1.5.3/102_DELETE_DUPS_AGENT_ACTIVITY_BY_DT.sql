delete from cc_f_agent_activity_by_date where f_agent_activity_by_date_id in(
with dups as (
select * from 
      (select d_date_id, d_site_id, d_group_id, login_id, d_program_id, d_project_id, d_activity_type_id, count (*) as cnt from
           (
            select d.d_date_id, s.d_site_id, g.d_group_id, f2.d_agent_id, a.login_id, f2.d_program_id, f2.d_project_id, t.d_activity_type_id, f2.activity_minutes
            from cc_f_agent_activity_by_date f2
            inner join cc_d_dates d on f2.d_date_id = d.d_date_id
            inner join cc_d_agent a on f2.d_agent_id = a.d_agent_id
            inner join cc_d_site s on f2.d_site_id = s.d_site_id
            inner join cc_d_group g on f2.d_group_id = g.d_group_id
            inner join cc_d_activity_type t on f2.d_activity_type_id = t.d_activity_type_id
            order by d.d_date_id, a.login_id
            )
       group by d_date_id, d_site_id, d_group_id, login_id, d_program_id, d_project_id, d_activity_type_id )
where cnt > 1
order by d_date_id, login_id)
select min(f_agent_activity_by_date_id) from cc_f_agent_activity_by_date b
inner join dups a on a.d_date_id=b.d_date_id
inner join cc_d_agent c on b.d_agent_id = c.d_agent_id
and a.d_site_id =b.d_site_id
and a.d_group_id=b.d_group_id
and a.d_program_id=b.d_program_id
and a.d_project_id=b.d_project_id
and a.d_activity_type_id=b.d_activity_type_id
and a.login_id=c.login_id
group by b.d_date_id,b.d_site_id,b.d_group_id,a.login_id,b.d_program_id,b.d_project_id,b.d_activity_type_id);

commit;