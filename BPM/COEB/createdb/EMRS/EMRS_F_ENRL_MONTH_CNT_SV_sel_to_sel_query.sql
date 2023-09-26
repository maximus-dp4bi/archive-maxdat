CREATE OR REPLACE VIEW EMRS_F_ENRL_MONTH_CNT_SV
 AS
SELECT 
  RECORD_DATE,
  M.PROGRAM_CODE,
  M.PLAN_TYPE,
  M.plan_Service_type_Cd,
  M.PLAN_ID,
  M.PROVIDER_ORG_TYPE,
  M.provider_org_CD
  , SUM(M.ENROLLMENT_COUNT) ENROLLMENT_COUNT
  , SUM(M.ENROLL_CLIENT_count) ENROLL_CLIENT_COUNT
  , SUM(M.ACC_PROVIDER_CHG_CNT) ACC_PROVIDER_CHG_CNT
  , SUM(M.ACC_PROV_RAE_CHG_CNT) ACC_PROV_RAE_CHG_CNT
  , SUM(M.CHP_PLAN_CHG_CNT) CHP_PLAN_CHG_CNT
  , SUM(M.NEW_CLIENT_CNT) NEW_CLIENT_CNT
  , SUM(WEB_ENROLL_CNT) WEB_ENROLL_CNT
  , SUM(PH_ENROLL_CNT) PH_ENROLL_CNT
  , SUM(MCO_OPTOUT_CNT) MCO_OPTOUT_CNT
 FROM
(
  SELECT D.D_MONTH_START RECORD_DATE,
  f.PROGRAM_CODE,
  f.PLAN_TYPE,
  f.plan_Service_type_Cd,
  f.PLAN_ID,
  F.PROVIDER_ORG_TYPE,
  f.provider_org_CD,
  COUNT(distinct f.enrollment_id) AS enrollment_count
  , COUNT(distinct f.CLIENT_id) AS ENROLL_CLIENT_count
--  , sum(case when f.managed_care_end_date = D.D_MONTH_end then 1 else 0 end) end_count
  , sum(case when F.plan_service_type_cd = 'ACC'
                  and f.next_provider_id_ext is not null
                  and f.managed_care_end_date = D.D_MONTH_end 
                  and F.plan_service_type_cd = next_ps_type_cd 
                  and F.provider_id_ext is not null
                  and F.provider_id_ext <> next_provider_id_ext then 1 else 0 end) ACC_PROVIDER_CHG_CNT
  , sum(case when F.plan_service_type_cd = 'ACC'
                  and f.next_provider_id_ext is not null
                  and f.managed_care_end_date = D.D_MONTH_end 
                  and F.plan_service_type_cd = next_ps_type_cd 
                  and F.provider_id_ext <> next_provider_id_ext 
                  and F.next_selection_plan_id_ext <> next_provider_plan_id_ext then 1 else 0 end) ACC_PROV_RAE_CHG_CNT
  , sum(case when F.plan_service_type_cd = 'CHP'
                  and f.next_selection_plan_id_ext is not null
                  and f.managed_care_end_date = D.D_MONTH_end 
                  and F.plan_service_type_cd = next_ps_type_cd 
                  and F.plan_id_ext <> next_selection_plan_id_ext then 1 else 0 end) CHP_PLAN_CHG_CNT
  , 0 NEW_CLIENT_CNT                  
  , 0 WEB_ENROLL_CNT
  , 0 PH_ENROLL_CNT
  , 0 MCO_OPTOUT_CNT
FROM MAXDAT_SUPPORT.D_MONTHS d
JOIN
  (
  SELECT ss.selection_segment_id enrollment_id
  , ss.client_id
  , COALESCE(ss.program_type_cd, '0') program_code
  , COALESCE(ss.county_cd,'0') county_code
  , COALESCE(ss.plan_id, 0) plan_id
  , ss.plan_id_ext
  , COALESCE(ss.plan_type_cd,'0') plan_type
  , ss.start_date managed_care_start_date
  , ss.end_date managed_care_end_date 
  , con.plan_Service_type_cd
  , ss.provider_id_ext
  , prov.PROVIDER_CODE
  , PROV.PROVIDER_ORG_TYPE
  , PROV.PROVIDER_ORG_CD
  , SEL_NEXT.PLAN_ID NEXT_SELECTION_PLAN_ID
  , sel_next.plan_id_ext next_selection_plan_id_ext
  , CON_NEXT.PLAN_sERVICE_TYPE_CD NEXT_PS_TYPE_CD
  , SEL_NEXT.PROVIDER_ID_EXT NEXT_PROVIDER_ID_EXT
  , PROV_NEXT.PLAN_ID_ext NEXT_PROVIDER_PLAN_ID_ext
  FROM &schema_name..selection_segment ss
  join &schema_name..contract con on con.plan_id = ss.plan_id
  LEFT JOIN MAXDAT_SUPPORT.EMRS_D_COEB_PROVIDER_SV PROV ON (CON.PLAN_sERVICE_TYPE_CD = 'ACC' AND 
                                         PROV.PLAN_ID_ext = SS.PLAN_ID_ext AND PROV.PROVIDER_CODE = SS.PROVIDER_ID_EXT)
  left join &schema_name..selection_segment sel_next on sel_next.client_id = ss.client_id 
                                          and sel_NEXT.plan_type_cd = 'MEDICAL'
                                          and SEL_NEXT.START_DATE = SS.END_DATE + 1
                                          AND SEL_NEXT.STATUS_CD = 'OPEN'
  LEFT JOIN &schema_name..CONTRACT CON_NEXT ON CON_NEXT.PLAN_ID = SEL_NEXT.PLAN_ID 
  LEFT JOIN EMRS_D_COEB_PROVIDER_SV PROV_NEXT ON (CON_NEXT.PLAN_sERVICE_TYPE_CD = 'ACC' and PROV_NEXT.PROVIDER_CODE = SEL_NEXT.PROVIDER_ID_EXT)
  where 1=1
  and ss.status_cd = 'OPEN'
  and ss.start_nd < ss.end_nd
--  and ss.end_date = to_date('8/31/2018','mm/dd/yyyy')
--  and con.plan_Service_type_cd = 'ACC'
  ) f ON (d.D_MONTH_END BETWEEN GREATEST(ADD_MONTHS(TRUNC(sysdate, 'mm'),-24),TO_DATE('6/1/2018','MM/DD/YYYY')) AND TRUNC(LAST_DAY(sysdate))
          AND d.D_MONTH_END BETWEEN f.MANAGED_CARE_START_DATE AND COALESCE(f.MANAGED_CARE_END_DATE, TO_DATE('12-Dec-2050', 'dd-Mon-yyyy'))) 
WHERE 1=1
  and ((F.plan_service_type_cd = 'ACC' and F.provider_id_ext is not null) or (F.plan_service_type_cd <> 'ACC'))
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
  RECORD_DATE,   
  CLNT.PROGRAM_CODE,
  CLNT.PLAN_TYPE,
  CLNT.plan_Service_type_Cd,
  CLNT.PLAN_ID,
  CLNT.PROVIDER_ORG_TYPE,
  CLNT.provider_org_CD,
  0 enrollment_count
  , 0 ENROLL_CLIENT_count
  , 0 ACC_PROVIDER_CHG_CNT
  , 0 ACC_PROV_RAE_CHG_CNT
  , 0 CHP_PLAN_CHG_CNT
  , NEW_CLIENT_CNT 
  , 0 WEB_ENROLL_CNT
  , 0 PH_ENROLL_CNT
  , 0 MCO_OPTOUT_CNT
  FROM MAXDAT_SUPPORT.EMRS_D_CLIENT_PLAN_SV CLNT 
)
UNION ALL
(
SELECT
  TRUNC(RECORD_DATE,'MM') RECORD_DATE,   
  'MEDICAID' PROGRAM_CODE,
  'MEDICAL' PLAN_TYPE,
  ACT.plan_Service_type_Cd,
  ACT.PLAN_ID,
  ACT.PROVIDER_ORG_TYPE,
  ACT.provider_org_CD,
  0 enrollment_count
  , 0 ENROLL_CLIENT_count
  , 0 ACC_PROVIDER_CHG_CNT
  , 0 ACC_PROV_RAE_CHG_CNT
  , 0 CHP_PLAN_CHG_CNT
  , 0 NEW_CLIENT_CNT 
  , SUM(WEB_ENROLL) WEB_ENROLL_CNT
  , SUM(PH_ENROLL) PH_ENROLL_CNT
  , SUM(MCO_OPTOUT) MCO_OPTOUT_CNT
  FROM MAXDAT_SUPPORT.EMRS_F_ENROLL_ACTIVITY_SV ACT
  GROUP BY TRUNC(RECORD_DATE,'MM'),
  ACT.plan_Service_type_Cd,
  ACT.PLAN_ID,
  ACT.PROVIDER_ORG_TYPE,
  ACT.provider_org_CD
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

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENRL_MONTH_CNT_SV TO MAXDAT_REPORTS;    


