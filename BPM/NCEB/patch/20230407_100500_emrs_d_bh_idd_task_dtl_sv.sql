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
      
     LEFT JOIN (
	SELECT * FROM (select link_ref_id,tt.report_label doc_form_type,tt.value, ds.received_date form_submitted_date,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY dl.doc_link_id DESC) rnum FROM doc_link dl
		JOIN document d ON dl.document_id = d.document_id
        JOIN document_set ds ON d.document_set_id = ds.document_set_id
		JOIN enum_document_type t1 ON t1.value = d.doc_form_type
		JOIN enum_doc_code_to_type tt ON t1.value = tt.value
		WHERE tt.value IN ('TP_NS_PRV','TP_NS_MEM','TP_SA_PRV')
			AND link_type_cd = 'INCIDENT_HEADER') dd WHERE rnum = 1	) dt ON  dt.link_ref_id=si.ref_id  AND si.ref_type IN('incident_header','INCIDENT_HEADER')
where (sd.name like ('BH%') or sd.name like ('%ServiceAssociated%') or sd.name  IN ('Waiting for Signature','Submitted for Clinical Review','Waiting for Information','Update NC Fast'))
AND si.STATUS IN ('COMPLETED','CLAIMED','UNCLAIMED')
and si.create_ts >= GREATEST(TO_DATE('3/1/2021','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_BH_IDD_TASK_DTL_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_BH_IDD_TASK_DTL_SV TO MAXDAT_REPORTS;


