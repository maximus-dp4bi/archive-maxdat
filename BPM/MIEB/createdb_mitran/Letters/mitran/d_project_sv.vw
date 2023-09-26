CREATE OR REPLACE FORCE VIEW D_PROJECT_SV AS
SELECT PROJECT_code
       ,PROJECT_name
       ,REPORT_LABEL
       ,active_inactive       
       ,start_date
       ,end_date
FROM d_PROJECT;
grant select on D_PROJECT_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select on D_PROJECT_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on D_PROJECT_SV to MAXDAT_MITRAN_READ_ONLY;


