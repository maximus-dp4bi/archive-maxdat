CREATE OR REPLACE VIEW EMRS_D_ENROLLMENT_STATUS_SV
AS
  SELECT 
    es.value AS ENROLLMENT_STATUS_CODE ,
    es.description AS ENROLLMENT_STATUS_DESC,
    es.is_mandatory_unassign_ind AS IS_MANDATORY_UNASSIGN_IND ,
    es.is_aa_pce_ind AS IS_AA_PCE_IND
  FROM enum_client_enroll_status es;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLLMENT_STATUS_SV TO MAXDAT_REPORTS;