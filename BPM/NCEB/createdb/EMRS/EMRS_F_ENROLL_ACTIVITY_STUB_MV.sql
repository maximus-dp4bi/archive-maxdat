drop materialized view EMRS_F_ENROLL_ACTIVITY_STUB_MV;
CREATE MATERIALIZED VIEW EMRS_F_ENROLL_ACTIVITY_STUB_MV
REFRESH FORCE ON DEMAND
AS
SELECT /*+ PARALLEL(10) */
--D.D_DATE AS RECORD_DATE
--, LAST_DAY(D.D_DATE) RECORD_MONTH
--, NULL RECORD_NAME
PRG.program_code
,PT.PLAN_TYPE
,'TRANSFER' ACTIVITY_TYPE
, CASE WHEN DSNT.DISENROLL_TYPE_CD = 'WITHCAUSE' THEN 'DISENROLLMENT_WITHCAUSE'
       WHEN DSNT.DISENROLL_TYPE_CD = 'WITHOUTCAUSE' THEN 'DISENROLLMENT_WITHOUTCAUSE'
       ELSE NULL END SUB_ACTIVITY_TYPE
,ACTIVITY_STATUS
,SELS.SELECTION_SOURCE_CODE
,PLN.PLAN_ID CURRENT_PLAN_ID
,PLNT.PLAN_ID PRIOR_PLAN_ID
,DSNR.REASON_CD
,DSNT.DISENROLL_TYPE_CD
,CTY.COUNTY_CODE
,CSD.CSDA_CODE
,MC.MANAGED_CARE_STATUS
,0 NEW_ENROLL_CNT
,0 TRANSFER_CNT
,0 DISENROLL_CNT
, DSNR.PHP_INITIATED PHP_DISENROLL_IND
,'N' PCP_SELECTED_IND
,CASE WHEN PLN.plan_code = 'FFS' THEN 'Y' ELSE 'N' END PLAN_FFS_IND
,CASE WHEN PLNT.plan_code = 'FFS' THEN 'Y' ELSE 'N' END TO_PLAN_FFS_IND
, DSNR.urgent URGENT_IND
,0 ACTIVITY_PROCESSING_CAL_DAYS_CNT
,PLN.PLAN_SERVICE_TYPE_CD CURRENT_PLAN_SERVICE_TYPE_CD
,PLNT.PLAN_SERVICE_TYPE_CD PRIOR_PLAN_SERVICE_TYPE_CD
FROM maxdat_support.emrs_d_PROGRAM_SV PRG --ON PRG.program_code = 'MEDICAID' AND 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_PLAN_TYPE_SV PT ON PT.PLAN_TYPE = 'MEDICAL' AND 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_ACTIVITY_STATUS_SV ACTS ON 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_SELECTION_SOURCE_SV SELS ON  SELS.SELECTION_SOURCE_CODE <> '0' AND 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_PLAN_SV PLN ON PLN.plan_id <> 0
JOIN MAXDAT_SUPPORT.EMRS_D_PLAN_SV PLNT ON PLNT.PLAN_ID <> 0
JOIN MAXDAT_SUPPORT.EMRS_D_DISENROLL_TYPE_SV DSNT ON 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_DISENROLL_REASON_SV DSNR ON DSNR.managed_care_program = PRG.program_code AND DSNR.DISENROLL_TYPE_CD = DSNT.DISENROLL_TYPE_CD AND 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_COUNTY_SV CTY ON CTY.COUNTY_CODE <> 0
JOIN MAXDAT_SUPPORT.EMRS_D_CARE_SERV_DELIV_AREA_SV CSD ON CSD.CSDA_CODE = CTY.CSDA_CODE AND 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_MANAGED_CARE_STATUS_SV MC ON (MC.MANAGED_CARE_STATUS = 'MCS001' OR MC.MANAGED_CARE_STATUS = 'MCS026') AND 1=1
--JOIN MAXDAT_SUPPORT.EMRS_D_PLAN_COUNTY_PROGRAM_SV PCP ON PCP.program_code = PRG.PROGRAM_CODE AND PCP.plan_type_cd = PT.PLAN_TYPE AND PCP.plan_id = PLN.PLAN_ID
WHERE 1=1
AND PRG.program_code = 'MEDICAID'
and (PLN.PLAN_ID IS NULL OR CTY.COUNTY_CODE IS NULL OR 
 (PRG.PROGRAM_CODE, PT.PLAN_TYPE, PLN.PLAN_ID, CTY.COUNTY_CODE) IN (
          SELECT PCP.PROGRAM_CODE, PCP.PLAN_TYPE_CD, PCP.PLAN_ID, PCP.COUNTY_CODE
          FROM EMRS_D_PLAN_COUNTY_PROGRAM_SV PCP
          )
)
and (PLNT.PLAN_ID IS NULL OR CTY.COUNTY_CODE IS NULL OR (PRG.PROGRAM_CODE, PT.PLAN_TYPE, PLNT.PLAN_ID, CTY.COUNTY_CODE) IN (
          SELECT PCP.PROGRAM_CODE, PCP.PLAN_TYPE_CD, PCP.PLAN_ID, PCP.COUNTY_CODE
          FROM EMRS_D_PLAN_COUNTY_PROGRAM_SV PCP
          )
)
--AND D.D_DATE >= GREATEST(TO_DATE('4/1/2019','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
--AND D.D_DATE <= TRUNC(SYSDATE+365)
--tablespace MAXDAT_TBS
;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENROLL_ACTIVITY_STUB_MV TO MAXDATSUPPORT_READ_ONLY;
--GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENROLL_ACTIVITY_STUB_MV TO MAXDAT_SUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENROLL_ACTIVITY_STUB_MV TO MAXDAT_REPORTS;
commit;


create index EMRS_F_ENROLL_ACTIVITY_STUB_MV_IDX1 on EMRS_F_ENROLL_ACTIVITY_STUB_MV(PROGRAM_CODE, PLAN_TYPE, ACTIVITY_TYPE, SUB_ACTIVITY_TYPE, ACTIVITY_STATUS, SELECTION_SOURCE_CODE, CURRENT_PLAN_ID, PRIOR_PLAN_ID, DISENROLL_TYPE_CD, MANAGED_CARE_STATUS, CSDA_CODE, COUNTY_CODE) tablespace MAXDAT_TBS ;
create index EMRS_F_ENROLL_ACTIVITY_STUB_MV_IDX2 on EMRS_F_ENROLL_ACTIVITY_STUB_MV(PROGRAM_CODE, PLAN_TYPE, ACTIVITY_TYPE, SUB_ACTIVITY_TYPE,CSDA_CODE, COUNTY_CODE, MANAGED_CARE_STATUS) parallel 10;
create index EMRS_F_ENROLL_ACTIVITY_STUB_MV_IDX3 on EMRS_F_ENROLL_ACTIVITY_STUB_MV(PROGRAM_CODE, PLAN_TYPE, ACTIVITY_TYPE, SUB_ACTIVITY_TYPE,CSDA_CODE, COUNTY_CODE, SELECTION_SOURCE_CODE) tablespace maxdat_tbs parallel 10;
create index EMRS_F_ENROLL_ACTIVITY_STUB_MV_IDX5 on EMRS_F_ENROLL_ACTIVITY_STUB_MV(PROGRAM_CODE, PLAN_TYPE, ACTIVITY_TYPE, SUB_ACTIVITY_TYPE,SELECTION_SOURCE_CODE) parallel 10;
create index EMRS_F_ENROLL_ACTIVITY_STUB_MV_IDX6 on EMRS_F_ENROLL_ACTIVITY_STUB_MV(PROGRAM_CODE, PLAN_TYPE, ACTIVITY_TYPE, SUB_ACTIVITY_TYPE,MANAGED_CARE_STATUS) parallel 10;
create index EMRS_F_ENROLL_ACTIVITY_STUB_MV_IDX7 on EMRS_F_ENROLL_ACTIVITY_STUB_MV(PROGRAM_CODE, PLAN_TYPE, ACTIVITY_TYPE, SUB_ACTIVITY_TYPE,PRIOR_PLAN_ID) parallel 10;

