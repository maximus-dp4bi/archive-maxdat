
ALTER TABLE D_COR_CURRENT
ADD (EE_OTHER_INDICATOR varchar2(4000)
);

create or replace view D_COR_CURRENT_SV as
select * 
from D_COR_CURRENT
with read only;


create or replace view D_COR_OR_EVENT_SV as
select * 
from CORP_ETL_CLNT_OUTREACH_EVENTS
with read only;