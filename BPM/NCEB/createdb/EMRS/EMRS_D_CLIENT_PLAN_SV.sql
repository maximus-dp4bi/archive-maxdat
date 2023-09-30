CREATE OR REPLACE VIEW EMRS_D_CLIENT_PLAN_SV AS
SELECT 
   RECORD_DATE
  , PROGRAM_TYPE_CD PROGRAM_CODE
  , PLAN_TYPE_CD PLAN_TYPE
  , PLAN_SERVICE_TYPE_CD
  , PLAN_ID
  , PROVIDER_ORG_TYPE
  , PROVIDER_ORG_CD
  , COUNT(DISTINCT CLNT_CLIENT_ID) NEW_CLIENT_CNT
FROM (
SELECT 
CLNT.CLNT_CLIENT_ID
, CON.PLAN_SERVICE_TYPE_CD
, SLCT.PROGRAM_TYPE_CD
, SLCT.PLAN_TYPE_CD
, SLCT.PLAN_ID
, SLCT.PROVIDER_ID_EXT
, CASE WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IN ('07020368','23876239') THEN 'MCO' 
       WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT NOT IN ('07020368','23876239') THEN 'PCMP' 
       WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IS NULL THEN 'PCMP' 
       ELSE NULL END PROVIDER_ORG_TYPE
, CASE WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IN ('07020368','23876239') THEN PROVIDER_ID_EXT 
       WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT NOT IN ('07020368','23876239') THEN 'PCMP' 
       WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IS NULL THEN 'PCMP' 
       ELSE NULL END PROVIDER_ORG_CD
, TRUNC(CLNT.CREATION_DATE,'MM') RECORD_DATE
, ROW_NUMBER() OVER(PARTITION BY CLNT.CLNT_CLIENT_ID ORDER BY SLCT.START_ND DESC) ROWN
FROM &schema_name..CLIENT CLNT
LEFT JOIN &schema_name..SELECTION_SEGMENT SLCT ON SLCT.CLIENT_ID = CLNT.CLNT_CLIENT_ID
LEFT JOIN &schema_name..CONTRACT CON ON CON.PLAN_ID = SLCT.PLAN_ID
WHERE 1=1
AND CON.END_DATE IS NULL
AND SLCT.START_ND < SLCT.END_ND
AND SLCT.PROGRAM_TYPE_CD = 'MEDICAID'
AND SLCT.PLAN_TYPE_CD = 'MEDICAL'
AND SLCT.STATUS_CD = 'OPEN'
AND CLNT.CREATION_DATE >= GREATEST(ADD_MONTHS(TRUNC(SYSDATE,'MM'),-13),TO_DATE('8/1/2018','MM/DD/YYYY'))
)
GROUP BY   RECORD_DATE
  , PROGRAM_TYPE_CD 
  , PLAN_TYPE_CD 
  , PLAN_SERVICE_TYPE_CD
  , PLAN_ID
  , PROVIDER_ORG_TYPE
  , PROVIDER_ORG_CD
--WHERE PLAN_SERVICE_TYPE_CD = 'ACC'
--AND TRUNC(CREATION_DATE) >= P_START_MONTH
--AND TRUNC(CREATION_DATE) >= P_END_MONTH
;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_PLAN_SV TO MAXDAT_REPORTS;

    
