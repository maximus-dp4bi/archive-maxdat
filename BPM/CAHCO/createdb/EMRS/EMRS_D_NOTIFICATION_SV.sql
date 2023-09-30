CREATE OR REPLACE VIEW EMRS_D_NOTIFICATION_SV
AS
SELECT 0 notification_id,
null send_date,
null maintenance_type_cd,
null maintenance_reason,
null record_name,
null record_date,
null selection_segment_id,
null received_date_mmis,
null sent_date_mmis,
0 plan_id,
null file_type,
null transaction_status,
null processing_action
FROM dual;

GRANT SELECT ON "EMRS_D_NOTIFICATION_SV" TO "MAXDAT_READ_ONLY";
