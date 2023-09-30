CREATE OR REPLACE VIEW D_SCID_CURRENT_SV
AS
  SELECT cr.CALL_RECORD_ID AS CONTACT_RECORD_ID,
  COALESCE(crl.CALL_RECORD_LINK_ID, 0) AS CONTACT_RECORD_LINK_ID,
  COALESCE(crl.CLIENT_ID, 0) AS CLIENT_ID,
  COALESCE(cl.CLNT_CIN, '0') AS CLNT_CIN,
  COALESCE(crl.CASE_ID, 0) AS CASE_ID,
  'MEDICAID' AS program,
  COALESCE(st.report_label, 'Not Defined') AS subprogram,
   CASE WHEN FLOOR(MONTHS_BETWEEN(sysdate, cl.CLNT_DOB)/12) < 21 THEN 'Y' 
        WHEN FLOOR(MONTHS_BETWEEN(sysdate, cl.CLNT_DOB)/12) >= 21 THEN 'N' 
        ELSE NULL END AS CLIENT_UNDER_TWENTYONE,
  cs.case_cin,
  cs.case_head_fname||
    CASE
      WHEN SUBSTR(cs.case_head_mi,1,1) IS NULL
      THEN ' '
      ELSE ' '||SUBSTR(cs.case_head_mi,1,1)||' '
    END ||cs.case_head_lname AS client_full_name,    
  cs.case_head_fname case_first_name,
  cs.case_head_lname case_last_name,
  ad.addr_street_1,
  ad.addr_street_2,
  ad.addr_city,
  ad.addr_state_cd,
  ad.addr_zip,
  ec.report_label addr_county
FROM ATS.CALL_RECORD cr
LEFT JOIN ATS.CALL_RECORD_LINK crl ON (crl.call_record_id = cr.call_record_id)
LEFT JOIN ENUM_SUBPROGRAM_TYPE st ON (cr.call_record_field1 = st.value)
LEFT JOIN ATS.CASES cs ON (crl.case_id = cs.case_id)
LEFT JOIN ATS.ADDRESS ad ON (ad.addr_case_id = cs.case_id 
  AND ad.clnt_client_id IS NULL 
  AND ad.addr_type_cd = 'RS' 
  AND ad.END_NDT > TO_NUMBER(TO_CHAR(sysdate, 'yyyymmddHH24misssss')) )
LEFT JOIN ATS.ENUM_COUNTY ec ON (ad.addr_ctlk_id = ec.value)
LEFT JOIN ATS.CLIENT cl ON (crl.CLIENT_ID = cl.CLNT_CLIENT_ID);
  
  GRANT SELECT ON maxdat_support.D_SCID_CURRENT_SV TO MAXDAT_REPORTS;  