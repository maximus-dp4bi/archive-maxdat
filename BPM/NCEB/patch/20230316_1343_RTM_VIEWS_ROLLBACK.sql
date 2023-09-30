DROP VIEW MAXDAT_SUPPORT.EMRS_D_BH_IDD_TASK_DTL_SV;

CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_BH_IDD_TASK_DTL_SV" ("TASK_ID", "TASK_NAME", "CASE_ID", "CNDS_ID", "CLIENT_ID", "CLIENT_NAME", "CLIENT_DOB", "SERVICE_ASSOCIATED", "STATUS", "CREATE_DATE", "DUE_DATE", "COMPLETED_DATE", "TASK_AGE","DOC_FORM_TYPE","FORM_SUBMITTED_DATE") AS 
select si.step_instance_id TASK_ID -- this is the bhidd report
, sd.display_name TASK_NAME
, si.case_id
, csi.CLIENT_CIN CNDS_ID
, si.client_id
, cl.CLNT_Fname ||' '|| cl.Clnt_lname CLIENT_NAME
, cl.clnt_dob
, case when sd.name like '%ServiceAssociated%' then 'Y' ELSE 'N' end SERVICE_ASSOCIATED
, si.status STATUS
, si.create_ts CREATE_DATE
, si.step_due_ts DUE_DATE
, si.Completed_ts COMPLETED_DATE
, CAST(CASE WHEN si.COMPLETED_TS IS NULL
       THEN SYSDATE - si.create_ts
       ELSE si.COMPLETED_TS - si.CREATE_TS
  END AS INT) TASK_AGE
, dt.doc_form_type 
, dt.form_submitted_date
from eb.step_instance si
  join eb.step_definition sd on (sd.step_definition_id = si.step_definition_id)
  join eb.client cl on cl.clnt_client_id = si.client_id
  JOIN EB.CLIENT_SUPPLEMENTARY_INFO csi ON csi.CLIENT_ID = si.client_id
  LEFT JOIN (SELECT ih.incident_header_id,dd.client_id,dd.doc_form_type,dd.form_submitted_date,dd.update_ts,ROW_NUMBER() OVER (PARTITION BY ih.incident_header_id,dd.client_id ORDER BY dd.doc_link_id) rnum
             FROM incident_header ih
                LEFT JOIN(SELECT dl.*,tt.report_label doc_form_type, ds.received_date form_submitted_date FROM doc_link dl
                           JOIN document d ON dl.document_id = d.document_id
                           JOIN document_set ds ON d.document_set_id = ds.document_set_id
                           JOIN enum_document_type t1 on t1.value = d.doc_form_type
                           JOIN enum_doc_code_to_type tt ON t1.value = tt.value
                          WHERE tt.value like 'TP%') dd ON ih.client_id = dd.client_id AND TRUNC(ih.create_ts) >= TRUNC(dd.update_ts)) dt 
     ON dt.incident_header_id = si.ref_id AND si.ref_type IN('incident_header','INCIDENT_HEADER') AND rnum = 1
where (sd.name like ('BH%') or sd.name like ('%ServiceAssociated%'))
AND si.STATUS IN ('COMPLETED','CLAIMED','UNCLAIMED')
and si.create_ts >= GREATEST(TO_DATE('3/1/2021','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_BH_IDD_TASK_DTL_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_BH_IDD_TASK_DTL_SV TO MAXDAT_REPORTS;



drop view EMRS_D_DATA_ENTRY_TASKS_SV;
CREATE OR REPLACE VIEW EMRS_D_DATA_ENTRY_TASKS_SV AS
select CASE WHEN DO.xml_meta_data NOT LIKE ('%>FAX<%') THEN 1 ELSE 0 END not_fax_is_1,
  si.step_instance_id, 
  si.process_instance_id, 
  si.case_id,
  si.client_id,
  es.reasons,  
  do.document_id, 
  do.DCN,gg.group_name, 
  st.First_name ||' '|| st.last_name Full_Name, 
  si.owner, 
  si.status, 
  sd.name, 
  si.create_ts, 
  do.scan_date, 
  si.step_due_ts, 
  si.Completed_ts, 
  sysdate run_date,
  CASE WHEN es.subprogram_type LIKE 'TP%' THEN 'TP' ELSE 'SP' END tpsp_elig_indicator
from eb.step_instance si 
left join eb.client_elig_status es on es.client_id = si.client_id and es.end_date is null
join eb.step_definition sd on (sd.step_definition_id = si.step_definition_id) 
join eb.groups gg on gg.group_id = si.group_id
left join eb.staff st on st.staff_id = si.owner
join eb.document do on do.document_id = si.ref_id
where gg.Group_name in ('Call Center', 'Data Entry Unit')
and si.create_ts >= GREATEST(TO_DATE('3/1/2021','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
order by si.owner, si.status, si.Create_ts, si.Completed_ts
;

GRANT SELECT ON EMRS_D_DATA_ENTRY_TASKS_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON EMRS_D_DATA_ENTRY_TASKS_SV TO MAXDAT_REPORTS;

DROP VIEW F_REQUEST_TO_MOVE_SUBMITTED_DATE_SV;
DROP VIEW F_REQUEST_TO_MOVE_BY_STATUS_DATE_SV;
DROP VIEW D_REQUEST_TO_MOVE_SV;