CREATE OR REPLACE VIEW EMRS_F_TRANSACTION_TYPE_BY_DAY_SV
AS
SELECT COALESCE(transaction_type_cd,'0') transaction_type_cd
       ,COALESCE(tt.enrollment_trans_type,'Unknown') transaction_type_description
       ,d_date d_date
       ,COUNT(selection_transaction_id) transactions_processed
FROM d_dates_sv dd
  LEFT JOIN emrs_d_selection_trans st ON dd.d_date = st.record_date
  LEFT JOIN emrs_d_enroll_trans_type tt ON tt.enrollment_trans_type_code = transaction_type_cd
GROUP BY d_date,transaction_type_cd,tt.enrollment_trans_type;

GRANT SELECT ON "EMRS_F_TRANSACTION_TYPE_BY_DAY_SV" TO "MAXDAT_READ_ONLY";