create or replace view D_SCID_CURRENT_SV as
select 
  CECID_ID scid_bi_id,
  CONTACT_RECORD_LINK_ID,
  CLIENT_ID,
  CASE_ID,
  PROGRAM_TYPE program,
  PROGRAM_SUBTYPE subprogram
from CORP_ETL_CLIENT_INQUIRY_DTL
with read only;


create or replace view D_SCIE_CURRENT_SV as
select
  CECIE_ID scie_bi_id,
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
