drop view emrs_d_managed_care_status_Sv;
create or replace view emrs_d_managed_care_status_Sv as
select value MANAGED_CARE_STATUS
, description MANAGED_CARE_DESC
, report_label MANAGED_CARE_LABEL
from enum_managed_care_status
union all
select 'NONM' MANAGED_CARE_STATUS
, 'Non Member' MANAGED_CARE_DESC
, 'Non Member' MANAGED_CARE_LABEL
from dual
;

GRANT SELECT ON MAXDAT_SUPPORT.emrs_d_managed_care_status_Sv TO MAXDATSUPPORT_READ_ONLY;

GRANT SELECT ON MAXDAT_SUPPORT.emrs_d_managed_care_status_Sv TO MAXDAT_REPORTS;
