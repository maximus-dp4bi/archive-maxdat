  CREATE ROLE MAXDAT_MSTR_TRX_RPT;
  GRANT MAXDAT_MSTR_TRX_RPT to MAXDAT_REPORTS;
  alter user MAXDAT_REPORTS default role all;
  
  commit;
  
  /
