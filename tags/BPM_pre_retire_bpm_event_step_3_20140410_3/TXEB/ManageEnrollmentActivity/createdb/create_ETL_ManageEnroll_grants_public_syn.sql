create or replace public synonym CORP_ETL_MANAGE_ENROLL for CORP_ETL_MANAGE_ENROLL;
grant select on CORP_ETL_MANAGE_ENROLL to MAXDAT_READ_ONLY;

create or replace public synonym CORP_ETL_MANAGE_ENROLL_OLTP for CORP_ETL_MANAGE_ENROLL_OLTP;
grant select on CORP_ETL_MANAGE_ENROLL_OLTP to MAXDAT_READ_ONLY;

create or replace public synonym CORP_ETL_MANAGE_ENROLL_WIP for CORP_ETL_MANAGE_ENROLL_WIP;
grant select on CORP_ETL_MANAGE_ENROLL_WIP to MAXDAT_READ_ONLY;

create or replace public synonym D_ME_CURRENT for D_ME_CURRENT;
grant select on D_ME_CURRENT to MAXDAT_READ_ONLY;

create or replace public synonym F_ME_BY_DATE for F_ME_BY_DATE;
grant select on F_ME_BY_DATE to MAXDAT_READ_ONLY;

CREATE PUBLIC SYNONYM D_ME_CURRENT_SV FOR D_ME_CURRENT_SV;
grant select on D_ME_CURRENT_SV to MAXDAT_READ_ONLY; 

