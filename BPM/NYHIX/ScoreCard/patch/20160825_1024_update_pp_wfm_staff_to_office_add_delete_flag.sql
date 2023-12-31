Alter table DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE ADD (DELETE_FLAG VARCHAR2(1));

UPDATE DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE
SET DELETE_FLAG = 'N';

CREATE OR REPLACE FORCE VIEW PP_WFM_STAFF_TO_OFFICE_SV
(EFFECTIVE_DATE
,STAFF_ID
,OFFICE_ID
,END_DATE
,DELETE_FLAG
) 
as
select 
EFFECTIVE_DATE
,STAFF_ID
,OFFICE_ID
,END_DATE
,DELETE_FLAG
from PP_WFM_STAFF_TO_OFFICE
WITH READ ONLY;

grant select on PP_WFM_STAFF_TO_OFFICE_SV to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on PP_WFM_STAFF_TO_OFFICE_SV to MAXDAT; 
