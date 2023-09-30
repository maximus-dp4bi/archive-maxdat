alter session set current_schema=cisco_enterprise_cc;

declare

    l_cur_date          DATE;
    l_end_date          DATE;

begin

    l_cur_date  :=  to_date('20200601', 'yyyymmdd');
    l_end_date  :=  to_date('20200722', 'yyyymmdd');
    
    while(l_cur_date <= l_end_date)
    loop
        
        insert into cc_a_ivr_job_ctrl (job_name, job_param_1, job_param_2)
        values('LOAD_IVR_RESP', 'MAXMIACA_RESPONSE_' || to_char(l_cur_date, 'yyyymmdd'), 'csv');
        
        insert into cc_a_ivr_job_ctrl (job_name, job_param_1, job_param_2)
        values('LOAD_IVR_RESP', 'MAXMIAFC_RESPONSE_' || to_char(l_cur_date, 'yyyymmdd'), 'csv');

        insert into cc_a_ivr_job_ctrl (job_name, job_param_1, job_param_2)
        values('LOAD_IVR_RESP', 'MAXMIAPS_RESPONSE_' || to_char(l_cur_date, 'yyyymmdd'), 'csv');
        
        insert into cc_a_ivr_job_ctrl (job_name, job_param_1, job_param_2)
        values('LOAD_IVR_RESP', 'MAXMIBSHD_RESPONSE_' || to_char(l_cur_date, 'yyyymmdd'), 'csv');

        insert into cc_a_ivr_job_ctrl (job_name, job_param_1, job_param_2)
        values('LOAD_IVR_RESP', 'MAXMICSCC_RESPONSE_' || to_char(l_cur_date, 'yyyymmdd'), 'csv');

        insert into cc_a_ivr_job_ctrl (job_name, job_param_1, job_param_2)
        values('LOAD_IVR_RESP', 'MAXMIPSS_RESPONSE_' || to_char(l_cur_date, 'yyyymmdd'), 'csv');
        
        insert into cc_a_ivr_job_ctrl (job_name, job_param_1, job_param_2)
        values('LOAD_IVR_RESP', 'MAXMIWRK_RESPONSE_' || to_char(l_cur_date, 'yyyymmdd'), 'csv');        
                    
        l_cur_date  :=  l_cur_date + 1;
    end loop;

end;
/

commit;

