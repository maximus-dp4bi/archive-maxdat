alter table D_PI_CURRENT rename column "generic field 1"  to "Generic Field 1" ;

alter table D_PI_CURRENT rename column "generic field 2"  to "Generic Field 2" ;

alter table D_PI_CURRENT rename column "generic field 3"  to "Generic Field 3" ;

alter table D_PI_CURRENT rename column "generic field 4"  to "Generic Field 4" ;

alter table D_PI_CURRENT rename column "generic field 5"  to "Generic Field 5" ;

create or replace view D_PI_CURRENT_SV as
select * from D_PI_CURRENT
with read only;

commit;