alter session set nls_date_format = 'YYYY-MM-DD HH24:MI:SS';

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
     from cc_f_agent_by_date f, cc_d_dates d, cc_d_agent a, cc_d_project_targets b, cc_d_project c
     where f.d_date_id = d.d_date_id 
     and f.d_agent_id = a.d_agent_id 
     and f.d_project_targets_id = b.d_project_targets_id
     and b.project_id = c.project_id
     and c.project_name = 'MD HBE'
      and d_date >= '2017-10-09 00:00:00'
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

------------------------------------------------------------------------------------------------------------------------------------
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
     from cc_f_agent_activity_by_date f, cc_d_dates d, cc_d_agent a, cc_d_project c
     where f.d_date_id = d.d_date_id 
     and f.d_agent_id = a.d_agent_id 
     --and f.d_project_targets_id = b.d_project_targets_id
     and f.d_project_id = c.project_id
     and c.project_name = 'MD HBE'
      and d_date >= '2017-10-09 00:00:00'
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

-------------------------------------------------------------------------------------------------------------------------------------------------------

merge into cc_f_agent_rtg_grp_interval ccf using ( 
with driver as 
    ( 
      select distinct login_id,d_agent_id,record_eff_dt,record_end_dt 
      from cc_d_agent 
    ) 
    , 
    driver2 as 
    ( 
     select f.f_agent_rtg_grp_interval_id, a.login_id, f.d_agent_id, d.d_date, f.d_date_id 
     from cc_f_agent_rtg_grp_interval f, cc_d_dates d, cc_d_agent a, CC_C_AGENT_RTG_GRP d
     where f.d_date_id = d.d_date_id 
     and f.d_agent_id = a.d_agent_id 
     and f.agent_routing_group_number = d.agent_routing_group_number
     and d.project_name = 'MD HBE'
      and d_date >= '2017-10-09 00:00:00'
    ) 
    , 
    driver3 as 
    ( 
      select d2.f_agent_rtg_grp_interval_id, d2.login_id, d2.d_date_id, d2.d_date, d2.d_agent_id as old_agent_id, d.d_agent_id as new_agent_id 
      from driver2 d2, driver d 
      where d2.login_id = d.login_id 
      and (trunc(d2.d_date) >= trunc(d.record_eff_dt) and trunc(d2.d_date) < trunc(d.record_end_dt)) 
      order by d2.d_date 
    ) 
    select * from driver3 where old_agent_id != new_agent_id 
) driver4 
on (ccf.f_agent_rtg_grp_interval_id = driver4.f_agent_rtg_grp_interval_id )
when matched then 
update set ccf.d_agent_id = driver4.new_agent_id;

---------------------------------------------------------------------------------------------------------------------------------

merge into cc_f_acd_agent_interval ccf using ( 
with driver as 
    ( 
      select distinct login_id,d_agent_id,record_eff_dt,record_end_dt 
      from cc_d_agent 
    ) 
    , 
    driver2 as 
    ( 
     select f.F_CC_ACD_AGENT_INTRVL_ID, a.login_id, f.d_agent_id, d.d_date, f.d_date_id 
     from cc_f_acd_agent_interval f, cc_d_dates d, cc_d_agent a, cc_d_project c
     where f.d_date_id = d.d_date_id 
     and f.d_agent_id = a.d_agent_id 
     --and f.d_project_targets_id = b.d_project_targets_id
     and f.d_project_id = c.project_id
     and c.project_name = 'MD HBE'
      and d_date >= '2017-10-09 00:00:00'
    ) 
    , 
    driver3 as 
    ( 
      select d2.F_CC_ACD_AGENT_INTRVL_ID, d2.login_id, d2.d_date_id, d2.d_date, d2.d_agent_id as old_agent_id, d.d_agent_id as new_agent_id 
      from driver2 d2, driver d 
      where d2.login_id = d.login_id 
      and (trunc(d2.d_date) >= trunc(d.record_eff_dt) and trunc(d2.d_date) < trunc(d.record_end_dt)) 
      order by d2.d_date 
    ) 
    select * from driver3 where old_agent_id != new_agent_id 
) driver4 
on (ccf.F_CC_ACD_AGENT_INTRVL_ID = driver4.F_CC_ACD_AGENT_INTRVL_ID )
when matched then 
update set ccf.d_agent_id = driver4.new_agent_id;

---------------------------------------------------------------------------------------------

merge into cc_f_call ccf using ( 
with driver as 
    ( 
      select distinct login_id,d_agent_id,record_eff_dt,record_end_dt 
      from cc_d_agent 
    ) 
    , 
    driver2 as 
    ( 
     select f.F_CALL_ID, a.login_id, f.d_agent_id, d.d_date, f.d_date_id 
     from cc_f_call f, cc_d_dates d, cc_d_agent a, cc_d_project c, cc_c_contact_queue d
     where f.d_date_id = d.d_date_id 
     and f.d_agent_id = a.d_agent_id 
     and f.queue_number = d.queue_number
     and d.project_name = c.project_name
     and c.project_name = 'MD HBE'
      and d_date >= '2017-10-09 00:00:00'
    ) 
    , 
    driver3 as 
    ( 
      select d2.F_CALL_ID, d2.login_id, d2.d_date_id, d2.d_date, d2.d_agent_id as old_agent_id, d.d_agent_id as new_agent_id 
      from driver2 d2, driver d 
      where d2.login_id = d.login_id 
      and (trunc(d2.d_date) >= trunc(d.record_eff_dt) and trunc(d2.d_date) < trunc(d.record_end_dt)) 
      order by d2.d_date 
    ) 
    select * from driver3 where old_agent_id != new_agent_id 
) driver4 
on (ccf.F_CALL_ID = driver4.F_CALL_ID )
when matched then 
update set ccf.d_agent_id = driver4.new_agent_id;

-------------------------------------------------------------------------------------------------
