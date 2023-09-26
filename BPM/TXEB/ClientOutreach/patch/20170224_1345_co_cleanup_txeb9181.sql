update corp_etl_clnt_outreach
set outreach_status_dt = complete_dt
    ,outreach_status = 'Outreach Successful'    
where outreach_id  in (78803474, 78810895) ;

commit;