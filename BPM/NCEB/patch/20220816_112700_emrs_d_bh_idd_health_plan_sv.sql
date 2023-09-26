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

--Back out plan
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_BH_IDD_HEALTH_PLAN_SV" ("STATUS_DATE", "STATUS_CD", "CASE_CIN", "CLIENT_CIN", "PLAN_NAME","MCS_CODE")
AS
select st.status_date STATUS_DATE
, st.status_cd -- not in report spec
, cs.case_id CASE_CIN
, st.client_id CLIENT_CIN
, pl.plan_name PLAN_NAME
, st.selection_generic_field5_txt
from EB.SELECTION_TXN st
join EB.CLIENT_SUPPLEMENTARY_INFO cs on (cs.CLIENT_ID = st.client_id)
left join eb.plans pl on st.plan_id = pl.plan_id
where st.STATUS_CD = 'acceptedByState'
and st.selection_generic_field5_txt in ('MCS004','MCS005','MCS006','MCS007','MCS012','MCS027','MCS028','MCS031','MCS035','MCS036','MCS039','MCS045','MCS046','MCS049','MCS050')
and st.status_date >= GREATEST(TO_DATE('3/1/2021','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13));

