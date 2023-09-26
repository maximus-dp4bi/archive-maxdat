CREATE OR REPLACE VIEW EMRS_D_SUB_PROGRAM_SV
AS
  SELECT pt.value managed_care_program ,
    NULL sub_program_id ,
    st.report_label sub_program_name ,
    st.value sub_program_code ,
    NULL source_record_id ,
    pt.value parent_program_name ,
    COALESCE(st.effective_start_date,st.create_ts) start_date ,
    st.effective_end_date end_date ,
    NULL parent_program_id ,
    st.value plan_service_type
  FROM enum_subprogram_type st
  CROSS JOIN enum_program_type pt
  WHERE pt.effective_end_date IS NULL; 
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_SUB_PROGRAM_SV TO EB_MAXDAT_REPORTS;  