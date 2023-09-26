CREATE OR REPLACE VIEW EMRS_F_SELECTION_SEGMENT_SV
AS
  SELECT /*+ parallel(20) */ SELECTION_SEGMENT_ID,
    S.END_ND,
    S.PROGRAM_TYPE_CD,
    S.PLAN_TYPE_CD,
    S.START_DATE,
    S.END_DATE,
    S.STATUS_CD,
    S.STATUS_DATE,
    S.PLAN_ID,
    S.PLAN_ID_EXT,
    S.NETWORK_ID,
    S.PROVIDER_ID_EXT,
    S.PROVIDER_FIRST_NAME,
    S.PROVIDER_MIDDLE_NAME,
    S.PROVIDER_LAST_NAME,
    S.CHOICE_REASON_CD,
    S.DISENROLL_REASON_CD_1,
    S.DISENROLL_REASON_CD_2,
    S.CLIENT_AID_CATEGORY_CD,
    S.COUNTY_CD,
    S.ZIPCODE,
    S.CREATED_BY,
    S.CREATE_TS,
    S.UPDATED_BY,
    S.UPDATE_TS,
    S.CONTRACT_ID,
    S.START_ND,
    S.CLIENT_ID,
    COALESCE(case when eca.subprogram_codes = 'MC' then 'MED' else eca.subprogram_codes end,'0') AS subprogram_code
  FROM SELECTION_SEGMENT s
  LEFT JOIN client_supplementary_info csi on csi.client_id = s.client_id and s.program_type_cd = csi.program_cd
  LEFT JOIN case_client cscl on cscl.cscl_id = csi.case_client_id and cscl.cscl_status_end_date is null and s.end_Date is null
  LEFT JOIN enum_aid_category eca ON  cscl.cscl_adlk_id = eca.value
  where s.STATUS_CD = 'OPEN'
  AND s.END_ND >= to_char(sysdate,'yyyymmdd')
  and s.program_type_cd = 'MEDICAID'
  and s.plan_type_cd = 'MEDICAL'
--  and s.client_id = 2097844
  ; 
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_SELECTION_SEGMENT_SV TO MAXDAT_REPORTS;  

