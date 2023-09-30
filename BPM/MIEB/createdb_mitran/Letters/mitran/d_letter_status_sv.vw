CREATE OR REPLACE FORCE VIEW D_LETTER_STATUS_SV AS
SELECT letter_status_code
       ,letter_status_desc
       ,letter_status
       ,order_by_default
       ,effective_start_date
       ,effective_end_date
FROM d_letter_status;
grant select on D_LETTER_STATUS_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select on D_LETTER_STATUS_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on D_LETTER_STATUS_SV to MAXDAT_MITRAN_READ_ONLY;


