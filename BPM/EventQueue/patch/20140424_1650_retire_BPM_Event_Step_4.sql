drop index BUEQ_LX4;
alter table BPM_UPDATE_EVENT_QUEUE drop (WROTE_BPM_EVENT_DATE);

create or replace view D_BPM_UPDATE_EVENT_QUEUE_SV as 
select *
from BPM_UPDATE_EVENT_QUEUE
with read only;

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE drop (WROTE_BPM_EVENT_DATE);