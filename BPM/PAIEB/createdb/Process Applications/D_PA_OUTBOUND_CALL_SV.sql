CREATE OR REPLACE VIEW D_PA_OUTBOUND_CALL_SV
AS
SELECT ref_id app_id
  , MAX(event_id) outbound_call_id
  , COUNT(1) outbound_call_count
FROM event
WHERE event_type_cd IN('PC_REMINDER_OB_REQ','CMI_APT_OB_REQ','REFERRAL_OB_REQ')
AND ref_type = 'APP_HEADER'
GROUP BY ref_id;

GRANT SELECT ON D_PA_OUTBOUND_CALL_SV TO MAXDAT_REPORTS;
