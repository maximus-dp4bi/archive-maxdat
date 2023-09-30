CREATE OR REPLACE FORCE VIEW D_LETTER_REJECT_REASON_SV AS
SELECT reject_reason_code
      ,reject_reason_desc
      ,reject_reason
      ,effective_start_date
      ,effective_end_date
FROM d_letter_reject_reason;
grant select on D_LETTER_REJECT_REASON_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select on D_LETTER_REJECT_REASON_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on D_LETTER_REJECT_REASON_SV to MAXDAT_MITRAN_READ_ONLY;


