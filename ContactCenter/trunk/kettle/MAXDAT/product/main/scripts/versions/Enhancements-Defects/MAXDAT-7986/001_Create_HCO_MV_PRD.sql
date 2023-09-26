ALTER SESSION SET CURRENT_SCHEMA = MAXDAT;

drop view cc_f_dialer_by_date_sv;

create materialized view cc_f_dialer_by_date_sv
NOLOGGING
CACHE
  REFRESH FORCE ON DEMAND 
START WITH TO_DATE(SYSDATE) NEXT SYSDATE + 1/24
  AS
select * from cc_f_dialer_by_date_sv@MAXDAT.SHRDMXDP_cisco_enterprise_cc ;

GRANT SELECT ON CC_F_DIALER_BY_DATE_SV TO MAXDAT_READ_ONLY; 



drop view HCO_F_VM_BY_HR_TYPE_BY_DAY_SV;

create materialized view HCO_F_VM_BY_HR_TYPE_BY_DAY_SV
NOLOGGING
CACHE
  REFRESH FORCE ON DEMAND 
START WITH TO_DATE(SYSDATE) NEXT SYSDATE + 1/24
  AS
select * from HCO_F_VM_BY_HR_TYPE_BY_DAY_SV@MAXDAT.SHRDMXDP_cisco_enterprise_cc ;

GRANT SELECT ON HCO_F_VM_BY_HR_TYPE_BY_DAY_SV TO MAXDAT_READ_ONLY; 



drop view cc_f_v2_call_sv;

create materialized view cc_f_v2_call_sv
NOLOGGING
CACHE
  REFRESH FORCE ON DEMAND 
START WITH TO_DATE(SYSDATE) NEXT SYSDATE + 1/24
  AS
select * from cc_f_v2_call_sv@MAXDAT.SHRDMXDP_cisco_enterprise_cc ;

GRANT SELECT ON CC_F_V2_CALL_SV TO MAXDAT_READ_ONLY; 


