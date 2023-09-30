CREATE OR REPLACE VIEW EMRS_F_AA_ASSIGN_SV
AS
SELECT j.job_date RECORD_DATE
       ,j.subprogram_code
       ,j.county_name
       ,j.region_cd
       ,j.group_number       
       ,j.plan_name
       , count(aa.client_id) aa_count
/*       , aa.curr_status_cd
       , aa.job_date
       , aa.CURR_SELECTION_TXN_ID
       , aa.CURR_TRANSACTION_TYPE_CD
       , aa.CURR_CHOICE_REASON_CD
       , aa.CURR_SELECTION_SOURCE_CD
       , aa.CURR_STATUS_DATE
       , aa.acceptedbyifc_date
       , aa.readytoupload_date
       , aa.readytoupload2_date
*/
FROM EMRS_D_AA_JURISDICTION_SV j
  join  MAXDAT_SUPPORT.D_DATES d on 1=1
  left join emrs_d_aa_trans_sv aa on (aa.plan_id = j.plan_id and aa.plan_type_cd = j.plan_type_cd and aa.subprogram_code = j.subprogram_code and aa.curr_county = j.county_code    
       and /*aa.curr_status_cd in ('readyToUpload','readyToUpload2') and*/ j.plan_type_cd = 'MEDICAL' 
       and d.D_DATE BETWEEN ADD_MONTHS(TRUNC(sysdate, 'mm'), -2) AND TRUNC(sysdate)
       AND d.D_DATE = aa.job_date
)
group by d.d_date, 
      j.subprogram_code
       ,j.county_name
       ,j.region_cd
       ,j.group_number        
       ,j.plan_name


;

  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_AA_ASSIGN_SV TO MAXDAT_REPORTS;
