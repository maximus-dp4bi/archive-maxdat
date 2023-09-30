--Create New Role and assign
CREATE ROLE MAXDAT_MSTR_TRX_RPT;
GRANT MAXDAT_MSTR_TRX_RPT to DP_REPORTS;
alter user DP_REPORTS default role all;
  
commit;

/
