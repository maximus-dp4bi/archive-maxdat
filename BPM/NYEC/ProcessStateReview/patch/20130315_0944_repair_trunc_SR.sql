drop index BPM_INSTANCE_ATTRIBUTE_IX1;
drop index BPM_INSTANCE_ATTRIBUTE_IX2;
drop index BPM_INSTANCE_ATTRIBUTE_LX1;

truncate table BPM_INSTANCE_ATTRIBUTE;

insert into BPM_INSTANCE_ATTRIBUTE
select * 
from BIA_BACKUP 
where BA_ID in
  (select BA_ID
   from BPM_ATTRIBUTE 
   where BEM_ID != 7);
   
commit;

alter table BPM_INSTANCE_ATTRIBUTE add constraint BPM_INSTANCE_ATTRIBUTE_PK primary key (BIA_ID);
alter index BPM_INSTANCE_ATTRIBUTE_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index BPM_INSTANCE_ATTRIBUTE_UNK1 on BPM_INSTANCE_ATTRIBUTE (BI_ID,BA_ID,START_DATE,END_DATE,BUE_ID) online tablespace MAXDAT_INDX parallel compute statistics; 
create index BPM_INSTANCE_ATTRIBUTE_IX1 on BPM_INSTANCE_ATTRIBUTE (BI_ID,BA_ID,END_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create index BPM_INSTANCE_ATTRIBUTE_IX2 on BPM_INSTANCE_ATTRIBUTE (BUE_ID) online tablespace MAXDAT_INDX parallel compute statistics; 
create index BPM_INSTANCE_ATTRIBUTE_LX1 on BPM_INSTANCE_ATTRIBUTE (BI_ID) online tablespace MAXDAT_INDX parallel compute statistics;

alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BI_FK foreign key (BI_ID) references BPM_INSTANCE (BI_ID);
alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BA_FK foreign key (BA_ID) references BPM_ATTRIBUTE (BA_ID);

drop table table BPM_UPDATE_EVENT_BACKUP;
drop table BPM_UPDATE_EVENT_QUEUE_CONV;

alter table BPM_UPDATE_EVENT rename constraint BPM_UPDATE_EVENT_PK1 to BPM_UPDATE_EVENT_PK;
alter table BPM_UPDATE_EVENT rename constraint BEM_BI_FK to BUE_BI_FK;
alter table BPM_UPDATE_EVENT rename constraint BUTL_BUE_FK to BUE_BUTL_FK;

alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BUE_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);

