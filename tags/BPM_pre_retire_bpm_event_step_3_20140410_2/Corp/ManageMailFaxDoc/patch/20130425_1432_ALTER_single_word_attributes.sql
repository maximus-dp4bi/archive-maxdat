alter table D_MFDOC_CURRENT rename column "Channel"  to CHANNEL ;

alter table D_MFDOC_CURRENT rename column "Rescanned"  to RESCANNED ;

alter table D_MFDOC_BATCH rename column "Channel"  to CHANNEL;

create or replace view D_MFDOC_CURRENT_SV as
select * from D_MFDOC_CURRENT
with read only;

commit;