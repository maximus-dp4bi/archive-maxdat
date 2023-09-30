DROP VIEW MAXDAT_SUPPORT.EMRS_F_PLAN_TRANSFER_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_F_PLAN_TRANSFER_SV
AS
SELECT a.selection_txn_id AS SELECTION_TRANSACTION_ID
  , a.client_id
  , a.TRANSACTION_TYPE_CD
  , a.TRANSACTION_TYPE_CD_PP
  , p.plan_id
  , p.plan_name
  , a.plan_id AS transfer_to_plan_id
  , a.prior_plan_id AS transfer_from_plan_id
  , a.prior_selection_transaction_id
FROM PLAN p 
JOIN (SELECT st.selection_txn_id
      , st.plan_id
      , st.client_id
      , pp.TRANSACTION_TYPE_CD as TRANSACTION_TYPE_CD_pp
      , st.TRANSACTION_TYPE_CD
      ,COALESCE(pp.PRIOR_PLAN_ID, 0) AS PRIOR_PLAN_ID
      , pp.prior_selection_transaction_id
      FROM eb.selection_txn st 
      LEFT JOIN (SELECT 
                  a.selection_txn_id,
                  a.selection_segment_id,
                  a.TRANSACTION_TYPE_CD,
                  a.CLIENT_ID,
                  a.STATUS_CD,
                  a.STATUS_DATE,
                  a.START_DATE,
                  a.SEGMENT_START_ND,
                  a.SEGMENT_END_ND,
                  a.PLAN_ID,
                  a.PLAN_ID_EXT,
                  a.PLAN_TYPE_CD,
                  LAG(a.selection_txn_id, 1) OVER (PARTITION BY a.client_id ORDER BY a.selection_txn_id ASC) prior_selection_transaction_id,
                  LAG(a.PLAN_ID, 1) OVER (PARTITION BY a.client_id ORDER BY a.selection_txn_id ASC) prior_plan_id,
                  LAG(a.PLAN_ID_EXT, 1) OVER (PARTITION BY a.client_id ORDER BY a.selection_txn_id ASC) prior_plan_id_ext
                  FROM 
                  (SELECT 
                    st.selection_txn_id,
                    ss.selection_segment_id,
                    st.TRANSACTION_TYPE_CD,
                    st.CLIENT_ID,
                    st.STATUS_CD,
                    st.STATUS_DATE,
                    st.START_DATE,
                    ss.START_ND AS SEGMENT_START_ND,
                    ss.END_ND AS SEGMENT_END_ND,
                    st.PLAN_ID,
                    st.PLAN_ID_EXT,
                    st.PLAN_TYPE_CD,
                    ROW_NUMBER() OVER(PARTITION BY st.CLIENT_ID, st.START_ND ORDER BY st.SELECTION_TXN_ID DESC) as rn
                    FROM eb.selection_txn st
                    JOIN eb.selection_segment ss ON (ss.client_id = st.client_id AND ss.START_DATE = st.START_DATE AND ss.PLAN_ID_EXT = st.PLAN_ID_EXT AND st.TRANSACTION_TYPE_CD <> 'Disenrollment')
                    WHERE st.STATUS_CD = 'acceptedByState'
                    AND st.SELECTION_SOURCE_CD <> 'AT'
                    AND st.TRANSACTION_TYPE_CD <> 'Disenrollment'
                    AND st.START_ND <> st.END_ND) a
                  WHERE RN = 1) pp ON (st.client_id = pp.client_id AND st.start_date = pp.start_date)
      WHERE st.STATUS_CD = 'acceptedByState'
      AND st.TRANSACTION_TYPE_CD = 'Transfer'
      AND st.SELECTION_SOURCE_CD <> 'AT'
      AND (st.start_nd >= to_number(to_char(ADD_MONTHS(TRUNC(sysdate, 'mm'), -3), 'yyyymmdd')) and st.end_nd > st.start_nd)
              ) a ON (p.plan_id = a.plan_id OR p.plan_id = a.prior_plan_id);

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_PLAN_TRANSFER_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_PLAN_TRANSFER_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_PLAN_TRANSFER_SV TO MAXDAT_SUPPORT_READ_ONLY;

