DROP VIEW MAXDAT_SUPPORT.EMRS_D_SELECTION_MI_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_SELECTION_MI_SV
AS
SELECT smi.missing_info_id||st.selection_txn_id||smd.missing_info_details_id AS SELECTION_MISSING_INFO_ID,
    selection_txn_id AS SELECTION_TRANSACTION_ID,
    smi.missing_info_type_cd AS MISSING_INFO_TYPE_CD,
    COALESCE(smd.error_code, '0') AS ENROLLMENT_ERROR_CODE,
    smd.denial_error_cd AS REJECTION_ERROR_REASON_CODE,
    smd.supplemental_info AS SUPPLEMENTAL_INFO,
    smd.send_in_letter_ind AS SEND_IN_LETTER_IND,
    TRUNC(smd.create_ts) AS RECORD_DATE,
    TO_CHAR(smd.create_ts, 'hh24mi') AS RECORD_TIME,
    smd.created_by AS RECORD_NAME 
  FROM eb.selection_txn st
  LEFT JOIN eb.selection_missing_info smi              ON st.missing_info_id = smi.missing_info_id
  LEFT JOIN eb.selection_missing_info_details smd ON smi.missing_info_id = smd.missing_info_id AND st.client_id = smd.client_id;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SELECTION_MI_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SELECTION_MI_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SELECTION_MI_SV TO MAXDAT_SUPPORT_READ_ONLY;

