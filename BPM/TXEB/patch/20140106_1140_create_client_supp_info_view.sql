create or replace view d_client_supplementary_info_sv  as
select 
CASE_CIN 
,CLIENT_CIN 
,FIRST_NAME
,LAST_NAME
,CASE_ID
,CLIENT_ID
,PROGRAM_CD
from CLIENT_SUPPLEMENTARY_INFO_STG  
with read only;

create or replace public synonym d_client_supplementary_info_sv for d_client_supplementary_info_sv;
grant select on d_client_supplementary_info_sv to MAXDAT_READ_ONLY;