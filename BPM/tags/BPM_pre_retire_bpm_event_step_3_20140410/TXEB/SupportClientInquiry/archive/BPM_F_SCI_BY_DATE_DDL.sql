create sequence SEQ_FSCIBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_SCI_BY_DATE 
  (FSCIBD_ID number not null,
	 D_DATE date not null,
	 BUCKET_START_DATE date not null, 
	 BUCKET_END_DATE date not null,
	 SCI_BI_ID number not null, 
	 INVENTORY_COUNT number,
	 CREATION_COUNT number,
	 COMPLETION_COUNT number)
partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2012 values less than (to_date('20120101','YYYYMMDD')))   
tablespace MAXDAT_DATA parallel;

alter table F_SCI_BY_DATE add constraint FSCIBD_PK primary key (FSCIBD_ID);
alter index FSCIBD_PK rebuild  online tablespace MAXDAT_INDX parallel;

alter table F_SCI_BY_DATE add constraint FSCIBD_DSCICUR_FK foreign key (SCI_BI_ID) references D_SCI_CURRENT(SCI_BI_ID);

create unique index FSCIBD_UIX1 on F_SCI_BY_DATE (SCI_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FSCIBD_UIX2 on F_SCI_BY_DATE (SCI_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create index FSCIBD_IXL1 on F_SCI_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;

