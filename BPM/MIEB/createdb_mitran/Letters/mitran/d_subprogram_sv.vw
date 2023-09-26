CREATE OR REPLACE FORCE VIEW D_SUBPROGRAM_SV AS
SELECT SUBPROGRAM_CODE subprogram_code
       ,SUBPROGRAM_name subprogram_name
       ,PROGRAM_CODE
       , REPORT_LABEL
       ,start_date
       ,end_date
       ,plan_service_type
FROM d_SUBPROGRAM;
grant select on D_SUBPROGRAM_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select on D_SUBPROGRAM_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on D_SUBPROGRAM_SV to MAXDAT_MITRAN_READ_ONLY;


