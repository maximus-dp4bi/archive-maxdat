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

DROP VIEW MAXDAT_SUPPORT.EMRS_D_BH_IDD_HEALTH_PLAN_SV;
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_BH_IDD_HEALTH_PLAN_SV" ("STATUS_DATE", "STATUS_CD", "CASE_CIN", "CLIENT_CIN", "PLAN_NAME","MCS_CODE","CLIENT_ID","SUBPROGRAM_TYPE","PLAN_SERVICE_TYPE_CD") AS 
SELECT status_date
, status_cd -- not in report spec
, case_cin
, client_cin
, plan_name
, selection_generic_field5_txt
, client_id
, subprogram_type
, plan_service_type_cd
FROM(
  select st.status_date STATUS_DATE
, st.status_cd -- not in report spec
, cs.case_id CASE_CIN
, cs.client_cin
, pl.plan_name PLAN_NAME
, st.selection_generic_field5_txt
, st.client_id CLIENT_ID
, cs.subprogram_type
, ct.plan_service_type_cd
, ROW_NUMBER() OVER (PARTITION BY st.client_id,st.selection_txn_id ORDER BY st.selection_txn_id,cs.client_elig_status_id) rn
from EB.SELECTION_TXN st
join EB.CLIENT_SUPPLEMENTARY_INFO cs on (cs.CLIENT_ID = st.client_id)
--left join client_elig_status cs ON st.client_id = cs.client_id and cs.end_date IS NULL --AND elig_status_cd IN('M','V')
left join client_elig_status cs ON st.client_id = cs.client_id and TRUNC(st.status_date) BETWEEN TRUNC(cs.start_date) AND TRUNC(COALESCE(cs.end_date,TO_DATE('12/31/2050','mm/dd/yyyy'))) --get the eligibility at the time of selection status date
left join eb.plans pl on st.plan_id = pl.plan_id
left join eb.contract ct on st.contract_id = ct.contract_id
where st.STATUS_CD = 'acceptedByState'
and st.selection_generic_field5_txt in ('MCS004','MCS005','MCS006','MCS007','MCS012','MCS027','MCS028','MCS031','MCS035','MCS036','MCS039','MCS045','MCS046','MCS049','MCS050')
and st.status_date >= GREATEST(TO_DATE('3/1/2021','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13)))
WHERE rn = 1
;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_BH_IDD_HEALTH_PLAN_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_BH_IDD_HEALTH_PLAN_SV TO MAXDAT_REPORTS;


