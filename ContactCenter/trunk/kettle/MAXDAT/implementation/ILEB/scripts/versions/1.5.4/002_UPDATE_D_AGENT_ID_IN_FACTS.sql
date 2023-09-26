merge into cc_f_agent_by_date ccf using ( 
    with driver as 
    ( 
      select distinct login_id,d_agent_id,record_eff_dt,record_end_dt 
      from cc_d_agent 
    ) 
    , 
    driver2 as 
    ( 
     select f.f_agent_by_date_id, a.login_id, f.d_agent_id, d.d_date, f.d_date_id 
     from cc_f_agent_by_date f, cc_d_dates d, cc_d_agent a 
     where f.d_date_id = d.d_date_id 
     and f.d_agent_id = a.d_agent_id 
    ) 
    , 
    driver3 as 
    ( 
      select d2.f_agent_by_date_id, d2.login_id, d2.d_date_id, d2.d_date, d2.d_agent_id as old_agent_id, d.d_agent_id as new_agent_id 
      from driver2 d2, driver d 
      where d2.login_id = d.login_id 
      and (trunc(d2.d_date) >= trunc(d.record_eff_dt) and trunc(d2.d_date) < trunc(d.record_end_dt)) 
      order by d2.d_date 
    ) 
    select * from driver3 where old_agent_id != new_agent_id 
) driver4 
on (ccf.f_agent_by_date_id = driver4.f_agent_by_date_id )
when matched then 
update set ccf.d_agent_id = driver4.new_agent_id;

commit;



merge into cc_f_agent_activity_by_date ccf using ( 
    with driver as 
    ( 
      select distinct login_id,d_agent_id,record_eff_dt,record_end_dt 
      from cc_d_agent 
    ) 
    , 
    driver2 as 
    ( 
     select f.f_agent_activity_by_date_id, a.login_id, f.d_agent_id, d.d_date, f.d_date_id 
     from cc_f_agent_activity_by_date f, cc_d_dates d, cc_d_agent a 
     where f.d_date_id = d.d_date_id 
     and f.d_agent_id = a.d_agent_id 
    ) 
    , 
    driver3 as 
    ( 
      select d2.f_agent_activity_by_date_id, d2.login_id, d2.d_date_id, d2.d_date, d2.d_agent_id as old_agent_id, d.d_agent_id as new_agent_id 
      from driver2 d2, driver d 
      where d2.login_id = d.login_id 
      and (trunc(d2.d_date) >= trunc(d.record_eff_dt) and trunc(d2.d_date) < trunc(d.record_end_dt)) 
      order by d2.d_date 
    ) 
    select * from driver3 where old_agent_id != new_agent_id 
) driver4 
on (ccf.f_agent_activity_by_date_id = driver4.f_agent_activity_by_date_id )
when matched then 
update set ccf.d_agent_id = driver4.new_agent_id;

commit;