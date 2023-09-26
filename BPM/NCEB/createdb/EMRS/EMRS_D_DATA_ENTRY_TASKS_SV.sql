drop view EMRS_D_DATA_ENTRY_TASKS_SV;
CREATE OR REPLACE VIEW EMRS_D_DATA_ENTRY_TASKS_SV AS
select CASE WHEN DO.xml_meta_data NOT LIKE ('%>FAX<%') THEN 1 ELSE 0 END not_fax_is_1,
  si.step_instance_id, 
  si.process_instance_id, 
  si.case_id,
  si.client_id,
  es.reasons,  
  COALESCE(do.document_id,dt.document_id) document_id,
  COALESCE(do.DCN,dt.dcn) dcn,
  gg.group_name, 
  st.First_name ||' '|| st.last_name Full_Name, 
  si.owner, 
  si.status, 
  sd.name, 
  si.create_ts, 
  COALESCE(do.scan_date,dt.scan_date) scan_date, 
  si.step_due_ts, 
  si.Completed_ts, 
  sysdate run_date,
  CASE WHEN es.subprogram_type LIKE 'TP%' THEN 'TP' ELSE 'SP' END tpsp_elig_indicator
from eb.step_instance si 
left join eb.client_elig_status es on es.client_id = si.client_id and es.end_date is null
join eb.step_definition sd on (sd.step_definition_id = si.step_definition_id) 
join eb.groups gg on gg.group_id = si.group_id
left join eb.staff st on st.staff_id = si.owner
left join eb.document do on do.document_id = si.ref_id
LEFT JOIN (
	SELECT * FROM (SELECT d.dcn,d.scan_date,dl.*,tt.report_label doc_form_type,tt.value, ds.received_date form_submitted_date,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY dl.doc_link_id DESC) rnum FROM doc_link dl
		JOIN document d ON dl.document_id = d.document_id
        JOIN document_set ds ON d.document_set_id = ds.document_set_id
		JOIN enum_document_type t1 ON t1.value = d.doc_form_type
		JOIN enum_doc_code_to_type tt ON t1.value = tt.value
		WHERE tt.value IN ('TP_NS_PRV','TP_NS_MEM','TP_SA_PRV')
			AND link_type_cd = 'INCIDENT_HEADER') dd WHERE rnum = 1	) dt ON  dt.link_ref_id=si.ref_id  AND si.ref_type IN('incident_header','INCIDENT_HEADER')
       
where gg.Group_name in ('Call Center', 'Data Entry Unit','EB Clinical Review Unit')
and si.create_ts >= GREATEST(TO_DATE('3/1/2021','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
;

GRANT SELECT ON EMRS_D_DATA_ENTRY_TASKS_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON EMRS_D_DATA_ENTRY_TASKS_SV TO MAXDAT_REPORTS;