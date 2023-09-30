delete from cc_d_agent where d_agent_id in (
    with driver as (
              select login_id , version, count(*) 
              from cc_d_agent
    	      group by login_id, version
              having count(*) > 1
              ),
            driver2 as (
              select distinct d2.login_id, d2.d_agent_id, d2.version
              from cc_d_agent d2
              order by d2.login_id
            ),
            driver3 as (
              select distinct dr2.login_id,dr2.d_agent_id
              from driver dr
              inner join driver2 dr2
              on dr.login_id = dr2.login_id
              and dr.version = dr2.version
              order by dr2.login_id
            ),
            driver4 as (
              select d3a.login_id,max(d3a.d_agent_id) d_agent_id
              from driver3 d3a
              group by d3a.login_id
            )
            ,
            driver5 as (
              select * from driver3 minus select * from driver4
            )
        select distinct d_agent_id from driver5

  );