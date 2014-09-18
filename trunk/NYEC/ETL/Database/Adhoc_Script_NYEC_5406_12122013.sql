--alter table process_app_Stg modify state_case_iden varchar2(30);

--alter table nyec_etl_process_app modify state_case_iden varchar2(30);

update process_app_Stg 
set app_priority_ind = 1
    ,app_extract_complete_dt = NULL
where app_id in (305302,320915,317706,362579,381923,525748,316512,392235,613327);

update nyec_etl_process_app
set stage_done_date = null
where app_id in (305302,320915,317706,362579,381923,525748,316512,392235,613327)
and stage_done_date is not null;

commit;
