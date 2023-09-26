CREATE OR REPLACE VIEW D_PA_VISIT_STATUS_SV
AS
SELECT stat.value status_cd
  ,stat.report_label visit_status
FROM  enum_assessment_status stat;
    
GRANT SELECT ON D_PA_VISIT_STATUS_SV TO MAXDAT_REPORTS; 
