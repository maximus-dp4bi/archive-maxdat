DROP VIEW WR_DONOT_CALL_SV;
CREATE OR REPLACE VIEW WR_DONOT_CALL_SV
AS
SELECT cc.cscl_clnt_client_id client_id
      ,CASE WHEN cs.case_generic_field6_txt IN('1','true') AND cl.do_not_call_ind = 1 THEN 0 ELSE cl.do_not_call_ind END donot_call_indicator      
      ,cc.cscl_adlk_id aid_category_cd
      ,CASE WHEN cc.cscl_adlk_id = 'MA-HMP' THEN 'ME01_BP' ELSE NULL END segment_type_cd
      ,cc.cscl_status_end_date segment_end_date
      ,TRUNC(sysdate) report_date
      ,CASE WHEN cs.case_generic_field6_txt IN('1','true') THEN 1 ELSE 0 END case_donot_call_indicator
      ,cs.case_id
FROM case_client cc
  JOIN client cl ON cc.cscl_clnt_client_id = cl.clnt_client_id
  JOIN eb.cases cs ON cc.cscl_case_id = cs.case_id
WHERE cc.cscl_status_end_date IS NULL
AND (cl.do_not_call_ind = 1 OR 
 cs.case_generic_field6_txt = '1'
OR cs.case_generic_field6_txt = 'true');

GRANT SELECT ON MAXDAT_SUPPORT.WR_DONOT_CALL_SV TO MAXDAT_REPORTS;
GRANT SELECT ON MAXDAT_SUPPORT.WR_DONOT_CALL_SV TO MAXDATSUPPORT_READ_ONLY;