CREATE OR REPLACE FORCE VIEW D_PROGRAM_SV AS
SELECT program_code
       ,program_name
       ,REPORT_LABEL
       ,active_inactive       
       ,start_date
       ,end_date
FROM d_program;
grant select on D_PROGRAM_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select on D_PROGRAM_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on D_PROGRAM_SV to MAXDAT_MITRAN_READ_ONLY;


