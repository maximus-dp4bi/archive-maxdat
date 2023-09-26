
update corp_etl_clnt_outreach
set outreach_status_dt = complete_dt
    ,outreach_status = 'Outreach Successful'    
where outreach_id  in (73152437, 73193764, 75159571, 75162047, 75162048, 75162744, 75162746, 75167009);

commit;