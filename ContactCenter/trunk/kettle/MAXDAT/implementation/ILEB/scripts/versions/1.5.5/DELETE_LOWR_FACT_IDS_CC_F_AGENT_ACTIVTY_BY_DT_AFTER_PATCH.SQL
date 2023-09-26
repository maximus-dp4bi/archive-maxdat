delete from cc_f_agent_activity_by_date where f_agent_activity_by_date_id in (
    with driver as (
      select d.login_id, f.d_date_id, f.d_activity_type_id, f.activity_minutes
      --,f.d_program_id, f.d_project_id
       ,count(f.f_agent_activity_by_date_id) cnt
      from cc_f_agent_activity_by_date f 
      inner join cc_d_agent d
      on f.d_agent_id = d.d_agent_id  
      group by d.login_id, f.d_date_id, f.d_activity_type_id,f.activity_minutes--, f.d_program_id, f.d_project_id
      having count(f.f_agent_activity_by_date_id) > 1  
    ),
    driver2 as (
      select distinct d2.login_id, f2.d_agent_id, f2.f_agent_activity_by_date_id, f2.d_date_id, f2.d_activity_type_id, f2.activity_minutes
      from cc_f_agent_activity_by_date f2 
      inner join cc_d_agent d2
      on f2.d_agent_id = d2.d_agent_id
      order by d2.login_id
    ),
    driver3 as (
      select distinct dr2.login_id, dr2.d_date_id, dr2.d_activity_type_id, dr2.f_agent_activity_by_date_id, dr2.activity_minutes
      from driver dr
      inner join driver2 dr2
      on dr.login_id = dr2.login_id
      and dr.d_date_id = dr2.d_date_id
      and dr.d_activity_type_id = dr2.d_activity_type_id 
      and dr.activity_minutes = dr2.activity_minutes
      order by dr2.login_id, dr2.d_date_id
    ) ,
    driver4 as (
      select d3a.login_id, d3a.d_date_id, d3a.d_activity_type_id, max(d3a.f_agent_activity_by_date_id) f_agent_activity_by_date_id, d3a.activity_minutes
      from driver3 d3a
      group by d3a.login_id, d3a.d_date_id, d3a.d_activity_type_id, d3a.activity_minutes
      ) 
       ,
    driver5 as (
      select * from driver3 minus select * from driver4
    )
 select distinct f_agent_activity_by_date_id from driver5
);