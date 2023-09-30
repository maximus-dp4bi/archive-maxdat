alter session set current_schema = maxdat;


drop view CC_F_V2_CALL_SV;

CREATE MATERIALIZED VIEW CC_F_V2_CALL_SV
  REFRESH FAST ON DEMAND WITH ROWID
  AS select * from CC_HCO_F_V2_CALL@MAXDAT.SHRDMXDU_cisco_enterprise_cc; 
