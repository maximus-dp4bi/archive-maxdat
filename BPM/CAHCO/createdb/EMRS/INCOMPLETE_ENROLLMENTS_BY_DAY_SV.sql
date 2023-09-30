
CREATE OR REPLACE VIEW INCOMPLETE_ENROLLMENTS_BY_DAY_SV
AS 
SELECT d_date
      ,st.plan_id
      ,st.plan_name
      ,st.county_code      
      ,CASE WHEN st.plan_type = 'M' THEN 'M' ELSE 'D' END plan_type
      ,st.type
      ,st.county_name
      ,st.plan_change_reason_code
      ,st.transaction_type
      ,COUNT(DISTINCT dcn) dcn_count
FROM bpm_d_dates dd
  LEFT JOIN (SELECT COALESCE(st.transaction_date,d.form_incomplete_create_date) transaction_date,d.dcn,st.county_name,st.county_code,p.plan_id,p.plan_name,p.plan_type,
                  CASE WHEN st.enrollment_trans_type_code not in ('1','5') AND (st.change_reason_code IS NULL OR LENGTH(st.change_reason_code)=0) 
                      THEN 'F10' ELSE st.change_reason_code END plan_change_reason_code,
                   CASE WHEN st.enrollment_trans_type_code = '6' THEN 'FFS Choice' ELSE tt.enrollment_trans_type END transaction_type,
                   CASE WHEN st.enrollment_id IS NULL THEN 'Incomplete' ELSE 'Processed' END  type                  
             FROM hco_d_form d
              LEFT JOIN (SELECT *
                         FROM(SELECT st.enrollment_trans_type_code,st.change_reason_code,
                                    st.dcn, st.transaction_date, st.enrollment_id, st.disregard_trans_ind,
                                    ct.county_code,ct.county_name,
                                    ROW_NUMBER() OVER (PARTITION BY st.enrollment_id ORDER BY st.date_of_validity_end DESC,DECODE(disregard_trans_ind,'N',1,2),st.enrollment_id) rn
                              FROM emrs_f_enrollment st 
                                LEFT OUTER join emrs_d_address ad on st.client_number = ad.client_number AND addr_type_cd = 'ML'
                                LEFT JOIN emrs_d_county ct ON ad.residence_addr_county = ct.county_code
                              WHERE enrollment_trans_type_code in ('1','2','3','5','6','8')                
                              AND st.record_name NOT IN ('errorusr', 'recon', 'newelig', 'newelg', 'errusr', 'errmed', 'rcnfix')                                                       
                              AND (st.non_meds_ind = 'N' OR (st.non_meds_ind = 'Y' AND st.switch_to_meds_ind = 'Y')) )
                         WHERE rn = 1)st    ON st.dcn = d.dcn                  
              LEFT JOIN emrs_d_enroll_trans_type tt ON st.enrollment_trans_type_code = tt.enrollment_trans_type_code
              LEFT JOIN emrs_d_plan p ON TRIM(SUBSTR(d.esr_id,4,3)) = p.plan_id
              
             WHERE  1=1
             AND st.disregard_trans_ind = 'N'  
             AND SUBSTR(UPPER(d.esr_id),1,3) = 'PLN' ) st  ON dd.d_date = TRUNC(st.transaction_date)     
GROUP BY d_date
      ,st.plan_id
      ,st.plan_name
      ,st.county_code      
      ,CASE WHEN st.plan_type = 'M' then 'M' else 'D' end 
      ,st.type
      ,st.county_name
      ,plan_change_reason_code
      ,transaction_type
;

GRANT SELECT ON "INCOMPLETE_ENROLLMENTS_BY_DAY_SV" TO "MAXDAT_READ_ONLY";