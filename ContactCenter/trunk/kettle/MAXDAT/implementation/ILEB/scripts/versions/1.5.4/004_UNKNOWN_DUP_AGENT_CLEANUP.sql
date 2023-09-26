delete from cc_f_agent_activity_by_date where f_agent_activity_by_date_id in ( 
    --contains recs with count grouped by d_date_id, d_agent_id, d_activity_type_id > 1 
    with driver as (     
        select d_date_id, d_agent_id, d_activity_type_id, count(f_agent_activity_by_date_id) cnt 
        from cc_f_agent_activity_by_date 
        group by d_date_id, d_agent_id, d_activity_type_id 
        having count(f_agent_activity_by_date_id) > 1 
    ) 
    --contains all the fields that are in driver and f_agent_activity_by_date_id, d_program_id and d_project_id 
    , driver2 as ( 
        select f.f_agent_activity_by_date_id, f.d_date_id, f.d_agent_id, f.d_activity_type_id, f.d_program_id, f.d_project_id 
        from cc_f_agent_activity_by_date f 
        inner join driver d 
        on f.d_date_id = d.d_date_id 
        and f.d_agent_id = d.d_agent_id 
        and f.d_activity_type_id = d.d_activity_type_id 
    ) 
    --contains f_agent_activity_by_date_id from driver2 of the records that have d_program_id and d_project_id as 0     
    select f_agent_activity_by_date_id 
    from driver2 
    where d_program_id = 0 
    and d_project_id = 0   
);


delete from cc_f_agent_by_date where f_agent_by_date_id in ( 
    --contains recs with count grouped by d_date_id, d_agent_id > 1 
    with driver as (     
        select d_date_id, d_agent_id, count(f_agent_by_date_id) cnt 
        from cc_f_agent_by_date 
        group by d_date_id, d_agent_id
        having count(f_agent_by_date_id) > 1 
    ) 
    --contains all the fields that are in driver and f_agent_by_date_id, d_program_id and d_project_id 
    , driver2 as ( 
        select f.f_agent_by_date_id, f.d_date_id, f.d_agent_id, f.d_program_id
        from cc_f_agent_by_date f 
        inner join driver d 
        on f.d_date_id = d.d_date_id 
        and f.d_agent_id = d.d_agent_id 
      ) 
    --contains f_agent_activity_by_date_id from driver2 of the records that have d_program_id and d_project_id as 0     
    select f_agent_by_date_id 
    from driver2 
    where d_program_id = 0 
 
);

commit;