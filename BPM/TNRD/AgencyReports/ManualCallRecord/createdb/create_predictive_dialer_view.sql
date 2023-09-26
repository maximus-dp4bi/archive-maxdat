
CREATE OR REPLACE VIEW d_predictive_dialer_sv
AS
SELECT job_id
      ,row_num
      ,cpp_id
      ,cccr_id
      ,pd_request_id
      ,applicant_name
      ,phone1 phone
      ,auth_rep_name
      ,auth_rep_gender      
      ,ext_call1_phone ext_call_phone
      ,ext_call1_date ext_call_date
      ,ext_call1_disp_id ext_call_disp_id
      ,COALESCE(ll.out_var,'Other') ext_call_disp_cd
      ,COALESCE(ll.out_var,'Other') ext_call_disposition
      ,ext_call1_agent ext_call_agent
      ,dr.create_ts
      ,cr.call_type_cd
      ,cr.caller_phone member_phone
      ,cr.caller_first_name||' '||cr.caller_last_name member_name
      ,cr.call_start_ts
      ,cr.call_end_ts
      ,cr.call_type
FROM etl_l_dialer_response_stg dr
 JOIN call_record_stg cr ON dr.cccr_id = cr.call_record_id
 LEFT JOIN corp_etl_list_lkup ll ON dr.ext_call1_disp_id = ll.value AND ll.name = 'PREDICTIVE_DIALER' AND ll.list_type = 'PD_DISPOSITION'
WHERE ext_call1_disp_id IS NOT NULL
UNION ALL
SELECT job_id
      ,row_num
      ,cpp_id
      ,cccr_id
      ,pd_request_id
      ,applicant_name
      ,phone2
      ,auth_rep_name
      ,auth_rep_gender    
      ,ext_call2_phone
      ,ext_call2_date
      ,ext_call2_disp_id
      ,COALESCE(ll.out_var,'Other') ext_call_disp_cd
      ,COALESCE(ll.out_var,'Other') ext_call_disposition
      ,ext_call2_agent      
      ,dr.create_ts
      ,cr.call_type_cd
      ,cr.caller_phone member_phone
      ,cr.caller_first_name||' '||cr.caller_last_name member_name
      ,cr.call_start_ts
      ,cr.call_end_ts
      ,cr.call_type
FROM etl_l_dialer_response_stg dr
  JOIN call_record_stg cr ON dr.cccr_id = cr.call_record_id
  LEFT JOIN corp_etl_list_lkup ll ON dr.ext_call2_disp_id = ll.value AND ll.name = 'PREDICTIVE_DIALER' AND ll.list_type = 'PD_DISPOSITION'
WHERE ext_call2_disp_id IS NOT NULL
UNION ALL
SELECT job_id
      ,row_num
      ,cpp_id
      ,cccr_id
      ,pd_request_id
      ,applicant_name
      ,phone3
      ,auth_rep_name
      ,auth_rep_gender      
      ,ext_call3_phone
      ,ext_call3_date
      ,ext_call3_disp_id
      ,COALESCE(ll.out_var,'Other') ext_call_disp_cd
      ,COALESCE(ll.out_var,'Other') ext_call_disposition
      ,ext_call3_agent
      ,dr.create_ts
      ,cr.call_type_cd
      ,cr.caller_phone member_phone
      ,cr.caller_first_name||' '||cr.caller_last_name member_name
      ,cr.call_start_ts
      ,cr.call_end_ts
      ,cr.call_type
FROM etl_l_dialer_response_stg dr
  JOIN call_record_stg cr ON dr.cccr_id = cr.call_record_id
  LEFT JOIN corp_etl_list_lkup ll ON dr.ext_call3_disp_id = ll.value AND ll.name = 'PREDICTIVE_DIALER' AND ll.list_type = 'PD_DISPOSITION'
WHERE ext_call3_disp_id IS NOT NULL
UNION ALL
SELECT job_id
      ,row_num
      ,cpp_id
      ,cccr_id
      ,pd_request_id
      ,applicant_name
      ,phone4
      ,auth_rep_name
      ,auth_rep_gender     
      ,ext_call4_phone
      ,ext_call4_date
      ,ext_call4_disp_id
      ,COALESCE(ll.out_var,'Other') ext_call_disp_cd
      ,COALESCE(ll.out_var,'Other') ext_call_disposition
      ,ext_call4_agent
      ,dr.create_ts
      ,cr.call_type_cd
      ,cr.caller_phone member_phone
      ,cr.caller_first_name||' '||cr.caller_last_name member_name
      ,cr.call_start_ts
      ,cr.call_end_ts
      ,cr.call_type
FROM etl_l_dialer_response_stg dr
  JOIN call_record_stg cr ON dr.cccr_id = cr.call_record_id
  LEFT JOIN corp_etl_list_lkup ll ON dr.ext_call4_disp_id = ll.value AND ll.name = 'PREDICTIVE_DIALER' AND ll.list_type = 'PD_DISPOSITION'
WHERE ext_call4_disp_id IS NOT NULL
UNION ALL
SELECT job_id
      ,row_num
      ,cpp_id
      ,cccr_id
      ,pd_request_id
      ,applicant_name
      ,phone5
      ,auth_rep_name
      ,auth_rep_gender      
      ,ext_call5_phone
      ,ext_call5_date
      ,ext_call5_disp_id
      ,COALESCE(ll.out_var,'Other') ext_call_disp_cd
      ,COALESCE(ll.out_var,'Other') ext_call_disposition
      ,ext_call5_agent
      ,dr.create_ts
      ,cr.call_type_cd
      ,cr.caller_phone member_phone
      ,cr.caller_first_name||' '||cr.caller_last_name member_name
      ,cr.call_start_ts
      ,cr.call_end_ts
      ,cr.call_type
FROM etl_l_dialer_response_stg dr
  JOIN call_record_stg cr ON dr.cccr_id = cr.call_record_id
  LEFT JOIN corp_etl_list_lkup ll ON dr.ext_call5_disp_id = ll.value AND ll.name = 'PREDICTIVE_DIALER' AND ll.list_type = 'PD_DISPOSITION'
WHERE ext_call5_disp_id IS NOT NULL
UNION ALL
SELECT job_id
      ,row_num
      ,cpp_id
      ,cccr_id
      ,pd_request_id
      ,applicant_name
      ,phone6
      ,auth_rep_name
      ,auth_rep_gender      
      ,ext_call6_phone
      ,ext_call6_date
      ,ext_call6_disp_id
      ,COALESCE(ll.out_var,'Other') ext_call_disp_cd
      ,COALESCE(ll.out_var,'Other') ext_call_disposition
      ,ext_call6_agent
      ,dr.create_ts
      ,cr.call_type_cd
      ,cr.caller_phone member_phone
      ,cr.caller_first_name||' '||cr.caller_last_name member_name
      ,cr.call_start_ts
      ,cr.call_end_ts
      ,cr.call_type
FROM etl_l_dialer_response_stg dr
  JOIN call_record_stg cr ON dr.cccr_id = cr.call_record_id
  LEFT JOIN corp_etl_list_lkup ll ON dr.ext_call6_disp_id = ll.value AND ll.name = 'PREDICTIVE_DIALER' AND ll.list_type = 'PD_DISPOSITION'
WHERE ext_call6_disp_id IS NOT NULL;

GRANT SELECT ON d_predictive_dialer_sv TO MAXDAT_READ_ONLY;
