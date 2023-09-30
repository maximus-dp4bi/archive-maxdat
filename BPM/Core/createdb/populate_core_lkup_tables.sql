insert into BPM_ACTIVITY_EVENT_TYPE_LKUP (BACETL_ID,EVENT_TYPE_NAME,EVENT_TYPE_ORDER) values (1,'Start',1);
insert into BPM_ACTIVITY_EVENT_TYPE_LKUP (BACETL_ID,EVENT_TYPE_NAME,EVENT_TYPE_ORDER) values (2,'Cancel',2);
insert into BPM_ACTIVITY_EVENT_TYPE_LKUP (BACETL_ID,EVENT_TYPE_NAME,EVENT_TYPE_ORDER) values (3,'Complete',3);

insert into BPM_ACTIVITY_TYPE_LKUP (BACTL_ID,ACTIVITY_TYPE_CD,ACTIVITY_TYPE_DESC) values (1,'A','Activity Step');
insert into BPM_ACTIVITY_TYPE_LKUP (BACTL_ID,ACTIVITY_TYPE_CD,ACTIVITY_TYPE_DESC) values (2,'G','Gateway');
insert into BPM_ACTIVITY_TYPE_LKUP (BACTL_ID,ACTIVITY_TYPE_CD,ACTIVITY_TYPE_DESC) values (3,'E','End Point');

insert into BPM_DATATYPE_LKUP (BDL_ID,DATATYPE) values (1,'NUMBER');
insert into BPM_DATATYPE_LKUP (BDL_ID,DATATYPE) values (2,'VARCHAR');
insert into BPM_DATATYPE_LKUP (BDL_ID,DATATYPE) values (3,'DATE');

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (1,'Document ID');
insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (2,'Application ID');
insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (3,'Task ID');
insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (4,'Batch ID');

insert into BPM_PROGRAM_LKUP (BPRG_ID,NAME) values (1,'EB');
insert into BPM_PROGRAM_LKUP (BPRG_ID,NAME) values (2,'ES');

insert into BPM_REGION_LKUP (BRL_ID,NAME) values (1,'EAST');
insert into BPM_REGION_LKUP (BRL_ID,NAME) values (2,'CENTRAL');
insert into BPM_REGION_LKUP (BRL_ID,NAME) values (3,'WEST');
insert into BPM_REGION_LKUP (BRL_ID,NAME) values (5,'MOUNTAIN');

insert into BPM_SOURCE_TYPE_LKUP (BSTL_ID,NAME) values (1,'ATS ETL');

insert into BPM_UPDATE_TYPE_LKUP (BUTL_ID,NAME) values(1,'ETL');

commit;
