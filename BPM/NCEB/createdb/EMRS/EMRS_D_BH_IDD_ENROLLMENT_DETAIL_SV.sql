--PAXTECH-2355
DROP VIEW MAXDAT_SUPPORT.EMRS_D_BH_IDD_ENROLLMENT_DTL_SV;
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_BH_IDD_ENROLLMENT_DTL_SV" ("ENROLLMENT_DATE", "CLIENT_ID", "CNDS_ID", "NAME", "DOB", "PLAN_NAME", "MANAGED_CARE_STATUS", "MANAGED_CARE_LABEL", "HEALTH_PLAN_SELECTION_DATE") AS 
WITH autoasgn AS (
                SELECT ss.status_date
                , ss.selection_segment_id 
                FROM EB.selection_segment ss
                LEFT JOIN eb.selection_txn st ON ss.SELECTION_SEGMENT_ID = st.SELECTION_SEGMENT_ID
                WHERE st.SELECTION_TXN_ID IS null
), xfrnew AS (
                SELECT ST.status_date 
                , st.SELECTION_segment_ID
                FROM EB.selection_segment ss
                JOIN eb.selection_txn st ON ss.SELECTION_SEGMENT_ID = st.SELECTION_SEGMENT_ID
                WHERE st.transaction_type_cd IN ('NewEnrollment','Transfer')
                AND st.STATUS_CD = 'acceptedByState'
), other AS (
                SELECT max(STH.create_ts) status_date
                , ss.selection_segment_id 
                FROM EB.selection_segment ss
                JOIN eb.selection_txn st ON ss.SELECTION_SEGMENT_ID = st.SELECTION_SEGMENT_ID
                JOIN eb.selection_txn_status_history sth ON st.SELECTION_TXN_ID = sth.SELECTION_TXN_ID
                WHERE st.transaction_type_cd IN ('NewEnrollment','Transfer')
                AND st.STATUS_CD != 'acceptedByState'
                AND sth.STATUS_CD = 'acceptedByState'
                GROUP BY ss.selection_segment_id
)
SELECT ss.start_DATE  -- this is Matt's query
      ,ss.CLIENT_ID
      ,csi.CLIENT_CIN CNDS_ID
      ,csi.first_name ||' '|| csi.last_name NAME
      ,csi.dob
      ,pl.plan_name
      ,esd.SEGMENT_DETAIL_VALUE_2 MANAGED_CARE_STATUS
      ,mcs.MANAGED_CARE_LABEL
      ,CASE WHEN autoasgn.status_date IS NOT NULL THEN autoasgn.status_date
            WHEN xfrnew.status_date IS NOT NULL THEN xfrnew.status_date
            WHEN OTHER.status_date IS NOT NULL THEN OTHER.status_date
            ELSE NULL
       END  Health_Plan_Selection_Date     
   FROM EB.SELECTION_SEGMENT ss
   JOIN EB.CLIENT_SUPPLEMENTARY_INFO csi ON csi.CLIENT_ID = ss.CLIENT_ID
   JOIN EB.PLANS pl ON pl.PLAN_ID = ss.PLAN_ID
   JOIN eb.ELIG_SEGMENT_AND_DETAILS esd ON ss.CLIENT_ID = esd.CLIENT_ID AND esd.SEGMENT_DETAIL_VALUE_2 IN ('MCS005', 'MCS027', 'MCS035')  
   JOIN maxdat_support.emrs_d_managed_care_status_sv mcs on mcs.managed_care_status = esd.SEGMENT_DETAIL_VALUE_2
   LEFT JOIN autoasgn ON autoasgn.selection_segment_id = ss.selection_segment_id
   LEFT JOIN xfrnew ON xfrnew.selection_segment_id = ss.selection_segment_id
   LEFT JOIN other ON other.selection_segment_id = ss.selection_segment_id 
WHERE ((SYSDATE < to_date('07/01/2021','mm/dd/yyyy') AND ss.START_DATE = to_date('07/01/2021','mm/dd/yyyy'))
   OR (SYSDATE >= to_date('07/01/2021 12:00:00','mm/dd/yyyy hh24:mi:ss') AND ss.START_DATE <= add_months(TRUNC(SYSDATE,'MM'),1)))
--   AND ss.plan_id <> 601
   AND ss.SS_GENERIC_FIELD3_NUM IS NULL -- exclude Bene 834 records
GROUP BY ss.start_DATE, ss.CLIENT_ID, csi.CLIENT_CIN, csi.first_name,csi.Last_name,csi.dob,pl.plan_name, esd.SEGMENT_DETAIL_VALUE_2, MANAGED_CARE_LABEL
      ,CASE WHEN autoasgn.status_date IS NOT NULL THEN autoasgn.status_date
            WHEN xfrnew.status_date IS NOT NULL THEN xfrnew.status_date
            WHEN OTHER.status_date IS NOT NULL THEN OTHER.status_date
            ELSE NULL
       END 
order by ss.start_date, csi.client_cin
;
/
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_BH_IDD_ENROLLMENT_DTL_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_BH_IDD_ENROLLMENT_DTL_SV TO MAXDAT_SUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_BH_IDD_ENROLLMENT_DTL_SV TO MAXDAT_REPORTS;
