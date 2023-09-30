CREATE OR REPLACE VIEW EMRS_D_SUB_PROGRAM_SV
AS
 SELECT pt.value managed_care_program ,   
    st.report_label subprogram_name ,
    st.value subprogram_code ,
    NULL source_record_id, 
    pt.value parent_program_name ,
    COALESCE(st.effective_start_date,st.create_ts) start_date ,
    st.effective_end_date end_date ,    
    NULL plan_service_type
  FROM enum_subprogram_type st
  CROSS JOIN enum_program_type pt
  WHERE pt.effective_end_date IS NULL
  UNION
  SELECT 'MEDICAID' managed_care_program ,   
    'Not Defined' subprogram_name ,
    '0' subprogram_code ,
    NULL source_record_id, 
    'MEDICAID' parent_program_name ,
    TO_DATE('01/01/1900','MM/DD/YYYY') start_date ,
    NULL end_date ,    
    NULL plan_service_type
  FROM DUAL; 
  
  
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SUB_PROGRAM_SV TO MAXDAT_REPORTS;  