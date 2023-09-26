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

DROP VIEW MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_TRANS_SV;
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_TAILORED_PLAN_TRANS_SV"  AS 
  select x.CLIENT_ID, x.client_cin, x.CASE_ID, x.case_cin, x.STAFF_ID, x.trans_date, x.trans_time, x.selection_source_cd, x.transaction_type_cd 
, x.mvx, x.mcs, x.plan_id_ext, x.start_date, x.status_cd
, case when COALESCE(x.ack_ct,0) = 0 then 'No' else 'Yes' end "Acknowledgment Exists"
, case when COALESCE(x.conf_ct,0) = 0 then 'No' else 'Yes' end "Confirmation Exists"
, x.created_by,x.plan_service_type_cd,x.subprogram_type
from (
select i.CLIENT_ID, I.CASE_ID, i.case_cin , i.client_cin , st.STAFF_ID, trunc(t.create_ts) trans_date , to_char(t.create_ts,'MI:HH AM') trans_time
, st.last_name||', '||st.first_name created_by , t.transaction_type_cd , es.elig_status_cd mvx, es.reasons mcs, t.selection_source_cd , t.plan_id_ext , t.start_date
, t.status_cd,t.plan_service_type_cd  
, (select count(1) from survey s1
      join survey_template st1 on st1.survey_template_id = s1.survey_template_id             
      join survey_context sc1 on sc1.survey_id = s1.survey_id
      join survey_template_context stc1 on stc1.survey_template_context_id = sc1.survey_template_context_id
       and stc1.ref_type = 'CLIENT' 
     where st1.title IN('Tailored Plan Acknowledgement' ,'TP 2022 Acknowledgement')
     and sc1.ref_value = t.client_id 
     and trunc(s1.status_date) BETWEEN trunc(t.create_ts) AND trunc(t.create_ts) + 7
     and s1.status_cd = 'COMPLETED') ack_ct
, ( select count(1) from survey s2
      join survey_template st2 on st2.survey_template_id = s2.survey_template_id      
      join survey_context sc2 on sc2.survey_id = s2.survey_id
      join survey_template_context stc2 on stc2.survey_template_context_id = sc2.survey_template_context_id
       and stc2.ref_type = 'CLIENT' 
     where st2.title like 'Enrollment Confirmation%' 
     and sc2.ref_value = t.client_id 
     and trunc(s2.status_date) BETWEEN trunc(t.create_ts) AND trunc(t.create_ts) + 7
     and s2.status_cd = 'COMPLETED') conf_ct
,es.subprogram_type     
from (SELECT t.*,ct.plan_service_type_cd FROM selection_txn t
       LEFT JOIN contract ct ON t.contract_id = ct.contract_id
      WHERE LENGTH(TRIM(TRANSLATE(t.created_by, ' +-.0123456789',' '))) IS NULL) t -- verify created_by contains only numeric data
join client_supplementary_info i on i.client_id = t.client_id
join client_elig_status es on es.client_id = t.client_id
and es.end_date is null
and es.elig_status_cd = 'V'
and es.reasons in ('MCS005','MCS027','MCS035')
join staff st on st.staff_id = t.created_by
WHERE TRUNC(T.CREATE_TS) > TO_DATE('3/01/2021','MM/DD/YYYY') 
and t.status_cd <> 'invalid' ) x
--order by x.case_cin , x.client_cin
;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_TRANS_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_TRANS_SV TO MAXDAT_REPORTS;
