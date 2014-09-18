create sequence SEQ_BAST_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table BPM_ATTRIBUTE_STAGING_TABLE
  (BAST_ID number not null,
   BA_ID number not null,  
   BSL_ID number not null, 
   STAGING_TABLE_COLUMN varchar2(30) not null)
parallel;

alter table BPM_ATTRIBUTE_STAGING_TABLE add constraint BAST_PK primary key (BAST_ID);
alter index BAST_PK rebuild tablespace MAXDAT_INDX parallel;

create index BAST_BA_ID_IX1 on BPM_ATTRIBUTE_STAGING_TABLE (BA_ID) tablespace MAXDAT_INDX parallel compute statistics;