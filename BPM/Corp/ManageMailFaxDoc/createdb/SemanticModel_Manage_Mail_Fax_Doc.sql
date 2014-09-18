create table D_MFDOC_CURRENT 
  ("MFDOC_BI_ID" number not null, 
	 DCN varchar2(256), 
	 "DCN Create Date" date, 
	 "Instance Status" varchar2(50), 
	 "Instance Complete Date" date, 
	 "Batch Name" varchar2(255), 
	 CHANNEL varchar2(15), 
	 ECN varchar2(256), 
	 "Original DCN" number, 
	 RESCANNED varchar2(1), 
	 "Document Page Count" number, 
	 "Document Status" varchar2(32), 
	 "Document Status Date" date, 
	 "DCN Count" number, 
	 "Document Barcode Flag" varchar2(1), 
	 "Document Form Type" varchar2(255), 
	 "Document Type" varchar2(64), 
	 "Autolink Outcome Flag" varchar2(50), 
	 "Autolink Failure Reason" varchar2(256), 
	 "Create IA Task Start" date, 
	 "Create IA Task End" date, 
	 "Create IA Task End Flag" varchar2(1), 
	 "IA Manual Classify Task ID" number, 
	 "IA Manual Link Task ID" number, 
	 "Rescan Required Flag" varchar2(1), 
	 "Doc Class Present Flag" varchar2(1), 
	 "Manual Link Image Start" date, 
	 "Manual Link Image End" date, 
	 "Manual Link Image End Flag" varchar2(1), 
   "Manual Classify Form Doc Start" date, 
	 "Manual Classify Form Doc End" date, 
	 "Manual Classify Form Doc Flag" varchar2(1), 
	 "Create and Route Work Start" date, 
	 "Create and Route Work End" date, 
	 "Create Route Work Flag" varchar2(1), 
	 "Work Identified Flag" varchar2(1), 
	 "Work Task ID" number, 
	 "Work Task Type" varchar2(50), 
	 "Cancel Document Processing End" date, 
	 "Link Method" varchar2(15), 
	 "Link Via" varchar2(32), 
	 "Link Number" number, 
	 "Age in Business Days" number, 
	 "Age in Calendar Days" number, 
	 "DCN Jeopardy Status" varchar2(30), 
	 "DCN Jeopardy Status Date" date, 
	 "DCN Timeliness Status" varchar2(30), 
	 "Cancel By" varchar2(50),
   "Cancel Reason" varchar2(256),
   "Cancel Method" varchar2(50)) 
tablespace MAXDAT_DATA parallel;

alter table D_MFDOC_CURRENT add constraint DMFDOCCUR_PK primary key (MFDOC_BI_ID) using index tablespace MAXDAT_INDX;

create index dcn_dmfdoc_curr on D_MFDOC_CURRENT (Dcn) tablespace MAXDAT_INDX;

create or replace public synonym D_MFDOC_CURRENT for D_MFDOC_CURRENT;
grant select on D_MFDOC_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_MFDOC_CURRENT_SV as
select * from D_MFDOC_CURRENT
with read only;

create or replace public synonym D_MFDOC_CURRENT_SV for D_MFDOC_CURRENT_SV;
grant select on D_MFDOC_CURRENT_SV to MAXDAT_READ_ONLY;

-- D_MFDOC_INSTANCE_STATUS  DMFDOCIS_ID
create sequence SEQ_DMFDOCIS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_MFDOC_INSTANCE_STATUS 
  (DMFDOCIS_ID number not null, 
   "Instance Status" varchar2(32) not null)
tablespace MAXDAT_DATA;

alter table D_MFDOC_INSTANCE_STATUS add constraint DMFDOCIS_PK primary key (DMFDOCIS_ID) using index tablespace MAXDAT_INDX;

create unique index DMFDOCIS_UIX1 on D_MFDOC_INSTANCE_STATUS ("Instance Status") online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym D_MFDOC_INSTANCE_STATUS for D_MFDOC_INSTANCE_STATUS;
grant select on D_MFDOC_INSTANCE_STATUS to MAXDAT_READ_ONLY;

create or replace view D_MFDOC_INSTANCE_STATUS_SV as
select * from D_MFDOC_INSTANCE_STATUS
with read only;

create or replace public synonym D_MFDOC_INSTANCE_STATUS_SV for D_MFDOC_INSTANCE_STATUS_SV;
grant select on D_MFDOC_INSTANCE_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_MFDOC_INSTANCE_STATUS (DMFDOCIS_ID,"Instance Status") values (SEQ_DMFDOCIS_ID.nextval,'Active');
insert into D_MFDOC_INSTANCE_STATUS (DMFDOCIS_ID,"Instance Status") values (SEQ_DMFDOCIS_ID.nextval,'Complete');
commit;


-- D_MFDOC_DOCUMENT_STATUS  DMFDOCDS_ID
create sequence SEQ_DMFDOCDS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_MFDOC_DOCUMENT_STATUS 
  (DMFDOCDS_ID number not null, 
   "Document Status" varchar2(32) not null)
tablespace MAXDAT_DATA;

alter table D_MFDOC_DOCUMENT_STATUS add constraint DMFDOCDS_PK primary key (DMFDOCDS_ID) using index tablespace MAXDAT_INDX;

create unique index DMFDOCDS_UIX1 on D_MFDOC_DOCUMENT_STATUS ("Document Status") online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym D_MFDOC_DOCUMENT_STATUS for D_MFDOC_DOCUMENT_STATUS;
grant select on D_MFDOC_DOCUMENT_STATUS to MAXDAT_READ_ONLY;

create or replace view D_MFDOC_DOCUMENT_STATUS_SV as
select * from D_MFDOC_DOCUMENT_STATUS
with read only;

create or replace public synonym D_MFDOC_DOCUMENT_STATUS_SV for D_MFDOC_DOCUMENT_STATUS_SV;
grant select on D_MFDOC_DOCUMENT_STATUS_SV to MAXDAT_READ_ONLY;

-- D_MFDOC_TIMELINESS_STATUS  DMFDOCTS_ID
create sequence SEQ_DMFDOCTS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_MFDOC_TIMELINESS_STATUS 
  (DMFDOCTS_ID number not null, 
   "DCN Timeliness Status" varchar2(32) not null)
tablespace MAXDAT_DATA;

alter table D_MFDOC_TIMELINESS_STATUS add constraint DMFDOCTS_PK primary key (DMFDOCTS_ID) using index tablespace MAXDAT_INDX;

create unique index DMFDOCTS_UIX1 on D_MFDOC_TIMELINESS_STATUS ("DCN Timeliness Status") online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym D_MFDOC_TIMELINESS_STATUS for D_MFDOC_TIMELINESS_STATUS;
grant select on D_MFDOC_TIMELINESS_STATUS to MAXDAT_READ_ONLY;

create or replace view D_MFDOC_TIMELINESS_STATUS_SV as
select * from D_MFDOC_TIMELINESS_STATUS
with read only;

create or replace public synonym D_MFDOC_TIMELINESS_STATUS_SV for D_MFDOC_TIMELINESS_STATUS_SV;
grant select on D_MFDOC_TIMELINESS_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_MFDOC_TIMELINESS_STATUS (DMFDOCTS_ID,"DCN Timeliness Status") values (SEQ_DMFDOCTS_ID.nextval,'Not Processed');
insert into D_MFDOC_TIMELINESS_STATUS (DMFDOCTS_ID,"DCN Timeliness Status") values (SEQ_DMFDOCTS_ID.nextval,'Processed Timely');
insert into D_MFDOC_TIMELINESS_STATUS (DMFDOCTS_ID,"DCN Timeliness Status") values (SEQ_DMFDOCTS_ID.nextval,'Processed Untimely');
commit;


-- D_MFDOC_BATCH  DMFDOCB_ID
create sequence SEQ_DMFDOCB_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_MFDOC_BATCH 
  (DMFDOCB_ID number not null, 
   "Batch Name" varchar2(255) not null,
   CHANNEL varchar2(15) not null)
tablespace MAXDAT_DATA;

alter table D_MFDOC_BATCH add constraint DMFDOCB_PK primary key (DMFDOCB_ID) using index tablespace MAXDAT_INDX;

create unique index DMFDOCB_UIX1 on D_MFDOC_BATCH ("Batch Name") online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym D_MFDOC_BATCH for D_MFDOC_BATCH;
grant select on D_MFDOC_BATCH to MAXDAT_READ_ONLY;

create or replace view D_MFDOC_BATCH_SV as
select * from D_MFDOC_BATCH
with read only;

create or replace public synonym D_MFDOC_BATCH_SV for D_MFDOC_BATCH_SV;
grant select on D_MFDOC_BATCH_SV to MAXDAT_READ_ONLY;

-- D_MFDOC_DOC_TYPE  DMFDOCDT_ID
create sequence SEQ_DMFDOCDT_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_MFDOC_DOC_TYPE 
  (DMFDOCDT_ID number not null, 
   "Document Type" varchar2(64))
tablespace MAXDAT_DATA;

alter table D_MFDOC_DOC_TYPE add constraint DMFDOCDT_PK primary key (DMFDOCDT_ID) using index tablespace MAXDAT_INDX;

create unique index DMFDOCDT_UIX1 on D_MFDOC_DOC_TYPE ("Document Type") online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym D_MFDOC_DOC_TYPE for D_MFDOC_DOC_TYPE;
grant select on D_MFDOC_DOC_TYPE to MAXDAT_READ_ONLY;

create or replace view D_MFDOC_DOC_TYPE_SV as
select * from D_MFDOC_DOC_TYPE
with read only;

create or replace public synonym D_MFDOC_DOC_TYPE_SV for D_MFDOC_DOC_TYPE_SV;
grant select on D_MFDOC_DOC_TYPE_SV to MAXDAT_READ_ONLY;

insert into D_MFDOC_DOC_TYPE (DMFDOCDT_ID,"Document Type") values (SEQ_DMFDOCDT_ID.nextval,null);
commit;


-- D_MFDOC_JEOPARDY_STATUS  DMFDOCJS_ID
create sequence SEQ_DMFDOCDCNJS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_MFDOC_DCN_JEOPARDY_STATUS 
  (DMFDOCDCNJS_ID number not null, 
   "DCN Jeopardy Status" varchar2(30) not null)
tablespace MAXDAT_DATA;

alter table D_MFDOC_DCN_JEOPARDY_STATUS add constraint DMFDOCDCNJS_PK primary key (DMFDOCDCNJS_ID) using index tablespace MAXDAT_INDX;

create unique index DMFDOCDCNJS_UIX1 on D_MFDOC_DCN_JEOPARDY_STATUS ("DCN Jeopardy Status") online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym D_MFDOC_DCN_JEOPARDY_STATUS for D_MFDOC_DCN_JEOPARDY_STATUS;
grant select on D_MFDOC_DCN_JEOPARDY_STATUS to MAXDAT_READ_ONLY;

create or replace view D_MFDOC_DCN_JEOPARDY_STATUS_SV as
select * from D_MFDOC_DCN_JEOPARDY_STATUS
with read only;

create or replace public synonym D_MFDOC_DCN_JEOPARDY_STATUS_SV for D_MFDOC_DCN_JEOPARDY_STATUS_SV;
grant select on D_MFDOC_DCN_JEOPARDY_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_MFDOC_DCN_JEOPARDY_STATUS (DMFDOCDCNJS_ID,"DCN Jeopardy Status") values (SEQ_DMFDOCDCNJS_ID.nextval,'N');
insert into D_MFDOC_DCN_JEOPARDY_STATUS (DMFDOCDCNJS_ID,"DCN Jeopardy Status") values (SEQ_DMFDOCDCNJS_ID.nextval,'Y');
insert into D_MFDOC_DCN_JEOPARDY_STATUS (DMFDOCDCNJS_ID,"DCN Jeopardy Status") values (SEQ_DMFDOCDCNJS_ID.nextval,'NA');
commit;

create sequence SEQ_FMFDOCBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_MFDOC_BY_DATE 
  (FMFDOCBD_ID number not null,
   D_DATE date not null, 
   BUCKET_START_DATE date not null, 
   BUCKET_END_DATE date not null,
   MFDOC_BI_ID number not null,
   DMFDOCDT_ID number, --D_MFDOC_DOC_TYPE
   DMFDOCB_ID number not null, --D_MFDOC_BATCH
   DMFDOCTS_ID number not null, --D_MFDOC_TIMELINESS_STATUS
   DMFDOCDS_ID number not null, --D_MFDOC_DOCUMENT_STATUS 
   DMFDOCIS_ID number not null, --D_MFDOC_INSTANCE_STATUS
   DMFDOCDCNJS_ID number not null, --D_MFDOC_JEOPARDY_STATUS
   CREATION_COUNT number,
   INVENTORY_COUNT number,
   COMPLETION_COUNT number,
   "Document Status Date" date,
   "DCN Jeopardy Status Date" date)
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (TO_DATE('20130101','YYYYMMDD')))   
tablespace MAXDAT_DATA parallel;

alter table F_MFDOC_BY_DATE add constraint FMFDOCBD_PK primary key (FMFDOCBD_ID) using index tablespace MAXDAT_INDX;

alter table F_MFDOC_BY_DATE add constraint FMFDOCBD_DMFDOCCUR_FK foreign key (MFDOC_BI_ID)references D_MFDOC_CURRENT (MFDOC_BI_ID);
alter table F_MFDOC_BY_DATE add constraint FMFDOCBD_DMFDOCDT_FK foreign key (DMFDOCDT_ID) references D_MFDOC_DOC_TYPE (DMFDOCDT_ID);
alter table F_MFDOC_BY_DATE add constraint FMFDOCBD_DMFDOCB_FK foreign key (DMFDOCB_ID) references D_MFDOC_BATCH (DMFDOCB_ID);
alter table F_MFDOC_BY_DATE add constraint FMFDOCBD_DMFDOCTS_FK foreign key (DMFDOCTS_ID) references D_MFDOC_TIMELINESS_STATUS (DMFDOCTS_ID);
alter table F_MFDOC_BY_DATE add constraint FMFDOCBD_DMFDOCDS_FK foreign key (DMFDOCDS_ID) references D_MFDOC_DOCUMENT_STATUS (DMFDOCDS_ID);
alter table F_MFDOC_BY_DATE add constraint FMFDOCBD_DMFDOCIS_FK foreign key (DMFDOCIS_ID) references D_MFDOC_INSTANCE_STATUS (DMFDOCIS_ID);
alter table F_MFDOC_BY_DATE add constraint FMFDOCBD_DMFDOCJS_FK foreign key (DMFDOCDCNJS_ID) references D_MFDOC_DCN_JEOPARDY_STATUS (DMFDOCDCNJS_ID);

create unique index FMFDOCBD_UIX1 on F_MFDOC_BY_DATE (MFDOC_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FMFDOCBD_UIX2 on F_MFDOC_BY_DATE (MFDOC_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

create index FMFDOCBD_IX1 on F_MFDOC_BY_DATE ("Document Status Date") online tablespace MAXDAT_INDX parallel compute statistics;
create index FMFDOCBD_IX2 on F_MFDOC_BY_DATE ("DCN Jeopardy Status Date") online tablespace MAXDAT_INDX parallel compute statistics;

create index FMFDOCBD_IXL1 on F_MFDOC_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMFDOCBD_IXL2 on F_MFDOC_BY_DATE (MFDOC_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMFDOCBD_IXL3 on F_MFDOC_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMFDOCBD_IXL4 on F_MFDOC_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym F_MFDOC_BY_DATE_SV for F_MFDOC_BY_DATE;
grant select on F_MFDOC_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_MFDOC_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FMFDOCBD_ID,
  BUCKET_START_DATE D_DATE,
  MFDOC_BI_ID,
  DMFDOCDT_ID, 
  DMFDOCB_ID, 
  DMFDOCTS_ID, 
  DMFDOCDS_ID, 
  DMFDOCIS_ID, 
  DMFDOCDCNJS_ID,
  CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Document Status Date", 
  "DCN Jeopardy Status Date"
from F_MFDOC_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FMFDOCBD_ID,
  bdd.D_DATE,
  MFDOC_BI_ID,
  DMFDOCDT_ID, 
  DMFDOCB_ID, 
  DMFDOCTS_ID, 
  DMFDOCDS_ID, 
  DMFDOCIS_ID, 
  DMFDOCDCNJS_ID,
  0 CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Document Status Date", 
  "DCN Jeopardy Status Date"
from 
  F_MFDOC_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FMFDOCBD_ID,
  bdd.D_DATE,
  MFDOC_BI_ID,
  DMFDOCDT_ID, 
  DMFDOCB_ID, 
  DMFDOCTS_ID, 
  DMFDOCDS_ID, 
  DMFDOCIS_ID, 
  DMFDOCDCNJS_ID,
  0 CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Document Status Date", 
  "DCN Jeopardy Status Date"
from
  BPM_D_DATES bdd,
  F_MFDOC_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FMFDOCBD_ID,
  bdd.D_DATE,
  MFDOC_BI_ID,
  DMFDOCDT_ID, 
  DMFDOCB_ID, 
  DMFDOCTS_ID, 
  DMFDOCDS_ID, 
  DMFDOCIS_ID, 
  DMFDOCDCNJS_ID,
  CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Document Status Date", 
  "DCN Jeopardy Status Date"
from
  BPM_D_DATES bdd,
  F_MFDOC_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

create or replace public synonym F_MFDOC_BY_DATE_SV for F_MFDOC_BY_DATE_SV;
grant select on F_MFDOC_BY_DATE_SV to MAXDAT_READ_ONLY;




