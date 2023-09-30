DROP VIEW MAXDAT_SUPPORT.EMRS_D_CLIENT_CCM_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_CLIENT_CCM_SV
AS
SELECT   temp.Medicaid_ID Medicaid_Member_Id,
         to_date(temp.ccm_begin_date,'YYYYMMDD') CCM_Begin_Date,
         to_date(temp.ccm_end_date,'YYYYMMDD') CCM_End_Date,
         esad.start_date Linkage_Start_Date,
         esad.end_date Linkage_End_Date,
         esad.segment_detail_value_1 Linkage_Type,
        CASE WHEN esad2.SEGMENT_DETAIL_VALUE_1 IS NOT NULL
             OR esad2.SEGMENT_DETAIL_VALUE_2 IS NOT NULL
             THEN esad2.SEGMENT_DETAIL_VALUE_1 || '/' || esad2.SEGMENT_DETAIL_VALUE_2
             ELSE NULL END AS FUTURE_AC_TC,
        CASE WHEN esad2.start_date > SYSDATE
             THEN esad2.start_date
             ELSE NULL END AS FUTURE_START_DATE,
esad.SEGMENT_DETAIL_VALUE_1 || '/' || esad.SEGMENT_DETAIL_VALUE_2 AS "CURRENT_AC_TC",
esad.SEGMENT_DETAIL_VALUE_2
FROM elig_segment_and_details esad
INNER JOIN (SELECT DISTINCT
                 esad1.client_id Maximus_Client_id,
                 cl.clnt_cin Medicaid_ID,
                 TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 271, 8), '0')) CCM_Begin_Date,
                 TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 279, 8), '0')) CCM_End_Date
           FROM ELIG_SEGMENT_AND_DETAILS esad1
           INNER JOIN client cl ON (cl.clnt_client_id = esad1.client_id)
           WHERE TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 279, 8), '0')) >= (SELECT TO_CHAR ( TRUNC (TRUNC (SYSDATE, 'MM') - 1, 'MM'), 'YYYYMMDD') FROM DUAL)
           AND   TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 271, 8), '0')) <= (SELECT TO_CHAR (TRUNC (SYSDATE, 'MM') - 1, 'YYYYMMDD') FROM DUAL)
           AND esad1.segment_type_cd = 'MI'
           AND esad1.start_nd <= (SELECT TO_CHAR (TRUNC (TRUNC (SYSDATE, 'MM') - 1, 'MM'), 'YYYYMMDD')  FROM DUAL)
           AND esad1.end_nd >= (SELECT TO_CHAR (TRUNC (SYSDATE, 'MM') - 1, 'YYYYMMDD')  FROM DUAL)
          ) temp
            ON temp.maximus_client_id = esad.client_id
     LEFT JOIN elig_segment_and_details esad2
        ON esad2.segment_type_cd = 'ME'
       AND esad2.client_id = esad.client_id
       AND esad2.start_date > SYSDATE
       AND esad2.end_date > esad2.start_date
       AND esad2.SEGMENT_DETAIL_VALUE_1 || '/'  || esad2.SEGMENT_DETAIL_VALUE_2 NOT IN  ('17/095')
   WHERE
           esad.segment_type_cd = 'MI'
           -- AND esad.transaction_type_cd IN ('Transfer', 'NewEnrollment', 'DefaultEnroll')
           AND esad.start_nd <= (SELECT TO_CHAR (TRUNC (TRUNC (SYSDATE, 'MM') - 1, 'MM'), 'YYYYMMDD')  FROM DUAL)
           AND esad.end_nd >= (SELECT TO_CHAR (TRUNC (SYSDATE, 'MM') - 1, 'YYYYMMDD')  FROM DUAL)
           AND (
              (esad.start_nd BETWEEN temp.CCM_Begin_Date AND temp.CCM_End_Date)
              OR (esad.end_nd BETWEEN temp.CCM_Begin_Date AND temp.CCM_End_Date)
              OR (esad.start_nd <= temp.CCM_Begin_Date AND esad.end_nd >= temp.CCM_End_Date)
            )
ORDER BY 1;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_CCM_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_CCM_SV TO MAXDAT_SUPPORT_READ_ONLY;
