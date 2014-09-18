create or replace view D_SCIE_CURRENT_SV as
select
  CONTACT_RECORD_ID,
  EVENT_ID,
  EVENT_CREATED_BY event_created_by_name,
  EVENT_CREATE_DT event_create_date,
  SUPP_EVENT_CONTEXT,
  EVENT_ACTION,
  MANUAL_ACTION_CATEGORY,
  EVENT_REF_ID event_reference_id,
  EVENT_REF_TYPE event_reference_type
from CORP_ETL_CLIENT_INQUIRY_EVENT
with read only;