create table CC_F_ABD_20151113 as select * from CC_F_AGENT_BY_DATE;

create table CC_F_AABD_20151113 as select * from CC_F_AGENT_ACTIVITY_BY_DATE;

drop table CC_F_AGENT_BY_DATE_20151113;

drop table CC_F_AGENT_BY_DATE_20151005;

commit;