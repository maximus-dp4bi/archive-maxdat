create or replace public synonym D_CMOR_CURRENT_SV  for D_CMOR_CURRENT_SV ;
grant select on D_CMOR_CURRENT_SV to MAXDAT_READ_ONLY;

create or replace public synonym D_CMOR_CLIENT_SV  for D_CMOR_CLIENT_SV;
grant select on D_CMOR_CLIENT_SV to MAXDAT_READ_ONLY;

create or replace public synonym D_CMOR_SESSION_STATUS_SV  for D_CMOR_SESSION_STATUS_SV ;
grant select on D_CMOR_SESSION_STATUS_SV to MAXDAT_READ_ONLY;

create or replace public synonym F_CMOR_BY_DATE_SV  for F_CMOR_BY_DATE_SV ;
grant select on F_CMOR_BY_DATE_SV to MAXDAT_READ_ONLY;
