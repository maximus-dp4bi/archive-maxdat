alter session set current_schema = maxdat;

drop materialized view CC_F_DIALER_BY_DATE_SV;

create or replace view CC_F_DIALER_BY_DATE_SV
as select vdial.* from CC_F_DIALER_BY_DATE_SV@MAXDAT.SHRDMXDP_cisco_enterprise_cc vdial
inner join CC_D_PROJECT@MAXDAT.SHRDMXDP_cisco_enterprise_cc p on p.project_id = vdial.d_project_id
where p.project_name = 'CA HCO';

drop materialized view HCO_F_VM_BY_HR_TYPE_BY_DAY_SV;

create or replace view HCO_F_VM_BY_HR_TYPE_BY_DAY_SV
as select vm.* from HCO_F_VM_BY_HR_TYPE_BY_DAY_SV@MAXDAT.SHRDMXDP_cisco_enterprise_cc vm
inner join CC_D_PROJECT@MAXDAT.SHRDMXDP_cisco_enterprise_cc p on p.project_id = vm.d_project_id
where p.project_name = 'CA HCO';


drop materialized view CC_F_V2_CALL_SV;

CREATE MATERIALIZED VIEW CC_F_V2_CALL_SV
  REFRESH FAST ON DEMAND WITH ROWID
  AS select * from CC_HCO_F_V2_CALL@MAXDAT.SHRDMXDP_cisco_enterprise_cc;