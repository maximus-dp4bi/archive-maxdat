ALTER SESSION SET CURRENT_SCHEMA = MAXDAT;

drop materialized view cc_f_v2_call_sv;

create materialized view cc_f_v2_call_sv
NOLOGGING
CACHE
  REFRESH FORCE ON DEMAND 
START WITH TO_DATE(SYSDATE) NEXT SYSDATE + 1/24
  AS
select * from cc_f_v2_call_sv@MAXDAT.SHRDMXDP_cisco_enterprise_cc ;

GRANT SELECT ON CC_F_V2_CALL_SV TO MAXDAT_READ_ONLY; 


