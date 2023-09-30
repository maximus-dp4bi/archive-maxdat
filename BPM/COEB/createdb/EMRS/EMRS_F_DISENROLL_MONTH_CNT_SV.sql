CREATE OR REPLACE VIEW EMRS_F_DISENRL_MONTH_CNT_SV
 AS
  SELECT D.D_MONTH_START RECORD_DATE,
  f.PROGRAM_CODE,
  f.PLAN_TYPE,
  f.plan_Service_type_Cd,
  f.PLAN_ID,
  F.PROVIDER_ORG_TYPE,
  f.provider_org_CD,
  coalease(f.disenroll_reason_cd1, f.disenroll_reason_Cd2) disenroll_reason_cd
  , COUNT(distinct f.enrollment_id) AS disenrollment_count
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
  , ROW_NUMBER() OVER (PARTITION BY SS.SELECTION_SEGMENT_ID ORDER BY STH.CREATE_TS DESC) ROWN
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
  JOIN &schema_name..SELECTION_TXN ST ON (ST.PRIOR_SELECTION_SEGMENT_ID = SS.SELECTION_SEGMENT_ID 
                           AND ST.PRIOR_PLAN_ID = SS.PLAN_ID
                           AND ST.PROGRAM_TYPE_CD = SS.PROGRAM_TYPE_CD
                           AND ST.PLAN_TYPE_CD = SS.PLAN_TYPE_CD)
  JOIN &schema_name..SELECTION_TXN_STATUS_HISTORY STH ON STH.SELECTION_TXN_ID = ST.SELECTION_TXN_ID                                                
  where 1=1
  AND STH.STATUS_CD = 'acceptedByState'
  and ss.status_cd = 'OPEN'
  and ss.start_nd < ss.end_nd
--  and ss.end_date = to_date('8/31/2018','mm/dd/yyyy')
--  and con.plan_Service_type_cd = 'ACC'
  ) f ON (d.D_MONTH_END BETWEEN GREATEST(ADD_MONTHS(TRUNC(sysdate, 'mm'),-24),TO_DATE('6/1/2018','MM/DD/YYYY')) AND TRUNC(LAST_DAY(sysdate))
          AND d.D_MONTH_END = f.MANAGED_CARE_END_DATE --AND F.MANAGED_CARE_END_DATE
          ) 
WHERE 1=1
  and ((F.plan_service_type_cd = 'ACC' and F.provider_id_ext is not null) or (F.plan_service_type_cd <> 'ACC'))
GROUP BY d.d_month_start,
  f.PROGRAM_CODE,
  f.PLAN_TYPE,
  f.plan_Service_type_Cd,
  f.PLAN_ID,
  F.PROVIDER_ORG_TYPE,
  F.PROVIDER_ORG_CD
ORDER BY RECORD_DATE, PLAN_SERVICE_TYPE_CD; 

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_DISENRL_MONTH_CNT_SV TO MAXDAT_REPORTS;    


