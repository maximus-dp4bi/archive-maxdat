CREATE OR REPLACE VIEW d_contact_records_sv
AS
SELECT cr.call_record_id
 ,cr.call_type_cd
 ,cr.worker_id
 ,cr.worker_username
 ,st.first_name worker_first_name
 ,st.last_name worker_last_name
 ,cr.call_record_field2
 ,cr.call_record_field1
 ,TRUNC(cr.call_start_ts) call_date
 ,cr.call_start_ts
 ,cr.call_end_ts
 ,cr.create_ts
FROM eb.call_record cr
 LEFT JOIN eb.staff st on st.staff_id = cr.worker_id
WHERE call_end_ts is not null
AND TRUNC(cr.call_start_ts) >= GREATEST(TO_DATE('3/1/2021','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13));

GRANT SELECT ON "MAXDAT_SUPPORT"."D_CONTACT_RECORDS_SV" TO "MAXDAT_REPORTS";
GRANT SELECT ON "MAXDAT_SUPPORT"."D_CONTACT_RECORDS_SV" TO "MAXDATSUPPORT_READ_ONLY";