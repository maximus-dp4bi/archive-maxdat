CREATE OR REPLACE VIEW F_MATERIALS_COUNT_SV
AS
SELECT d.material_cd material_code 
      ,e.report_label material_desc
      ,TRUNC(r.sent_on) sent_on
      ,count(1) count_materials      
FROM material_request m
  JOIN letter_request r ON r.material_request_id = m.material_request_id
  JOIN material_request_details d ON d.material_request_id = m.material_request_id
  JOIN enum_material e ON e.value = d.material_cd
WHERE m.created_by <> '-999'
AND r.status_cd in ('SENT','MAIL')
GROUP BY d.material_cd , e.report_label, TRUNC(sent_on);

GRANT SELECT ON MAXDAT_SUPPORT.F_MATERIALS_COUNT_SV TO MAXDAT_REPORTS;