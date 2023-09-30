drop view EMRS_F_DISENROLL_TIMING_SV;
CREATE OR REPLACE VIEW EMRS_F_DISENROLL_TIMING_SV AS (
SELECT --/*+ PARALLEL(10) */
ACT.RECORD_DATE
, ACT.RECORD_MONTH
, ACT.PROGRAM_CODE
, ACT.ACTIVITY_TYPE
, ACT.ACTIVITY_STATUS
, CASE WHEN ACT.SCAN_DATE IS NULL AND ACT.SELECTION_SOURCE_CD = 'C' THEN 'P' ELSE ACT.SELECTION_SOURCE_CD END SELECTION_SOURCE_CD
, ACT.PCP_SELECTED_IND
, ACT.PHP_DISENROLL_IND
, ACT.MANAGED_CARE_STATUS
, ACT.Disenroll_Reason
, ACT.Sub_Activity_type
, sum(ACT.TRANSFER_IND)  TRANSFER_CNT
, sum(ACT.DISENROLL_IND)  DISENROLL_CNT
, sum(ACT.ACTIVITY_IND)  ACTIVITY_CNT
, count(act.selection_txn_id)  count_txns
, CASE WHEN round((sum(ACT.ACTIVITY_PROCESSING_CAL_DAYS) * 1440*60)) < 0 THEN 0 ELSE round((sum(ACT.ACTIVITY_PROCESSING_CAL_DAYS) * 1440*60)) end Total_secs
, CASE WHEN round((sum(ACT.ACTIVITY_PROCESSING_CAL_DAYS) * 1440*60)/count(act.selection_txn_id),1) < 0 THEN 0 ELSE round((sum(ACT.ACTIVITY_PROCESSING_CAL_DAYS) * 1440*60)/count(act.selection_txn_id),1) END avg_secs
, CASE WHEN round(sum(ACT.ACTIVITY_PROCESSING_CAL_DAYS)) < 0 THEN 0 ELSE round(sum(ACT.ACTIVITY_PROCESSING_CAL_DAYS)) END Total_days
, CASE WHEN round(sum(ACT.ACTIVITY_PROCESSING_CAL_DAYS)/count(act.selection_txn_id) ,1) < 0 THEN 0 ELSE round(sum(ACT.ACTIVITY_PROCESSING_CAL_DAYS)/count(act.selection_txn_id) ,1) END Avg_days
FROM 
(
SELECT 
      CASE WHEN sha.acceptcd = 'acceptedByState' THEN trunc(coalesce(sha.acceptdate, st.STATUS_DATE, ss.STATUS_DATE))
           WHEN shd.deniedcd = 'denied' THEN TRUNC(COALESCE(shd.denieddate,st.STATUS_DATE, ss.STATUS_DATE))
     ELSE trunc(st.CREATE_TS)
     END RECORD_DATE
, LAST_DAY(CASE WHEN sha.acceptcd = 'acceptedByState' THEN trunc(coalesce(sha.acceptdate, st.STATUS_DATE, ss.STATUS_DATE))
           WHEN shd.deniedcd = 'denied' THEN TRUNC(COALESCE(shd.denieddate,st.STATUS_DATE, ss.STATUS_DATE))
     ELSE trunc(st.CREATE_TS)
	 END) RECORD_MONTH
, COALESCE(st.PROGRAM_TYPE_CD, '0') PROGRAM_CODE
, case when COALESCE(st.TRANSACTION_TYPE_CD, 'NotDefined') = 'NewEnrollment' then 'ENROLLMENT'
      WHEN COALESCE(st.TRANSACTION_TYPE_CD, 'NotDefined') = 'Transfer' THEN 'TRANSFER'
      WHEN COALESCE(st.TRANSACTION_TYPE_CD, 'NotDefined') = 'Disenrollment' and COALESCE(st.DISENROLL_REASON_CD_1, '0') = 'NFPHPCR13' then 'TRANSFER'
      WHEN COALESCE(st.TRANSACTION_TYPE_CD, 'NotDefined') = 'Disenrollment' then 'DISENROLLMENT'
      ELSE NULL END ACTIVITY_TYPE
, CASE WHEN st.STATUS_CD IN 'acceptedByState' then 'APPROVED'
     WHEN st.STATUS_CD IN ('denied','invalid') THEN 'DENIED'
     WHEN st.STATUS_CD IN ('readyToUpload') Then 'ReadyToUpload'
	 When st.STATUS_CD in ('uploadedToState','pendToRecycle') then 'INPROCESS'
     ELSE st.STATUS_CD
     END ACTIVITY_STATUS
, COALESCE(st.Selection_Generic_Field5_Txt, elig.segment_detail_value_2) MANAGED_CARE_STATUS
, CASE WHEN COALESCE(st.TRANSACTION_TYPE_CD, 'NotDefined') = 'Transfer' or (COALESCE(st.TRANSACTION_TYPE_CD, 'NotDefined') = 'Disenrollment' and COALESCE(st.DISENROLL_REASON_CD_1, '0') = 'NFPHPCR13') THEN 1 ELSE 0 END TRANSFER_IND
, CASE WHEN COALESCE(st.TRANSACTION_TYPE_CD, 'NotDefined') = 'Disenrollment' and COALESCE(st.DISENROLL_REASON_CD_1, '0') <> 'NFPHPCR13' THEN 1 ELSE 0 END DISENROLL_IND
, DSNR.PHP_INITIATED PHP_DISENROLL_IND
, CASE WHEN COALESCE(st.TRANSACTION_TYPE_CD, 'NotDefined') in ('NewEnrollment', 'Transfer') and NVL(st.PROVIDER_ID, st.PROVIDER_ID_EXT) IS NOT NULL THEN 'Y' ELSE 'N' END PCP_SELECTED_IND
, COALESCE(st.SELECTION_SOURCE_CD, '0') SELECTION_SOURCE_CD
, case WHEN st.STATUS_CD in 'acceptedByState' 
	then 1 else 0 end ACTIVITY_IND
, CASE WHEN sha.acceptdate IS NOT NULL AND doc.scan_date is NOT NULL
        AND COALESCE(st.SELECTION_SOURCE_CD, '0') = 'C' 
		and st.STATUS_CD in 'acceptedByState' 
		and dl.DOCUMENT_ID is not null 
		and st.UPDATED_BY = '-415' 
	   then sha.acceptdate - doc.scan_date -- This may not be correct may need to be st.create_ts - docs.received_date
       WHEN sha.acceptdate IS NOT NULL AND doc.scan_date is NOT NULL
        AND COALESCE(st.SELECTION_SOURCE_CD, '0') = 'C' 
        and st.STATUS_CD in 'acceptedByState' 
		and dl.DOCUMENT_ID is not null 
       then sha.acceptdate - doc.scan_date 
       WHEN sha.acceptdate IS NOT NULL AND shr.readydate IS NOT NULL 
       AND DSNT.DISENROLL_TYPE_CD in ('WITHOUTCAUSE','WITHCAUSE') 
       THEN sha.acceptdate - shr.readydate 
       else 0 END  ACTIVITY_PROCESSING_CAL_DAYS
, st.disenroll_reason_cd_1 Disenroll_Reason
, case when DSNT.DISENROLL_TYPE_CD = 'WITHCAUSE' then 'DISENROLLMENT_WITHCAUSE' else 'DISENROLLMENT_WITHOUTCAUSE' end Sub_Activity_type
, doc.scan_date
, st.selection_txn_id
FROM eb.selection_txn st 
LEFT JOIN (SELECT MAX(sh.create_ts) acceptdate, 'acceptedByState' acceptcd, selection_txn_id FROM eb.selection_txn_status_history sh 
           WHERE sh.status_cd = 'acceptedByState' GROUP BY selection_txn_id) SHA ON sha.selection_txn_id = st.selection_txn_id
LEFT JOIN (SELECT MAX(sh.create_ts) denieddate, 'denied' deniedcd, selection_txn_id FROM eb.selection_txn_status_history sh
      	   WHERE sh.status_cd in ('denied','invalid') GROUP BY selection_txn_id) shd ON shd.selection_txn_id = st.selection_txn_id
LEFT JOIN (SELECT MAX(sh.create_ts) readydate, 'readyToUpload' readycd, selection_txn_id FROM eb.selection_txn_status_history sh
		   WHERE sh.status_cd = 'readyToUpload' GROUP BY selection_txn_id) shr ON shr.selection_txn_id = st.selection_txn_id
left JOIN eb.selection_segment ss on (st.client_id = ss.client_id and st.selection_segment_id = ss.selection_segment_id)
left join eb.elig_segment_and_details elig on (elig.segment_type_cd = 'ME'
                                                 and elig.client_id = st.client_id
                                                 and elig.start_nd <= nvl(st.start_nd, to_number(to_char(st.status_date,'YYYYMMDD')))
                                                 and elig.end_nd >= nvl(st.start_nd, to_number(to_char(st.status_date,'YYYYMMDD')))
                                               )
LEFT JOIN eb.doc_link dl on (dl.link_type_cd = 'SELECTION_TXN' and dl.link_ref_id = st.selection_txn_id)
left join eb.document doc on doc.document_id = dl.document_id
left join eb.document_set docs on docs.document_set_id = doc.document_set_id
LEFT JOIN MAXDAT_SUPPORT.EMRS_D_DISENROLL_REASON_SV DSNR ON DSNR.reason_cd = COALESCE(st.DISENROLL_REASON_CD_1, '0')
left join MAXDAT_SUPPORT.Emrs_d_Disenroll_Type_Sv dsnt on dsnt.DISENROLL_TYPE_CD = dsnr.DISENROLL_TYPE_CD
where 1=1
and st.STATUS_CD IN ('readyToUpload','uploadedToState','pendToRecycle','acceptedByState','denied','invalid')
and st.SELECTION_SOURCE_CD in ('C','W','M','P')
AND DSNT.DISENROLL_TYPE_CD in ('WITHOUTCAUSE','WITHCAUSE') 
) ACT
WHERE act.record_date >= GREATEST(TO_DATE('3/1/2021','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
GROUP BY ACT.RECORD_DATE
, ACT.RECORD_MONTH
, ACT.PROGRAM_CODE
, ACT.ACTIVITY_TYPE
, ACT.ACTIVITY_STATUS
, CASE WHEN ACT.SCAN_DATE IS NULL AND ACT.SELECTION_SOURCE_CD = 'C' THEN 'P' ELSE ACT.SELECTION_SOURCE_CD END
, ACT.PCP_SELECTED_IND
, ACT.PHP_DISENROLL_IND
, ACT.MANAGED_CARE_STATUS
, ACT.Disenroll_Reason
, ACT.Sub_Activity_type
);
GRANT SELECT ON EMRS_F_DISENROLL_TIMING_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON EMRS_F_DISENROLL_TIMING_SV TO MAXDAT_REPORTS;

