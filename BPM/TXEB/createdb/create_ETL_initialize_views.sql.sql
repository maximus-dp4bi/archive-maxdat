/*
Created on 01/06/2015 by Mayuresh.
Raj A. 03/30/2015 per TXEB-4771, added program_cd.
Raj A. 03/30/2015 per TXEB-4774, added SERVICE_AREA.
*/
create or replace view d_client_supplementary_info_sv  as
select 
CASE_CIN 
,CLIENT_CIN 
,FIRST_NAME
,LAST_NAME
,CASE_ID
,CLIENT_ID
,PROGRAM_CD
,SERVICE_AREA
from CLIENT_SUPPLEMENTARY_INFO_STG  
with read only;


grant select on d_client_supplementary_info_sv to MAXDAT_READ_ONLY;