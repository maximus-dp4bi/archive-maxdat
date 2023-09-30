CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_BEFORE_AUTOASSIGN_SV
AS
SELECT ac.plan_id
       ,i.addr_county county_code
       ,ce.client_id
       ,ce.plan_type_cd
       ,eac.subprogram_codes subprogram_code
       ,aj.record_date
       , i.case_cin
       , i.case_id
       , i.client_cin
       , ac.aa_action_cd
       , i.addr_zip
       , aj.job_status_cd
FROM client_enroll_status ce
  JOIN aa_client ac ON ce.client_id = ac.client_id
  JOIN client_supplementary_info i ON ac.client_id = i.client_id
  JOIN case_client cc ON cc.cscl_id = i.case_client_id
  JOIN enum_aid_category eac ON eac.value = cc.cscl_adlk_id
  JOIN (SELECT *
        FROM (SELECT TRUNC(jr.end_ts) record_date, aa_job_id, status_cd job_status_cd, ROW_NUMBER() OVER (ORDER BY aa_job_id DESC) rn
              FROM aa_job aj
                JOIN job_run_data jr ON aj.job_id = jr.job_run_data_id
              --WHERE jr.status_cd = 'COMPLETED' --should look at job status?
              )
        WHERE rn =1 ) aj ON ac.aa_job_id = aj.aa_job_id
WHERE ce.enroll_status_cd = 'AAR'
--AND ce.end_date IS NULL
 AND (ce.end_date IS NULL OR TRUNC(ce.end_date) = record_date)
;

 GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_BEFORE_AUTOASSIGN_SV TO MAXDAT_REPORTS;
