CREATE or replace VIEW EMRS_D_AA_CLIENT_sV
AS
  SELECT 
    s.client_id aa_client_id ,
    s.client_id client_number ,
    CASE WHEN con9.plan_service_type_cd = 'MAINSTREAM' THEN 'MA'  
    WHEN con9.plan_service_type_cd = 'ICO' THEN 'ICO'
    ELSE null END benefit_plan ,   
    s.plan_id,
    s.program_type_cd program_type ,
    TRUNC(s.create_ts) record_date ,
    TO_CHAR(s.create_ts,'HH24MI') record_time ,
    s.created_by record_name ,
    TRUNC(s.update_ts) modified_date ,
    s.updated_by modified_name ,
    TO_CHAR(s.update_ts,'HH24MI') modified_time ,
    csi.case_id,
    csi.case_cin,
    csi.addr_county county_code,
    csi.addr_zip,        
    case when con9.plan_service_type_cd = 'MAINSTREAM' then 'MED' when  con9.plan_service_type_cd = 'ICO' then 'ICO' end subprogram_code,
    trunc(s.create_ts) readyToUpload_date    
    , cc.cscl_adlk_id aid_category
    , cc.cscl_adlk_id aid_code
    , s.start_date
    , case when ce.enroll_status_cd = 'O' then 'Lost Eligibilty'
       when ce.enroll_status_cd = 'A' then 'Timed Out - More than 45 Days Elapsed' 
       when ce.enroll_status_cd = 'A*' then 'Not Eligible for Auto Assignment' 
       else null
       end not_assigned_reason
    , s.choice_reason_cd
    , s.status_cd
    , aa.job_name
    , aa.start_ts job_start_ts
    , aa.end_ts job_end_ts
    , ece.report_label enroll_status_label
    , null AA_ACTION_CD
    , null JOB_STATUS_CD
    , null ENROLL_STATUS_CD
 FROM selection_txn s
   JOIN client_supplementary_info csi on csi.client_id = s.client_id and csi.addr_county <> '00'
   JOIN case_client cc ON cc.cscl_id = csi.case_client_id 
    join client_enroll_status ce on ce.client_id = csi.client_id
    and ce.end_date is null
    join enum_client_enroll_status ece on ece.value = ce.enroll_status_cd
   --JOIN enum_aid_category eac ON eac.value = cc.cscl_adlk_id
   join eb.plans p on p.plan_id = s.plan_id
    join contract con9 on con9.plan_id = s.plan_id and con9.plan_service_type_cd in ('MAINSTREAM','ICO')
    left join (SELECT job_name, start_ts, end_ts, client_id
        FROM(SELECT aa.*,j.end_ts,j.create_ts job_create_ts, 
                    j.job_name, j.start_ts,j.status_cd,
                    ROW_NUMBER() OVER (PARTITION BY aa.client_id ORDER BY aj.aa_job_id DESC) rn
             FROM aa_client aa
              JOIN aa_job aj on aj.aa_job_id = aa.aa_job_id
              JOIN job_run_data j on j.job_run_data_id = aj.job_id  and j.status_cd = 'COMPLETED' )
        WHERE rn = 1)   aa on aa.client_id = csi.client_id     
WHERE  1=1
and s.transaction_type_cd = 'DefaultEnroll'               
AND s.status_cd IN ('readyToUpload','readyToUpload2','pendingAssignment')        
;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_AA_CLIENT_SV TO MAXDAT_REPORTS;
