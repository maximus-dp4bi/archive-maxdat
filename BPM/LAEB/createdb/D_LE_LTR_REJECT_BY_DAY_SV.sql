DROP VIEW MAXDAT_SUPPORT.D_LE_LTR_REJECT_BY_DAY_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_LE_LTR_REJECT_BY_DAY_SV
AS
select LR.lmreq_id LETTER_REQUEST_ID
   , LR.sent_on SENT_DATE
   , LD.name LETTER_CODE
   , LD.description LETTER_DESCRIPTION
   , LR.reject_reason_cd REJECT_REASON_CODE
   , LRL.client_id CLIENT_ID
   , CSI.client_cin MEDICAID_ID
   , CSI.first_name FIRST_NAME
   , CSI.last_name LAST_NAME
   , AD.addr_street_1 ADDRESS_STREET_1
   , AD.addr_street_2 ADDRESS_STREET_2
   , AD.addr_city ADDRESS_CITY
   , AD.addr_state_cd ADDRESS_STATE_CODE
   , AD.addr_zip ADDRESS_ZIPCODE
   , ERR.report_label REJECT_REASON_DESCRIPTION
   , LR.requested_on LETTER_REQUEST_DATE
   , ELS.report_label LETTER_STATUS
   , LR.update_ts LETTER_STATUS_DATE
from EB.letter_request LR
   left join EB.letter_definition LD
      on LR.lmdef_id = LD.lmdef_id
   left join EB.letter_request_link LRL
      on LR.lmreq_id = LRL.lmreq_id
   left join EB.client_supplementary_info CSI
      on CSI.client_id = LRL.client_id
   left join EB.address AD
      on LR.mailing_address_id = AD.addr_id
   left join EB.enum_reject_reason ERR
      on LR.REJECT_REASON_CD = ERR.VALUE
   left join EB.enum_lm_status ELS
      on LR.STATUS_CD = ELS.VALUE
where LR.sent_on >= (SELECT (TRUNC (SYSDATE) - 180)  FROM DUAL)
;

GRANT SELECT ON MAXDAT_SUPPORT.D_LE_LTR_REJECT_BY_DAY_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_LE_LTR_REJECT_BY_DAY_SV TO MAXDAT_SUPPORT_READ_ONLY;
