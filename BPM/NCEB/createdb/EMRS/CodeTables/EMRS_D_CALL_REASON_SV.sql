drop view EMRS_D_CALL_REASON_SV;
create or replace view EMRS_D_CALL_REASON_SV as
select value CALL_REASON_TYPE_CD
, description CALL_REASON_TYPE
, report_label CALL_REASON_TYPE_LABEL
, effective_end_date EFFECTIVE_END_DATE
from EB.ENUM_CALL_REASONS;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CALL_REASON_SV TO MAXDATSUPPORT_READ_ONLY;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CALL_REASON_SV TO MAXDAT_REPORTS;
