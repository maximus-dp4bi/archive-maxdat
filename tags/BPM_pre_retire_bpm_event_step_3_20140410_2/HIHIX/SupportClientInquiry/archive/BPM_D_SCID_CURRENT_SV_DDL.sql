create or replace view D_SCID_CURRENT_SV as
select 
  CONTACT_RECORD_ID,
  CONTACT_RECORD_LINK_ID,
  CLIENT_ID,
  CASE_ID,
  PROGRAM_TYPE program,
  PROGRAM_SUBTYPE subprogram,
  CLIENT_UNDER_TWENTYONE
from CORP_ETL_CLIENT_INQUIRY_DTL
with read only;

