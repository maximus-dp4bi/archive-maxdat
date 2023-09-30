DROP VIEW MAXDAT_SUPPORT.EMRS_D_CLIENT_ELIGIBILITY_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_CLIENT_ELIGIBILITY_SV
AS
SELECT CSI.CLIENT_CIN Medicaid_ID,
         CSI.LAST_NAME  LAST_NAME,
         CSI.FIRST_NAME FIRST_NAME,
         'LTC'          SEGMENT_TYPE_CD,
         esad1.start_date LTC_START_DATE
    FROM CLIENT_ELIG_STATUS ces
         INNER JOIN CLIENT_SUPPLEMENTARY_INFO csi
             ON ces.client_id = CSI.CLIENT_ID
         INNER JOIN elig_segment_and_details esad1
             ON     esad1.client_id = ces.client_id
                AND esad1.segment_type_cd = 'LTC'
                AND esad1.start_nd < TO_CHAR (SYSDATE - 30, 'YYYYMMDD')
                AND esad1.end_nd > TO_CHAR (LAST_DAY (SYSDATE), 'YYYYMMDD')
   WHERE     CES.ELIG_STATUS_CD IN ('M', 'V')
         AND CES.END_DATE IS NULL
         --AND ces.SUBPROGRAM_TYPE = 'BH_ONLY'
         AND CES.MVX_CORE_REASON LIKE 'X29%'
         AND EXISTS
                 (SELECT 1
                    FROM elig_segment_and_details esad2
                   WHERE     esad2.client_id = ces.client_id
                         AND esad2.segment_type_cd = 'MI'
                         AND esad2.end_nd = 20201231
                         AND esad2.SEGMENT_DETAIL_VALUE_1 = 'B')
         AND EXISTS
                 (SELECT 1
                    FROM ELIG_SEGMENT_AND_DETAILS esad
                   WHERE     esad.client_id = ces.client_id
                         AND ESAD.SEGMENT_TYPE_CD = 'ME'
                         AND ESAD.END_ND >
                                 TO_CHAR (LAST_DAY (SYSDATE), 'YYYYMMDD')
                         AND    ESAD.SEGMENT_DETAIL_VALUE_1
                             || '-'
                             || ESAD.SEGMENT_DETAIL_VALUE_2 IN
                                 (SELECT AID_Category || '-' || TYPE_CASE
                                    FROM MVX_XWALK
                                   WHERE     ACUTE_MVX IN ('M', 'V - Opt-In')
                                         AND EFFECTIVE_END_DATE IS NULL))
ORDER BY 1;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_ELIGIBILITY_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_ELIGIBILITY_SV TO MAXDAT_SUPPORT_READ_ONLY;
