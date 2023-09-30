create or replace view D_BPM_UPDATE_EVENT_QUEUE_SV as 
select *
from BPM_UPDATE_EVENT_QUEUE
with read only;