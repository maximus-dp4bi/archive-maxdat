CREATE OR REPLACE VIEW EMRS_F_SLCT_TRANS_CNT_SV
 AS
SELECT /*+ parallel(10) */ d.D_DATE AS RECORD_DATE,
  sp.PROGRAM_CODE,
  sp.SUBPROGRAM_CODE,
  sp.COUNTY_CODE,
  sp.PLAN_ID,
  f.PLAN_TYPE,
  f.PLAN_ID_EXT,
  f.PRIOR_PLAN_ID,
  f.PRIOR_PLAN_ID_EXT,
  COALESCE(f.STATUS_CD,'acceptedByState') status_cd,
  COALESCE(f.TRANSACTION_TYPE_CD,'NewEnrollment') transaction_type_cd,
  COALESCE(f.selection_source_cd,'F') selection_source_cd,
  COALESCE(f.choice_reason_cd,'U') choice_reason_cd,
  COALESCE(f.client_aid_category_cd,'U') client_aid_category_cd,
  COALESCE(f.disenroll_reason_cd_1,'U') disenroll_reason_cd_1,
  COUNT(f.selection_txn_id) AS transaction_count,
  COALESCE(f.record_name,'0') record_name,
  coalesce(f.elig_status_cd ,'U') as elig_status_cd,
  SUM(ffs_transaction) ffs_transaction_count
FROM (select d_date from MAXDAT_SUPPORT.D_DATES dd where dd.D_DATE BETWEEN ADD_MONTHS(TRUNC(sysdate, 'mm'), -2) AND TRUNC(sysdate)) d
join (select program_code, subprogram_code, county_code, plan_id, plan_type_cd from maxdat_support.emrs_d_plan_subprogram_sv
      union all
      select program_code, subprogram_code, county_code, plan_id, plan_type_cd from maxdat_support.emrs_d_den_plan_subprogram_sv) sp on 1=1
left JOIN
  (SELECT coalesce((SELECT MIN(TRUNC(sh.create_ts))
      FROM selection_txn_status_history sh
      WHERE sh.selection_txn_id = s.selection_txn_id AND sh.status_cd = (case when ca.subprogram_codes = 'ICO' then 'uploadedToIFC' else 'uploadedToState' end)
      ),s.create_ts) record_date,
    COALESCE(s.program_type_cd, '0') AS program_type_cd,
    COALESCE(case when s.plan_type_cd = 'DENTAL' then 'DEN'
                  when ca.subprogram_codes = 'MC' then 'MED' 
                  else ca.subprogram_codes end,'0') AS subprogram_code, 
    s.county county_code,
    COALESCE(s.plan_id, 0) AS plan_id,
    s.plan_type_cd plan_type,
    s.plan_id_ext ,
   COALESCE(s.prior_plan_id, 0) AS prior_plan_id,
    s.prior_plan_id_ext ,
    s.status_cd ,
    s.transaction_type_cd ,
    CASE WHEN (cr.caller_type_cd = 'FEC' OR (s.ref_source_id IS NOT NULL AND s.ref_source_type = 'OFFICE')) THEN 'F' ELSE s.selection_source_cd END selection_source_cd,
    s.choice_reason_cd ,
    COALESCE(ca.value, COALESCE(s.client_aid_category_cd, '0')) AS client_aid_category_cd ,
    COALESCE(s.disenroll_reason_cd_1, disenroll_reason_cd_2,'0') AS disenroll_reason_cd_1,
    s.disenroll_reason_cd_2 ,
    s.selection_txn_id  ,
    s.status_date, 
    s.created_by record_name,     
    elig.elig_status_cd,
    CASE WHEN pl.plan_code = 'FFS' AND s.transaction_type_cd IN('NewEnrollment','Transfer') THEN  COALESCE(s.prior_plan_id, 0) ELSE COALESCE(s.plan_id, 0) END derived_plan_id,
    CASE WHEN pl.plan_code = 'FFS' AND s.transaction_type_cd IN('NewEnrollment','Transfer') THEN 1 ELSE 0 END ffs_transaction
  FROM eb.selection_txn s
  INNER JOIN client cl ON s.client_id = cl.clnt_client_id
  LEFT JOIN client_supplementary_info csi on csi.client_id = s.client_id and csi.program_cd = s.program_type_cd
  LEFT JOIN case_client cscl on cscl.cscl_id = csi.case_client_id
  LEFT JOIN enum_aid_category ca ON  cscl.cscl_adlk_id = ca.value
  LEFT JOIN contract con ON s.contract_id = con.contract_id
  LEFT JOIN event e ON (e.ref_id = s.selection_txn_id AND e.ref_type = 'SELECTION_TXN' AND e.event_type_cd IN('PHONE_ENROLLMENT','CHOICE_ENROLLMENT'))
  LEFT JOIN call_record cr ON e.call_record_id = cr.call_record_id
  LEFT JOIN eb.plans pl ON s.plan_id = pl.plan_id
  left join client_elig_status elig on (elig.client_id = s.client_id and elig.end_date is null and elig.plan_type_cd = 'MEDICAL' and elig.program_cd = 'MEDICAID')
  WHERE (s.create_ts >= add_months(TRUNC(sysdate,'mm'),-2) OR s.status_date >= add_months(TRUNC(sysdate,'mm'),-2) )
 -- and s.plan_type_cd = 'DENTAL'
 -- and s.selection_txn_id = 24586205
 ) f ON (d.D_DATE BETWEEN f.record_date AND COALESCE(f.record_date, TO_DATE('12-Dec-2050', 'dd-Mon-yyyy'))
          --AND d.D_DATE = f.record_date
          and f.subprogram_code = sp.subprogram_code
        --  and f.plan_id = sp.plan_id
          and f.plan_type = sp.plan_type_cd
          and f.derived_plan_id = sp.plan_id
          and f.county_code = sp.county_code)
GROUP BY d.D_DATE ,
  sp.PROGRAM_CODE,
  sp.SUBPROGRAM_CODE,
  sp.COUNTY_CODE,
  sp.PLAN_ID,
  f.PLAN_TYPE,
  f.PLAN_ID_EXT,
  f.PRIOR_PLAN_ID,
  f.PRIOR_PLAN_ID_EXT,
  f.STATUS_CD,
  f.TRANSACTION_TYPE_CD,
  f.selection_source_cd,
  f.choice_reason_cd,
  f.client_aid_category_cd,
  f.disenroll_reason_cd_1,
  f.record_name, 
  f.elig_status_cd  
  ;
 
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_SLCT_TRANS_CNT_SV TO MAXDAT_REPORTS;    
