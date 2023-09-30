create sequence SEQ_BASC_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table BPM_ATTRIBUTE_SOURCE_COLUMN (BASC_ID number primary key, BSL_ID number not null, BA_ID number not null, SOURCE_COLUMN_NAME varchar2(30));

create unique index BASC_UIX1 on BPM_ATTRIBUTE_SOURCE_COLUMN (BSL_ID,BA_ID) tablespace MAXDAT_INDX compute statistics;

insert into table BPM_ATTRIBUTE_SOURCE_COLUMN (BASC_ID,BSL_ID,BA_I,SOURCE_COLUMN_NAME) values (SEQ_BASC_ID.nextval,1,1,AGE_IN_BUSINESS_DAYS);
insert into table BPM_ATTRIBUTE_SOURCE_COLUMN (BASC_ID,BSL_ID,BA_I,SOURCE_COLUMN_NAME) values (SEQ_BASC_ID.nextval,1,3,CANCEL_WORK_DATE);
-- TODO: add rest of attributes

alter table BPM_ATTRIBUTE_SOURCE_COLUMN add (CALCULATED_FLAG varchar2(1), INSERT_FLAG varchar2(1),UPDATE_FLAG varchar2(1),STORE_HISTORY_FLAG varchar2(1));

update BPM_ATTRIBUTE set CALCULATED_FLAG = 'N', INSERT_FLAG = 'Y', UPDATE_FLAG = 'Y', KEEP_HISTORY_FLAG = 'N' where BA_ID = 1;
update BPM_ATTRIBUTE set CALCULATED_FLAG = 'Y', INSERT_FLAG = 'N', UPDATE_FLAG = 'N', KEEP_HISTORY_FLAG = 'N' where BA_ID = 2;
update BPM_ATTRIBUTE set CALCULATED_FLAG = 'N', INSERT_FLAG = 'Y', UPDATE_FLAG = 'Y', KEEP_HISTORY_FLAG = 'Y' where BA_ID = 3;
-- TODO: add rest of attributes

alter table BPM_ATTRIBUTE add constraint BA_CALCULATED_FLAG_CK
check (CALCULATED_FLAG in ('N','Y'));

alter table BPM_ATTRIBUTE add constraint BA_INSERT_FLAG_CK
check (INSERT_FLAG in ('N','Y'));

alter table BPM_ATTRIBUTE add constraint BA_UPDATE_FLAG_CK
check (UPDATE_FLAG in ('N','Y'));

alter table BPM_ATTRIBUTE add constraint BA_STORE_HISTORY_FLAG_CK
check (STORE_HISTORY_FLAG in ('N','Y'));

alter table BPM_ATTRIBUTE add (CALCULATED_FLAG varchar2(1) not null, INSERT_FLAG varchar2(1) not null,UPDATE_FLAG varchar2(1) not null,KEEP_HISTORY_FLAG varchar2(1) not null);

create bitmap index BA_BIX1 on BPM_ATTRIBUTE (CALCULATED_FLAG) tablespace MAXDAT_INDX compute statistics;
create bitmap index BA_BIX2 on BPM_ATTRIBUTE (INSERT_FLAG) tablespace MAXDAT_INDX compute statistics;
create bitmap index BA_BIX3 on BPM_ATTRIBUTE (UPDATE_FLAG) tablespace MAXDAT_INDX compute statistics;
create bitmap index BA_BIX4 on BPM_ATTRIBUTE (KEEP_HISTORY_FLAG) tablespace MAXDAT_INDX compute statistics;

-- TODO: uncomment
--alter table BPM_ATTRIBUTE drop column (WHEN_POPULATED);

-- list attributes
select * from BPM_ATTRIBUTE_LKUP where BAL_ID <= 36;


