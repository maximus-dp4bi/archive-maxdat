CREATE OR REPLACE VIEW EMRS_D_SUB_PROGRAM_SV
AS
 SELECT st.value AS SUBPROGRAM_CODE,
    st.report_label AS SUBPROGRAM_NAME,
    st.scope AS PARENT_PROGRAM_NAME,
    COALESCE(st.effective_start_date,st.create_ts) AS START_DATE,
    st.effective_end_date AS END_DATE,    
    st.plan_type AS PLAN_SERVICE_TYPE
  FROM enum_subprogram_type st
  UNION
  SELECT 'UD' AS SUBPROGRAM_CODE,
    'Not Defined' AS SUBPROGRAM_NAME,
    'MEDICAID' AS PARENT_PROGRAM_NAME,
    TO_DATE('01/01/1900','MM/DD/YYYY') AS START_DATE,
    NULL AS END_DATE,    
    NULL AS PLAN_SERVICE_TYPE
  FROM DUAL;   
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SUB_PROGRAM_SV TO MAXDAT_REPORTS;  