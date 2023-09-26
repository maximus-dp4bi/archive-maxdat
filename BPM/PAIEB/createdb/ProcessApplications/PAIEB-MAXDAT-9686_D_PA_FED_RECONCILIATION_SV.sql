
CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_PA_FED_RECONCILIATION_SV
AS
SELECT *
FROM (
SELECT ahe.APPLICATION_ID,
       apdoc.document_sub_type,
       ahe.lcd_level_care,
       transaction_type,
       fed_algorithm_result, 
	   d.doc_status_cd,
	   appId.first_name,
       appId.last_name,
	   appId.harmony_id,
       appId.client_id,
       appId.case_id,
	   apdoc.dcn,
	   apdoc.document_set_id,
       apdoc.document_id,
       APPID.CREATE_TS
FROM app_doc_data apdoc,
     document d,
     app_header_ext ahe,
     ( SELECT doclnk.client_id,
              doclnk.case_id,
	          docflex.document_set_id,
			  fedhdr.transaction_type,
			  fedhdr.fed_algorithm_result,
              fedhdr.first_name,
              fedhdr.last_name,
			  fedhdr.harmony_id,
              fedhdr.mci_num,
			  fedhdr.ssn,
              DECODE( NVL((SELECT COUNT(client_id) 
                           FROM app_individual 
                           WHERE client_id = doclnk.client_id),0), 
                      1, (SELECT application_id 
                          FROM app_individual 
                          WHERE client_id = doclnk.client_id),
                      0, 1,
                      (SELECT MAX(hdr.application_id)
                       FROM app_individual ai,
                            app_header_ext hdr
                       WHERE client_id = doclnk.client_id
                       AND hdr.application_id = ai.application_id
                       AND TRUNC(hdr.lcd_supervisor_sign_date)= TRUNC(fedhdr.fed_complete_date))) ret_app_id,
                       FEDHDR.CREATE_TS
       FROM etl_l_fed_assmt_header fedhdr,
            doc_flex_field docflex,
            doc_link doclnk
       WHERE name = 'ETL_FED_ASSMT_HEADER_ID' 
       AND TO_DATE(FEDHDR.CREATE_TS) > '31-MAR-2019'
       AND docflex.value = fedhdr.etl_fed_assmt_header_id
       AND doclnk.document_id(+) = docflex.document_id ) appId
WHERE apdoc.document_set_id = appId.document_set_id
AND d.document_set_id = appId.document_set_id
AND ahe.application_id(+) = NVL(appId.ret_app_id, '1')
) x
WHERE lcd_level_care IS NULL
ORDER BY 1;




GRANT SELECT ON MAXDAT_SUPPORT.D_PA_FED_RECONCILIATION_SV TO MAXDATSUPPORT_READ_ONLY;

GRANT SELECT ON MAXDAT_SUPPORT.D_PA_FED_RECONCILIATION_SV TO MAXDAT_REPORTS;