Create or replace view D_SURVEY_SV as
with cscl as (
select  s.survey_id, s.case_id, cscl1.cscl_clnt_client_id client_id, s.status_date
from eb.survey s
join eb.case_client cscl1 on cscl1.cscl_case_id = s.case_id
and cscl1.STATUS_BEGIN_NDT < CSCL1.STATUS_END_NDT
where s.status_date >= add_months(sysdate,-13)
AND s.created_by != '-999'
group by s.survey_id, s.case_id, cscl1.cscl_clnt_client_id, s.status_date
)
, selc as (
select sel.plan_id, cscl.survey_id, sel.client_id, sel.create_ts
, ROW_NUMBER() OVER(PARTITION BY  cscl.survey_id ORDER BY ABS(SEL.CLIENT_ID - cscl.CLIENT_ID), (SEL.CREATE_TS - cscl.status_date)) ROWN
from cscl
join eb.selection_segment sel on sel.CLIENT_ID = CSCL.CLIENT_ID --and selc.start_nd < selc.end_nd
                               AND SEL.PROGRAM_TYPE_CD = 'MEDICAID'
                                AND SEL.PLAN_TYPE_CD = 'MEDICAL'
                                AND (LEAST(SEL.CREATE_TS, SEL.START_DATE) <= cscl.status_date)
)
, surplan as (                                
select * from selc
where rown = 1
)
select "SURVEY_ID","PLAN_ID","PLAN_ID_EXT","PLAN_SERVICE_TYPE_CD","PROVIDER_ORG_TYPE","PROVIDER_ORG_CD","CLIENT_NUMBER","CASE_NUMBER","SEL_CLIENT_ID","SURVEY_TEMPLATE_ID","SURVEY_TITLE","STATUS_CD","REFUSE_REASON_CD","RECEIVED_VIA_CD","RECEIVED_DATE","CA_DATE","STAFF_NAME","CREATED_BY","CREATE_TS","UPDATE_TS","SURVEY_DURATION", "ROWN" from (
SELECT s.survey_id
, surplan.plan_id
, pl.plan_id_ext
--, con.contract_id
, con.plan_service_type_cd
, PROV.PROVIDER_ORG_TYPE
, PROV.PROVIDER_ORG_CD
, s.client_id CLIENT_NUMBER
, s.case_id CASE_NUMBER
, surplan.client_id sel_client_id
, s.survey_template_id
, t.title SURVEY_TITLE
, s.status_cd
, s.refuse_reason_cd
, s.received_via_cd
, s.received_date
, trunc(s.status_date) ca_date
, stf.first_name || ' ' || stf.last_name staff_name
, s.created_by
, s.create_ts
, S.UPDATE_TS
, ROUND((S.UPDATE_TS - S.CREATE_TS) * 24*60,0) AS SURVEY_DURATION
, ROW_NUMBER() OVER(PARTITION BY  s.survey_id ORDER BY surplan.rown) ROWN
 FROM EB.survey s
 JOIN EB.enum_survey_status ss ON ss.value = s.status_cd
 JOIN EB.survey_template t ON t.survey_template_id = s.survey_template_id
 left join EB.staff stf on to_char(stf.staff_id) = s.updated_by
/*LEFT JOIN EB.CASE_CLIENT CSCL ON CSCL.CSCL_CASE_ID = s.CASE_ID
                              AND CSCL.STATUS_BEGIN_NDT < CSCL.STATUS_END_NDT
--                              AND CSCL.cscl_STATUS_BEGIN_date <= s.status_date
--                              AND CSCL.cscl_STATUS_END_date > s.status_date
--LEFT JOIN EB.ENUM_AID_CATEGORY EAID ON EAID.VALUE = CSCL.CSCL_ADLK_ID
LEFT JOIN EB.SELECTION_SEGMENT SELC ON (SELC.CLIENT_ID = CSCL.CSCL_CLNT_CLIENT_ID AND SELC.PROGRAM_TYPE_CD = 'MEDICAID'
                                AND SELC.PLAN_TYPE_CD = 'MEDICAL'
                                AND (LEAST(SELC.CREATE_TS, SELC.START_DATE) <= s.status_date)
                                )
*/
left join surplan on surplan.survey_id = s.survey_id
left join EB.plans pl on pl.plan_id = surplan.plan_id
LEFT JOIN EB.contract con on con.plan_id = pl.plan_id
left join MAXDAT_SUPPORT.EMRS_D_COEB_PROVIDER_SV PROV ON (CON.PLAN_sERVICE_TYPE_CD = 'ACC' AND prov.plan_id_ext = pl.plan_id_ext)
WHERE 1=1
AND s.status_date >= add_months(sysdate,-13)
AND 1 = (case when (t.title like 'Heal%Sur%') and ss.value = 'INITIATED' then 0 else 1 end)
AND 1 = (case when (t.title like 'Heal%Sur%') then 1 else 0 end)
AND s.created_by != '-999'
)
where rown = 1
;


GRANT SELECT ON MAXDAT_SUPPORT.D_SURVEY_SV TO MAXDAT_REPORTS;  
