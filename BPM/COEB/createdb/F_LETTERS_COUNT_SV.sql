CREATE OR REPLACE VIEW F_LETTERS_COUNT_SV
AS
WITH 
MATACT as (
SELECT
D.D_DATE AS RECORD_DATE
, LAST_DAY(D.D_DATE) RECORD_MONTH
, PST.VALUE PLAN_SERVICE_TYPE_CD
, ACT.RECORD_NAME
, ACT.ACTIVITY_RECORD
, ACT.ACTIVITY_TYPE
, ACT.SUB_ACTIVITY_TYPE
, ACT.ACTIVITY_ID
, ACT.ACTIVITY_CONTEXT
, ACT.CALL_RECORD_ID
, ACT.CALL_TYPE_CD
, ACT.EVENT_ID
, ACT.SELECTION_TXN_ID
, ACT.TRANSACTION_TYPE_CD
, ACT.SELECTION_SOURCE_CD
, ACT.PLAN_ID
, ACT.PLAN_ID_EXT
, ACT.CONTRACT_ID
, ACT.PROVIDER_ID
, ACT.PROVIDER_ID_EXT
, ACT.TO_PLAN_ID
, ACT.TO_PLAN_ID_EXT
, ACT.TO_PROVIDER_ID
, ACT.TO_PROVIDER_ID_EXT
, ACT.TO_CONTRACT_ID
, ACT.ACCEPTED_DATE
, CASE WHEN PST.VALUE = 'ACC' AND PLAN_ID_EXT IN ('99999901', '99999905', '99999908') AND PROVIDER_ID_EXT IN ('07020368','23876239') THEN 'MCO'
       ELSE 'PCMP' END PROVIDER_ORG_TYPE
, CASE WHEN PST.VALUE = 'ACC' AND PLAN_ID_EXT IN ('99999901', '99999905', '99999908') AND PROVIDER_ID_EXT IN ('07020368','23876239') THEN PROVIDER_ID_EXT
       ELSE 'PCMP' END PROVIDER_ORG_CD
FROM MAXDAT_SUPPORT.D_DATES d
JOIN EB.ENUM_PLAN_SERVICE_TYPE PST ON 1=1
LEFT JOIN
(
SELECT /*+ INDEX_DESC(CR) INDEX_desc(SELC) INDEX_DESC(ST) index_desc(crl) index_desc(CSCL) index_desc(SMID) */
CR.CALL_DATE REC_DATE
, LAST_DAY(CR.CALL_DATE) REC_MONTH
, 'CALL_RECORD' ACTIVITY_RECORD
, CASE WHEN CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND (CONTEXT LIKE '%MATERIAL%' or CONTEXT LIKE '%HANDBOOK%REQUEST%') THEN 'MATERIAL_REQUEST'
       ELSE 'OTHER_CALLS'
       END ACTIVITY_TYPE
, CASE WHEN CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND (CONTEXT LIKE '%MATERIAL%' or CONTEXT LIKE '%HANDBOOK%REQUEST%') THEN 'MATERIAL_REQUEST'
       ELSE 'OTHER_CALLS'
       END SUB_ACTIVITY_TYPE
, NVL(TO_NUMBER(LPAD(TO_CHAR(NVL(EVENT_ID,0)),10,'0')||LPAD(TO_CHAR(NVL(CALL_RECORD_ID,0)),10,'0')||LPAD(TO_CHAR(NVL(SELECTION_TXN_ID,0)),10,'0')||LPAD(TO_CHAR(NVL(SELECTION_SEGMENT_ID,0)),10,'0')),-1) ACTIVITY_ID
, UPPER(CONTEXT) ACTIVITY_CONTEXT
, CR.RECORD_NAME
, CR.CALL_RECORD_ID
, CR.CALL_TYPE_CD
, CR.EVENT_ID
, CR.SELECTION_TXN_ID
, CR.PLAN_SERVICE_TYPE_CD
, CR.DISENROLL_REASON_CD_1
, CR.DISENROLL_REASON_CD_2
, CR.SELECTION_SOURCE_CD
, CR.ACCEPTED_DATE
, CR.CHOICE_REASON_CD
, CR.PLAN_ID
, CR.PLAN_ID_EXT
, CR.CONTRACT_ID
, CR.TRANSACTION_TYPE_CD
, CR.PROVIDER_ID
, CR.PROVIDER_ID_EXT
, CR.TO_PLAN_ID
, CR.TO_PLAN_ID_EXT
, CR.TO_CONTRACT_ID
, CR.TO_PROVIDER_ID
, CR.TO_PROVIDER_ID_EXT
FROM MAXDAT_SUPPORT.EMRS_D_CALL_RECORD_SV CR
where (CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND (CONTEXT LIKE '%HANDBOOK%REQUEST%' OR CONTEXT LIKE '%MATERIAL%'))
) act ON ACT.REC_DATE = D.D_DATE AND ACT.PLAN_SERVICE_TYPE_CD = PST.VALUE
where 1=1
AND PST.VALUE IN ('CHP','ACC')
AND D.D_DATE >= TO_DATE('1/1/2022','MM/DD/YYYY')
AND D.D_DATE <= TRUNC(SYSDATE)
)
, ALLM AS (
SELECT
  TRUNC(RECORD_DATE,'MM') RECORD_DATE,   
  'MEDICAID' PROGRAM_CODE,
  'MEDICAL' PLAN_TYPE,
  ACT.plan_Service_type_Cd,
  ACT.PLAN_ID,
  ACT.PROVIDER_ORG_TYPE,
  ACT.provider_org_CD
  , 0 ACC_ENRL_LTR_CNT
  , 0 ACC_OE_LTR_CNT
  , 0 ACC_REATTRIB_LTR_CNT
  , 0 CHP_SINGLE_ENRL_LTR_CNT
  , 0 CHP_MULTI_ENRL_LTR_CNT
  , 0 CHP_PE_LTR_CNT
  , 0 CHP_PREE_LTR_CNT
  , 0 ACC_RET_LTR_CNT
  , 0 CHP_RET_LTR_CNT
  , 0 RET_ACC_ENRL_LTR_CNT
  , 0 RET_ACC_OE_LTR_CNT
  , 0 RET_CHP_SINGLE_ENRL_LTR_CNT
  , 0 RET_CHP_MULTI_ENRL_LTR_CNT
  , 0 RET_CHP_PE_LTR_CNT
  , 0 RET_CHP_PREE_LTR_CNT
  , SUM(CASE WHEN ACT.ACTIVITY_CONTEXT = 'MATERIAL_REQUEST' THEN 1 ELSE 0 END) MATERIAL_REQUEST_CNT
  , SUM(CASE WHEN ACT.ACTIVITY_CONTEXT = 'HANDBOOK_REQUEST' THEN 1 ELSE 0 END) HANDBOOK_REQUEST_CNT
  FROM MATACT ACT
  WHERE ACT.ACTIVITY_RECORD = 'CALL_RECORD'
  AND ACT.ACTIVITY_TYPE IN ('MATERIAL_REQUEST')
  GROUP BY TRUNC(RECORD_DATE,'MM'),
  ACT.plan_Service_type_Cd,
  ACT.PLAN_ID,
  ACT.PROVIDER_ORG_TYPE,
  ACT.provider_org_CD
) 
, MINL AS (
select min(lr1.lmreq_id) MINLMREQ_ID 
from letter_request lr1 
where lr1.requested_on >= trunc(add_months(sysdate,-14),'MM')
) 
SELECT 
  RECORD_DATE,
  M.PROGRAM_CODE,
  M.PLAN_TYPE,
  M.plan_Service_type_Cd,
  M.PLAN_ID,
  M.PROVIDER_ORG_TYPE,
  M.provider_org_CD
  , SUM(NVL(ACC_ENRL_LTR_CNT,0)) ACC_ENRL_LTR_CNT
  , 0 ACC_MIXED_ENRL_LTR_CNT
  , SUM(NVL(ACC_OE_LTR_CNT,0)) ACC_OE_LTR_CNT
  , SUM(NVL(ACC_REATTRIB_LTR_CNT,0)) ACC_REATTRIB_LTR_CNT
  , sum(NVL(CHP_SINGLE_ENRL_LTR_CNT,0)) CHP_SINGLE_ENRL_LTR_CNT
  , SUM(NVL(CHP_MULTI_ENRL_LTR_CNT,0)) CHP_MULTI_ENRL_LTR_CNT
  , SUM(NVL(CHP_PE_LTR_CNT,0)) CHP_PE_LTR_CNT
  , SUM(NVL(CHP_PREE_LTR_CNT,0)) CHP_PREE_LTR_CNT
  , SUM(NVL(ACC_RET_LTR_CNT,0)) ACC_RET_LTR_CNT
  , SUM(NVL(CHP_RET_LTR_CNT,0)) CHP_RET_LTR_CNT
--  , SUM(NVL(RET_ACC_ENRL_LTR_CNT,0)) RET_ACC_ENRL_LTR_CNT
--  , SUM(NVL(RET_ACC_OE_LTR_CNT,0)) RET_ACC_OE_LTR_CNT
--  , SUM(NVL(RET_CHP_SINGLE_ENRL_LTR_CNT,0)) RET_CHP_SINGLE_ENRL_LTR_CNT
--  , SUM(NVL(RET_CHP_MULTI_ENRL_LTR_CNT,0)) RET_CHP_MULTI_ENRL_LTR_CNT
--  , SUM(NVL(RET_CHP_PE_LTR_CNT,0)) RET_CHP_PE_LTR_CNT
  , SUM(NVL(MATERIAL_REQUEST_CNT,0)) MATERIAL_REQUEST_CNT
  , SUM(NVL(HANDBOOK_REQUEST_CNT,0)) HANDBOOK_REQUEST_CNT
  , NULL HANDBOOK_MAILED_CNT
 FROM
(
  SELECT D.D_MONTH_START RECORD_DATE,
  f.PROGRAM_CODE,
  f.PLAN_TYPE,
  f.plan_Service_type_Cd,
  f.PLAN_ID,
  F.PROVIDER_ORG_TYPE,
  f.provider_org_CD
  , SUM(NVL(ACC_ENRL_LTR,0)) ACC_ENRL_LTR_CNT
  , SUM(NVL(ACC_OE_LTR,0)) ACC_OE_LTR_CNT
  , SUM(NVL(ACC_REATTRIB_LTR,0)) ACC_REATTRIB_LTR_CNT
  , sum(NVL(CHP_SINGLE_ENRL_LTR,0)) CHP_SINGLE_ENRL_LTR_CNT
  , SUM(NVL(CHP_MULTI_ENRL_LTR,0)) CHP_MULTI_ENRL_LTR_CNT
  , SUM(NVL(CHP_PE_LTR,0)) CHP_PE_LTR_CNT
  , SUM(NVL(CHP_PREE_LTR,0)) CHP_PREE_LTR_CNT
--  , SUM(NVL(ACC_LTR_RTND,0)) ACC_RET_LTR_CNT
--  , SUM(NVL(CHP_LTR_RTND,0)) CHP_RET_LTR_CNT
  , 0 ACC_RET_LTR_CNT
  , 0 CHP_RET_LTR_CNT  
  , 0 RET_ACC_ENRL_LTR_CNT
  , 0 RET_ACC_OE_LTR_CNT
  , 0 RET_CHP_SINGLE_ENRL_LTR_CNT
  , 0 RET_CHP_MULTI_ENRL_LTR_CNT
  , 0 RET_CHP_PE_LTR_CNT
  , 0 RET_CHP_PREE_LTR_CNT
  , 0 MATERIAL_REQUEST_CNT
  , 0 HANDBOOK_REQUEST_CNT
FROM MAXDAT_SUPPORT.D_MONTHS d
JOIN
  (
  SELECT /*+ INDEX_desc(lr, LETTER_REQUESTS_PK) INDEX(cld, CLIENT_LETTER_DATA_PK)*/ lr.lmreq_id
  , lr.sent_on
  , lr.mailed_date
  , trunc(lr.mailed_date,'MM') rec_month
  , cld.matched_case_id case_id
  , cld.matched_client_id client_id
  , coalesce(con.program_type_cd,'0') program_code
  , PL.PLAN_TYPE_CD PLAN_TYPE
  , case when ld.name in ('MGD-0470-R', 'MGD-0480-R', 'MGD-1XXX-R','MGD-0500-R') then COALESCE(pl.plan_id, 0)
         when ld.name in ('MGD-0450-R', 'MGD-0440-R', 'MGD-0490-R','MGD-0510-R') then COALESCE(pl.plan_id, 1)
         else COALESCE(pl.plan_id, 0) 
         end plan_id
  , case when ld.name in ('MGD-0470-R', 'MGD-0480-R', 'MGD-1XXX-R','MGD-0500-R') then COALESCE(pl.plan_id_ext, '0')
         when ld.name in ('MGD-0450-R', 'MGD-0440-R', 'MGD-0490-R','MGD-0510-R') then COALESCE(pl.plan_id_ext, '1')
         else COALESCE(pl.plan_id_ext, '0')
         end plan_id_ext
  , case when ld.name in ('MGD-0470-R', 'MGD-0480-R', 'MGD-1XXX-R','MGD-0500-R') then 'ACC'
         when ld.name in ('MGD-0450-R', 'MGD-0440-R', 'MGD-0490-R','MGD-0510-R') then 'CHP'
         else nvl(con.plan_Service_type_cd, 'ACC')
         end plan_Service_type_cd
  , prov.PROVIDER_CODE
  -- 11/21/2019 changed to base on letter name after confirmation from Diana
  , case when ld.name in ('MGD-0480-R', 'MGD-1XXX-R', 'MGD-0500-R') then 'MCO' 
         when ld.name in ('MGD-0470-R') then 'PCMP'
         when ld.name in ('MGD-0430-R','MGD-0520-R') and prov.provider_code is null then 'PCMP' 
           else PROV.PROVIDER_ORG_TYPE end PROVIDER_ORG_TYPE
  , case when ld.name in ('MGD-0480-R', 'MGD-1XXX-R', 'MGD-0500-R') and prov.provider_code is null then 'MCO' 
         when ld.name in ('MGD-0470-R') then 'PCMP'
         when ld.name in ('MGD-0430-R','MGD-0520-R') and prov.provider_code is null then 'PCMP'
    else PROV.PROVIDER_ORG_CD end PROVIDER_ORG_CD
  , PROV.PROVIDER_CODE PROVIDER_ID_EXT
  , case when ld.name in ('MGD-0470-R', 'MGD-0480-R') then 1 else 0 end ACC_ENRL_LTR
  , case when ld.name in ('MGD-1XXX-R', 'MGD-0500-R') then 1 else 0 end ACC_OE_LTR
  , CASE WHEN LD.NAME IN ('MGD-0430-R','MGD-0520-R') THEN 1 ELSE 0 END ACC_REATTRIB_LTR
  , case when ld.name in ('MGD-0450-R') then 1 else 0 end CHP_SINGLE_ENRL_LTR
  , CASE WHEN LD.NAME IN ('MGD-0440-R') THEN 1 ELSE 0 END CHP_MULTI_ENRL_LTR
  , CASE WHEN LD.NAME IN ('MGD-0490-R') THEN 1 ELSE 0 END CHP_PE_LTR
  , CASE WHEN LD.NAME IN ('MGD-0510-R') THEN 1 ELSE 0 END CHP_PREE_LTR
  , case when ld.name in ('MGD-0470-R', 'MGD-0480-R', 'MGD-1XXX-R','MGD-0500-R', 'MGD-0430-R','MGD-0520-R') and lr.status_cd = 'RTND' then 1 else 0 end ACC_LTR_RTND
  , case when ld.name in ('MGD-0450-R', 'MGD-0440-R', 'MGD-0490-R','MGD-0510-R') and lr.status_cd = 'RTND' then 1 else 0 end CHP_LTR_RTND
  , row_number() over(partition by lr.lmreq_id, 
    case when ld.name in ('MGD-0470-R', 'MGD-0480-R', 'MGD-1XXX-R','MGD-0500-R') then COALESCE(pl.plan_id, 0)
         when ld.name in ('MGD-0450-R', 'MGD-0440-R', 'MGD-0490-R','MGD-0510-R') then COALESCE(pl.plan_id, 1)
         else COALESCE(pl.plan_id, 0) 
         end order by 1) rown
from  &schema_name..letter_definition ld
join minl minl on 1=1
left join &schema_name..letter_request lr on ld.lmdef_id = lr.lmdef_id 
     and lr.lmreq_id >= minl.minlmreq_id 
     and lr.lmreq_id >= 10764000
     and lr.mailed_date is not null
left join &schema_name..letter_request_link lrl on lrl.lmreq_id = lr.lmreq_id
left join &schema_name..client_letter_data cld on (cld.client_letter_data_id = lrl.additional_reference_id and lrl.additional_reference_type = 'CLIENT_LETTER_DATA')
left join &schema_name..plans pl on pl.plan_id_ext = case when cld.medical_provider = '23876239' then '99999908' when cld.medical_provider ='7020368' then '99999901' else cld.medical_provider end
LEFT JOIN &schema_name..contract con on con.plan_id = pl.plan_id
left join MAXDAT_SUPPORT.EMRS_D_COEB_PROVIDER_SV PROV ON (CON.PLAN_sERVICE_TYPE_CD = 'ACC' AND prov.plan_id_ext = pl.plan_id_ext 
          and (
              (cld.medical_provider = prov.plan_id_ext and prov.provider_org_type = 'MCO' and ld.name in ('MGD-0480-R', 'MGD-1XXX-R', 'MGD-0500-R', 'MGD-0430-R','MGD-0520-R')) 
              or (cld.medical_provider = prov.plan_id_ext and prov.provider_org_type = 'PCMP' and prov.pcmp_svc_name = cld.pcmp_mco_name and prov.svc_phn_nbr = cld.pcmp_phone_number and ld.name in ('MGD-0470-R', 'MGD-0430-R','MGD-0520-R'))
              ))
where 1=1
--and lr.lmreq_id = 10384531 
) f ON (d.D_MONTH_END BETWEEN GREATEST(ADD_MONTHS(TRUNC(sysdate, 'mm'),-24),TO_DATE('6/1/2018','MM/DD/YYYY')) AND TRUNC(LAST_DAY(sysdate))
          AND d.D_MONTH_START = f.rec_month)
WHERE 1=1
  and f.rown = 1
--  and ((F.plan_service_type_cd = 'ACC' and F.provider_id_ext is not null) or (F.plan_service_type_cd <> 'ACC'))
GROUP BY d.d_month_start,
  f.PROGRAM_CODE,
  f.PLAN_TYPE,
  f.plan_Service_type_Cd,
  f.PLAN_ID,
  F.PROVIDER_ORG_TYPE,
  F.PROVIDER_ORG_CD
UNION ALL
(
  SELECT  
   trunc(ret.Return_Date,'MM') RECORD_DATE
  , ret.program_code
  , ret.PLAN_TYPE
  , ret.plan_Service_type_cd
  , ret.plan_id
  , ret.PROVIDER_ORG_TYPE
  , ret.PROVIDER_ORG_CD
  , 0 ACC_ENRL_LTR_CNT
  , 0 ACC_OE_LTR_CNT
  , 0 ACC_REATTRIB_LTR_CNT
  , 0 CHP_SINGLE_ENRL_LTR_CNT
  , 0 CHP_MULTI_ENRL_LTR_CNT
  , 0 CHP_PE_LTR_CNT
  , 0 CHP_PREE_LTR_CNT
  , SUM(case when ret.name in ('MGD-0470-R', 'MGD-0480-R', 'MGD-1XXX-R','MGD-0500-R','MGD-0430-R','MGD-0520-R') then 1 else 0 end) ACC_RET_LTR_CNT
  , SUM(case when ret.name in ('MGD-0450-R','MGD-0440-R', 'MGD-0490-R','MGD-0510-R') then 1 else 0 end) CHP_RET_LTR_CNT
  , SUM(case when ret.name in ('MGD-0470-R', 'MGD-0480-R') then 1 else 0 end) RET_ACC_ENRL_LTR_CNT
  , SUM(case when ret.name in ('MGD-1XXX-R','MGD-0500-R') then 1 else 0 end) RET_ACC_OE_LTR_CNT
  , SUM(case when ret.name in ('MGD-0450-R') then 1 else 0 end) RET_CHP_SINGLE_ENRL_LTR_CNT
  , SUM(CASE WHEN ret.NAME IN ('MGD-0440-R') THEN 1 ELSE 0 END) RET_CHP_MULTI_ENRL_LTR_CNT
  , SUM(CASE WHEN ret.NAME IN ('MGD-0490-R') THEN 1 ELSE 0 END) RET_CHP_PE_LTR_CNT
  , SUM(CASE WHEN ret.NAME IN ('MGD-0510-R') THEN 1 ELSE 0 END) RET_CHP_PREE_LTR_CNT
  , 0 MATERIAL_REQUEST_CNT
  , 0 HANDBOOK_REQUEST_CNT
  from
  (
    SELECT /*+ INDEX_desc(lr, LETTER_REQUESTS_PK) INDEX(cld, CLIENT_LETTER_DATA_PK)*/ lr.lmreq_id
  , lr.sent_on
  , lr.mailed_date
  , ld.name
  , lr.return_date 
  , cld.matched_case_id case_id
  , cld.matched_client_id client_id
  , coalesce(con.program_type_cd,'0') program_code
  , PL.PLAN_TYPE_CD PLAN_TYPE
  , case when ld.name in ('MGD-0470-R', 'MGD-0480-R', 'MGD-1XXX-R','MGD-0500-R') then COALESCE(pl.plan_id, 0)
         when ld.name in ('MGD-0450-R', 'MGD-0440-R', 'MGD-0490-R','MGD-0510-R') then COALESCE(pl.plan_id, 1)
         else COALESCE(pl.plan_id, 0) 
         end plan_id
  , case when ld.name in ('MGD-0470-R', 'MGD-0480-R', 'MGD-1XXX-R','MGD-0500-R') then COALESCE(pl.plan_id_ext, '0')
         when ld.name in ('MGD-0450-R', 'MGD-0440-R', 'MGD-0490-R','MGD-0510-R') then COALESCE(pl.plan_id_ext, '1')
         else COALESCE(pl.plan_id_ext, '0')
         end plan_id_ext
  , case when ld.name in ('MGD-0470-R', 'MGD-0480-R', 'MGD-1XXX-R','MGD-0500-R') then 'ACC'
         when ld.name in ('MGD-0450-R', 'MGD-0440-R', 'MGD-0490-R','MGD-0510-R') then 'CHP'
         else nvl(con.plan_Service_type_cd, 'ACC')
         end plan_Service_type_cd
  , prov.PROVIDER_CODE
  -- 11/21/2019 changed to base on letter name after confirmation from Diana
  , case when ld.name in ('MGD-0480-R', 'MGD-1XXX-R', 'MGD-0500-R') then 'MCO' 
         when ld.name in ('MGD-0470-R') then 'PCMP'
         when ld.name in ('MGD-0430-R','MGD-0520-R') and prov.provider_code is null then 'PCMP' 
           else PROV.PROVIDER_ORG_TYPE end PROVIDER_ORG_TYPE
  , case when ld.name in ('MGD-0480-R', 'MGD-1XXX-R', 'MGD-0500-R') and prov.provider_code is null then 'MCO' 
         when ld.name in ('MGD-0470-R') then 'PCMP'
         when ld.name in ('MGD-0430-R','MGD-0520-R') and prov.provider_code is null then 'PCMP'
    else PROV.PROVIDER_ORG_CD end PROVIDER_ORG_CD
  , PROV.PROVIDER_CODE PROVIDER_ID_EXT
  , row_number() over(partition by lr.lmreq_id,
    case when ld.name in ('MGD-0470-R', 'MGD-0480-R', 'MGD-1XXX-R','MGD-0500-R') then COALESCE(pl.plan_id, 0)
         when ld.name in ('MGD-0450-R', 'MGD-0440-R', 'MGD-0490-R','MGD-0510-R') then COALESCE(pl.plan_id, 1)
         else COALESCE(pl.plan_id, 0) 
         end order by 1) rown
from  &schema_name..letter_definition ld
join minl minl on 1=1
left join &schema_name..letter_request lr on ld.lmdef_id = lr.lmdef_id 
     and lr.lmreq_id >= minl.minlmreq_id 
     and lr.lmreq_id >= 10764000
     and lr.mailed_date is not null
     AND LR.RETURN_DATE IS NOT NULL
left join &schema_name..letter_request_link lrl on lrl.lmreq_id = lr.lmreq_id
left join &schema_name..client_letter_data cld on (cld.client_letter_data_id = lrl.additional_reference_id and lrl.additional_reference_type = 'CLIENT_LETTER_DATA')
left join &schema_name..plans pl on pl.plan_id_ext = case when cld.medical_provider = '23876239' then '99999908' when cld.medical_provider ='7020368' then '99999901' else cld.medical_provider end
LEFT JOIN &schema_name..contract con on con.plan_id = pl.plan_id
left join MAXDAT_SUPPORT.EMRS_D_COEB_PROVIDER_SV PROV ON (CON.PLAN_sERVICE_TYPE_CD = 'ACC' AND prov.plan_id_ext = pl.plan_id_ext 
          and (
              (cld.medical_provider = prov.plan_id_ext and prov.provider_org_type = 'MCO' and ld.name in ('MGD-0480-R', 'MGD-1XXX-R', 'MGD-0500-R', 'MGD-0430-R','MGD-0520-R')) 
              or (cld.medical_provider = prov.plan_id_ext and prov.provider_org_type = 'PCMP' and prov.pcmp_svc_name = cld.pcmp_mco_name and prov.svc_phn_nbr = cld.pcmp_phone_number and ld.name in ('MGD-0470-R', 'MGD-0430-R','MGD-0520-R'))
              ))
where 1=1
) ret
where ret.rown = 1
GROUP BY trunc(ret.Return_Date,'MM'),
  ret.program_code,
  ret.PLAN_TYPE,
  ret.plan_service_type_cd,
  ret.plan_id ,
  ret.PROVIDER_ORG_TYPE,
  ret.PROVIDER_ORG_CD
)
UNION ALL
(
SELECT * FROM ALLM
)
) M                 
GROUP BY RECORD_DATE,
  M.PROGRAM_CODE,
  M.PLAN_TYPE,
  M.plan_Service_type_Cd,
  M.PLAN_ID,
  M.PROVIDER_ORG_TYPE,
  M.PROVIDER_ORG_CD
ORDER BY RECORD_DATE, PLAN_SERVICE_TYPE_CD; 

GRANT SELECT ON MAXDAT_SUPPORT.F_LETTERS_COUNT_SV TO MAXDAT_REPORTS;    


