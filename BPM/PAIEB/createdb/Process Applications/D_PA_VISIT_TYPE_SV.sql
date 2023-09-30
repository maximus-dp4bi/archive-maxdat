CREATE OR REPLACE VIEW D_PA_VISIT_TYPE_SV
AS
SELECT ast.value assessment_type_cd
  ,ast.report_label visit_type
FROM  enum_assessment_type ast;
    
GRANT SELECT ON D_PA_VISIT_TYPE_SV TO MAXDAT_REPORTS; 
