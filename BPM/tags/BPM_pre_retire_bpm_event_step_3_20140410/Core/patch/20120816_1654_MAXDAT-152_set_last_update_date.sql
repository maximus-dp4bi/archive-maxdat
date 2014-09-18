-- Corrects existing data for MAXDAT-152.

create table T_UPDATE_EVENTS as
select 
  BI_ID,
  max(EVENT_DATE) lastupdate
from BPM_UPDATE_EVENT
group by BI_ID;

alter table T_UPDATE_EVENTS add primary key (BI_ID);

update
(select 
  bi.BI_ID,
  bi.LAST_UPDATE_DATE,
  tue.lastupdate
from BPM_INSTANCE bi
inner join T_UPDATE_EVENTS tue on (tue.BI_ID = bi.BI_ID and bi.LAST_UPDATE_DATE != tue.lastupdate))
set LAST_UPDATE_DATE = lastupdate;

drop table T_UPDATE_EVENTS;