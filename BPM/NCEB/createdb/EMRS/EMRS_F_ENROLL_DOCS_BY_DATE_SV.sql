CREATE OR REPLACE VIEW EMRS_F_ENROLL_DOCS_BY_DATE_SV
AS
SELECT x.document_create_date
 ,x.enrollment_form_count
 ,x.fax_count
 ,x.scan_count
 ,x.de_complete_count
 ,ROUND(CASE WHEN x.de_complete_count = x.enrollment_form_count THEN 1
      WHEN x.de_complete_count = 0 THEN 0 
   ELSE (x.de_complete_count/x.enrollment_form_count) end,4) percent_de_complete 
 ,x.classified_count
 ,x.linked_count
 ,x.released_count
 ,x.auto_linked_count
 ,ROUND(CASE WHEN x.scan_count = 0 THEN 0 
       WHEN x.auto_linked_count = x.scan_count THEN 1
       WHEN x.auto_linked_count = 0 THEN 0 
   ELSE (x.auto_linked_count/x.scan_count) END,4) percent_auto_linked 
FROM (SELECT TRUNC(d.create_ts) document_create_date 
        ,SUM( CASE WHEN INSTR(d.xml_meta_data,'FAX') > 0 THEN 1 ELSE 0 END ) fax_count 
        ,SUM( CASE WHEN INSTR(d.xml_meta_data,'MAIL') > 0 THEN 1 ELSE 0 END ) scan_count
        ,SUM (CASE WHEN d.doc_status_cd = 'DATA_ENTRY_COMPLETE' THEN 1 ELSE 0 END ) de_complete_count
        ,SUM (CASE WHEN d.doc_status_cd = 'CLASSIFIED' THEN 1 ELSE 0 END ) classified_count
        ,SUM (CASE WHEN d.doc_status_cd = 'LINKED' THEN 1 ELSE 0 END ) linked_count
        ,SUM (CASE WHEN d.doc_status_cd = 'RELEASED' THEN 1 ELSE 0 END ) released_count
        ,SUM( CASE WHEN instr(d.xml_meta_data,'MAIL') > 0 THEN l.auto_linked_ind ELSE 0 END ) auto_linked_count
        ,COUNT(1) enrollment_form_count
FROM document d
  JOIN doc_link l ON l.document_id = d.document_id
WHERE d.doc_status_cd <> 'RESCAN_REQUESTED'
--AND d.create_ts >= to_date('01-APR-2020')
AND d.create_ts >= GREATEST(TO_DATE('3/1/2021','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
AND d.doc_type_cd = 'ENROLLMENT'
GROUP BY TRUNC(d.create_ts) ) x;

GRANT SELECT ON EMRS_F_ENROLL_DOCS_BY_DATE_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON EMRS_F_ENROLL_DOCS_BY_DATE_SV TO MAXDAT_REPORTS;