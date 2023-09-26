CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_BH_IDD_HEALTH_PLAN_SV" ("STATUS_DATE", "STATUS_CD", "CASE_CIN", "CLIENT_CIN", "PLAN_NAME","MCS_CODE","CLIENT_ID","SUBPROGRAM_TYPE","PLAN_SERVICE_TYPE_CD") AS 
  select st.status_date STATUS_DATE
, st.status_cd -- not in report spec
, cs.case_id CASE_CIN
, cs.client_cin
, pl.plan_name PLAN_NAME
, st.selection_generic_field5_txt
, st.client_id CLIENT_ID
, cs.subprogram_type
, ct.plan_service_type_cd
from EB.SELECTION_TXN st
join EB.CLIENT_SUPPLEMENTARY_INFO cs on (cs.CLIENT_ID = st.client_id)
left join client_elig_status cs ON st.client_id = cs.client_id and cs.end_date IS NULL --AND elig_status_cd IN('M','V')
left join eb.plans pl on st.plan_id = pl.plan_id
left join eb.contract ct on st.contract_id = ct.contract_id
where st.STATUS_CD = 'acceptedByState'
and ((st.selection_generic_field5_txt in ('MCS004','MCS005','MCS006','MCS007','MCS012','MCS027','MCS028','MCS031','MCS035','MCS036','MCS039','MCS045','MCS046','MCS049','MCS050'))
  or (ct.plan_service_type_cd = 'STDPLN' and cs.subprogram_type like 'TP%') )
and st.status_date >= GREATEST(TO_DATE('3/1/2021','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
;


CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_TAILORED_PLAN_TRANS_SV"  AS 
  select x.CLIENT_ID, x.client_cin, x.CASE_ID, x.case_cin, x.STAFF_ID, x.trans_date, x.trans_time, x.selection_source_cd, x.transaction_type_cd 
, x.mvx, x.mcs, x.plan_id_ext, x.start_date, x.status_cd
, case when COALESCE(x.ack_ct,0) = 0 then 'No' else 'Yes' end "Acknowledgment Exists"
, case when COALESCE(x.conf_ct,0) = 0 then 'No' else 'Yes' end "Confirmation Exists"
, x.created_by,x.plan_service_type_cd
from (
select i.CLIENT_ID, I.CASE_ID, i.case_cin , i.client_cin , st.STAFF_ID, trunc(t.create_ts) trans_date , to_char(t.create_ts,'MI:HH AM') trans_time
, st.last_name||', '||st.first_name created_by , t.transaction_type_cd , es.elig_status_cd mvx, es.reasons mcs, t.selection_source_cd , t.plan_id_ext , t.start_date
, t.status_cd,t.plan_service_type_cd  
, sctpa.ack_ct
, scec.conf_ct
from (SELECT t.*,ct.plan_service_type_cd FROM selection_txn t
       LEFT JOIN contract ct ON t.contract_id = ct.contract_id
      WHERE LENGTH(TRIM(TRANSLATE(t.created_by, ' +-.0123456789',' '))) IS NULL) t -- verify created_by contains only numeric data
join client_supplementary_info i on i.client_id = t.client_id
join client_elig_status es on es.client_id = t.client_id and es.end_date is null
join staff st on st.staff_id = t.created_by
left join(select sc1.ref_value, s1.CASE_ID, count(1) ack_ct
      from survey s1
      join survey_template st1 on st1.survey_template_id = s1.survey_template_id      
      join survey_context sc1 on sc1.survey_id = s1.survey_id
      join survey_template_context stc1 on stc1.survey_template_context_id = sc1.survey_template_context_id
       and stc1.ref_type = 'CLIENT' 
      where st1.title = 'Tailored Plan Acknowledgement' 
      group by sc1.ref_value, s1.CASE_ID) sctpa ON sctpa.ref_value = t.client_id AND sctpa.CASE_ID = i.case_id 
left join ( select sc2.ref_value, s2.CASE_ID, count(1) conf_ct
      from survey s2
      join survey_template st2 on st2.survey_template_id = s2.survey_template_id       
      join survey_context sc2 on sc2.survey_id = s2.survey_id
      join survey_template_context stc2 on stc2.survey_template_context_id = sc2.survey_template_context_id
       and stc2.ref_type = 'CLIENT' 
      where st2.title like 'Enrollment Confirmation%' 
      group by sc2.ref_value, s2.CASE_ID ) scec ON scec.ref_value = t.client_id AND scec.CASE_ID = i.case_id   
WHERE TRUNC(T.CREATE_TS) > TO_DATE('3/01/2021','MM/DD/YYYY') 
and t.status_cd <> 'invalid' 
and ( (es.elig_status_cd = 'V' and es.reasons in ('MCS005','MCS027','MCS035') )
 or (es.elig_status_cd IN('V','M') and es.subprogram_type like 'TP%') ) ) x
--order by x.case_cin , x.client_cin
;