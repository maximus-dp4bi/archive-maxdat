CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_LA_EB_CALL_RECORDS_SV
AS
SELECT
  c.call_record_id      call_record_id
, c.create_ts           call_creation_date
, c.call_type_cd        call_call_type_cd
, E.event_type_cd       call_event_type_cd
, E.context             call_action_cd
, e.comments            call_action_desc
FROM
EB.CALL_RECORD c
JOIN EB.EVENT e ON E.CALL_RECORD_ID = c.CALL_RECORD_ID
;
/

GRANT SELECT ON MAXDAT_SUPPORT.D_LA_EB_CALL_RECORDS_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_LA_EB_CALL_RECORDS_SV TO GT83345;
GRANT SELECT ON MAXDAT_SUPPORT.D_LA_EB_CALL_RECORDS_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_LA_EB_CALL_RECORDS_SV TO MAXDAT_SUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_LA_EB_CALL_RECORDS_SV TO LAEB_READ_ONLY;