DROP VIEW MAXDAT_SUPPORT.EMRS_D_BH_IDD_TASK_DTL_SV;

CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_BH_IDD_TASK_DTL_SV" ("TASK_ID", "TASK_NAME", "CASE_ID", "CNDS_ID", "CLIENT_ID", "CLIENT_NAME", "CLIENT_DOB", "SERVICE_ASSOCIATED", "STATUS", "CREATE_DATE", "DUE_DATE", "COMPLETED_DATE", "TASK_AGE","DOC_FORM_TYPE","FORM_SUBMITTED_DATE") AS 
select si.step_instance_id TASK_ID -- this is the bhidd report
, sd.display_name TASK_NAME
, si.case_id
, csi.CLIENT_CIN CNDS_ID
, si.client_id
, cl.CLNT_Fname ||' '|| cl.Clnt_lname CLIENT_NAME
, cl.clnt_dob
, case when sd.name like '%ServiceAssociated%' then 'Y'
when dt.value in ('TP_NS_PRV','TP_NS_MEM')then 'N'
when dt.value in ('TP_SA_PRV')then 'Y'
ELSE 'N' end SERVICE_ASSOCIATED
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
  LEFT JOIN (SELECT ih.incident_header_id,dd.client_id,dd.doc_form_type,dd.form_submitted_date,dd.value,dd.update_ts,ROW_NUMBER() OVER (PARTITION BY ih.incident_header_id,dd.client_id ORDER BY dd.doc_link_id) rnum
             FROM incident_header ih
                LEFT JOIN(SELECT dl.*,tt.report_label doc_form_type,tt.value, ds.received_date form_submitted_date FROM doc_link dl
                           JOIN document d ON dl.document_id = d.document_id
                           JOIN document_set ds ON d.document_set_id = ds.document_set_id
                           JOIN enum_document_type t1 on t1.value = d.doc_form_type
                           JOIN enum_doc_code_to_type tt ON t1.value = tt.value
                          WHERE tt.value in ('TP_NS_MEM','TP_NS_PRV','TP_SA_PRV')) dd ON ih.client_id = dd.client_id AND TRUNC(ih.create_ts) >= TRUNC(dd.update_ts)) dt 
     ON dt.incident_header_id = si.ref_id AND si.ref_type IN('incident_header','INCIDENT_HEADER') AND rnum = 1
where (sd.name like ('BH%') or sd.name like ('%ServiceAssociated%') or sd.name  IN ('Waiting for Signature','Submitted for Clinical Review','Waiting for Information','Update NC Fast'))
AND si.STATUS IN ('COMPLETED','CLAIMED','UNCLAIMED')
and si.create_ts >= GREATEST(TO_DATE('3/1/2021','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_BH_IDD_TASK_DTL_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_BH_IDD_TASK_DTL_SV TO MAXDAT_REPORTS;