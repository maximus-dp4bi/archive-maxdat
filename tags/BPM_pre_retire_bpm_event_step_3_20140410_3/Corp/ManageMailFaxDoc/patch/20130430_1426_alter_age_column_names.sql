
alter table D_MFDOC_CURRENT rename column "Age in business days" to "Age in Business Days"  ;

alter table D_MFDOC_CURRENT rename column "Age in calendar days" to "Age in Calendar Days"  ;

drop view D_MFDOC_CURRENT_SV;

create or replace view D_MFDOC_CURRENT_SV as
select * from D_MFDOC_CURRENT
with read only;