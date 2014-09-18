execute BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1608,3,'Source Complete Date','Calculated complete date.  Use STG_LAST_UPDATE_DATE when complete date < create date.');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2607,1608,12,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
commit;

alter table D_PL_CURRENT add (SOURCE_COMPLETE_DATE date);

create or replace view D_PL_CURRENT_SV as
select * 
from D_PL_CURRENT
with read only;
