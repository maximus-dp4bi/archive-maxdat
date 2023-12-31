ALTER TABLE D_NYHIX_MFD_CURRENT PARALLEL;


CREATE TABLE F_NYHIX_MFD_BY_DATE_temp 
(FNMFDBD_ID NUMBER NOT NULL,
 D_DATE	DATE NOT NULL,
 BUCKET_START_DATE DATE NOT NULL,
 BUCKET_END_DATE DATE NOT NULL,
 NYHIX_MFD_BI_ID NUMBER NOT NULL,
 DNMFDDT_ID NUMBER NOT NULL,
 DNMFDDS_ID NUMBER NOT NULL,	
 DNMFDES_ID NUMBER NOT NULL,
 DNMFDDST_ID NUMBER NOT NULL,
 DNMFDFT_ID NUMBER NOT NULL,
 DNMFDTS_ID NUMBER NOT NULL,
 DNMFDIS_ID NUMBER NOT NULL,
 INSTANCE_STATUS_DT DATE NOT NULL,
 DOCUMENT_STATUS_DT DATE NOT NULL,
 RECEIPT_DT DATE NOT NULL,
 SCAN_DT DATE NOT NULL,
 RELEASE_DT DATE NOT NULL,
 JEOPARDY_FLAG VARCHAR2(2)NOT NULL,
 CREATION_COUNT	NUMBER NOT NULL,
 INVENTORY_COUNT NUMBER	NOT NULL,
 COMPLETION_COUNT NUMBER NOT NULL
)partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (to_date('20130101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;

comment on column F_NYHIX_MFD_BY_DATE_temp.FNMFDBD_ID is 'Sequence ';
comment on column F_NYHIX_MFD_BY_DATE_temp.NYHIX_MFD_BI_ID is 'BI ID ';
comment on column F_NYHIX_MFD_BY_DATE_temp.INSTANCE_STATUS_DT is 'The date that the instance status 
is set';
comment on column F_NYHIX_MFD_BY_DATE_temp.DOCUMENT_STATUS_DT is 'This is the status date for the 
current document status.';

comment on column F_NYHIX_MFD_BY_DATE_temp.RECEIPT_DT is 'The date the document was received in the 
mailroom or by nyhbe system';
comment on column F_NYHIX_MFD_BY_DATE_temp.SCAN_DT is 'The date the document was scanned into 
kofax';
comment on column F_NYHIX_MFD_BY_DATE_temp.RELEASE_DT is 'The date the document was released from 
kofax';
comment on column F_NYHIX_MFD_BY_DATE_temp.JEOPARDY_FLAG is 'The Jeopardy Flag indicates if an in-
process document is at risk of becoming untimely.';

ALTER TABLE F_NYHIX_MFD_BY_DATE_temp ADD CONSTRAINT FNMFDBD_PK1 PRIMARY KEY (FNMFDBD_ID);
ALTER INDEX FNMFDBD_PK1 REBUILD  ONLINE TABLESPACE MAXDAT_INDX PARALLEL;


ALTER TABLE F_NYHIX_MFD_BY_DATE_temp ADD CONSTRAINT FNMFDBD_DNMFDDT_FK1
FOREIGN KEY (DNMFDDT_ID) REFERENCES D_NYHIX_MFD_DOC_TYPE (DNMFDDT_ID);

ALTER TABLE F_NYHIX_MFD_BY_DATE_temp ADD CONSTRAINT FNMFDBD_DNMFDDS_FK1
FOREIGN KEY (DNMFDDS_ID) REFERENCES D_NYHIX_MFD_DOC_STATUS (DNMFDDS_ID);

ALTER TABLE F_NYHIX_MFD_BY_DATE_temp ADD CONSTRAINT FNMFDBD_DNMFDES_FK1
FOREIGN KEY (DNMFDES_ID) REFERENCES D_NYHIX_MFD_ENV_STATUS (DNMFDES_ID);

ALTER TABLE F_NYHIX_MFD_BY_DATE_temp ADD CONSTRAINT FNMFDBD_DNMFDDST_FK1
FOREIGN KEY (DNMFDDST_ID) REFERENCES D_NYHIX_MFD_DOC_SUB_TYPE (DNMFDDST_ID);

ALTER TABLE F_NYHIX_MFD_BY_DATE_temp ADD CONSTRAINT FNMFDBD_DNMFDFT_FK1
FOREIGN KEY (DNMFDFT_ID) REFERENCES D_NYHIX_MFD_FORM_TYPE (DNMFDFT_ID);

ALTER TABLE F_NYHIX_MFD_BY_DATE_temp ADD CONSTRAINT FNMFDBD_DNMFDTS_FK1
FOREIGN KEY (DNMFDTS_ID) REFERENCES D_NYHIX_MFD_TIME_STATUS (DNMFDTS_ID);

ALTER TABLE F_NYHIX_MFD_BY_DATE_temp ADD CONSTRAINT FNMFDBD_NYHIX_MFD_BI_ID_FK1
FOREIGN KEY (NYHIX_MFD_BI_ID) REFERENCES D_NYHIX_MFD_CURRENT(NYHIX_MFD_BI_ID);

ALTER TABLE F_NYHIX_MFD_BY_DATE_temp ADD CONSTRAINT FNMFDBD_DNMFDIS_FK1
FOREIGN KEY (DNMFDIS_ID) REFERENCES D_NYHIX_MFD_INS_STATUS(DNMFDIS_ID);

insert into F_NYHIX_MFD_BY_DATE_temp  
(
 FNMFDBD_ID,
 D_DATE,
 BUCKET_START_DATE,
 BUCKET_END_DATE,
 NYHIX_MFD_BI_ID,
 DNMFDDT_ID,
 DNMFDDS_ID,	
 DNMFDES_ID,
 DNMFDDST_ID,
 DNMFDFT_ID,
 DNMFDTS_ID,
 DNMFDIS_ID,
 INSTANCE_STATUS_DT,
 DOCUMENT_STATUS_DT,
 RECEIPT_DT,
 SCAN_DT,
 RELEASE_DT,
 JEOPARDY_FLAG,
 CREATION_COUNT,
 INVENTORY_COUNT,
 COMPLETION_COUNT
 )
select  
 FNMFDBD_ID,
 D_DATE,
 BUCKET_START_DT,
 BUCKET_END_DT,
 NYHIX_MFD_BI_ID,
 DNMFDDT_ID,
 DNMFDDS_ID,	
 DNMFDES_ID,
 DNMFDDST_ID,
 DNMFDFT_ID,
 DNMFDTS_ID,
 DNMFDIS_ID,
 INSTANCE_STATUS_DT,
 DOCUMENT_STATUS_DT,
 RECEIPT_DT,
 SCAN_DT,
 RELEASE_DT,
 JEOPARDY_FLAG,
 CREATION_COUNT,
 INVENTORY_COUNT,
 COMPLETION_COUNT
from F_NYHIX_MFD_BY_DATE;

alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_DNMFDDST_FK;
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_DNMFDDS_FK;
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_DNMFDDT_FK;
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_DNMFDES_FK;
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_DNMFDFT_FK;
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_DNMFDIS_FK;
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_DNMFDTS_FK;
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_NYHIX_MFD_BI_ID_FK;

--Drop primary key
alter table F_NYHIX_MFD_BY_DATE drop primary key;

--Drop table & view
drop table F_NYHIX_MFD_BY_DATE;

alter table F_NYHIX_MFD_BY_DATE_temp rename to F_NYHIX_MFD_BY_DATE;
alter table F_NYHIX_MFD_BY_DATE rename constraint FNMFDBD_PK1 to FNMFDBD_PK;
alter table F_NYHIX_MFD_BY_DATE rename constraint FNMFDBD_DNMFDDT_FK1 to FNMFDBD_DNMFDDT_FK;
alter table F_NYHIX_MFD_BY_DATE rename constraint FNMFDBD_DNMFDDS_FK1 to FNMFDBD_DNMFDDS_FK;
alter table F_NYHIX_MFD_BY_DATE rename constraint FNMFDBD_DNMFDES_FK1 to FNMFDBD_DNMFDES_FK;
alter table F_NYHIX_MFD_BY_DATE rename constraint FNMFDBD_DNMFDDST_FK1 to FNMFDBD_DNMFDDST_FK;
alter table F_NYHIX_MFD_BY_DATE rename constraint FNMFDBD_DNMFDFT_FK1 to FNMFDBD_DNMFDFT_FK;
alter table F_NYHIX_MFD_BY_DATE rename constraint FNMFDBD_DNMFDTS_FK1 to FNMFDBD_DNMFDTS_FK;
alter table F_NYHIX_MFD_BY_DATE rename constraint FNMFDBD_NYHIX_MFD_BI_ID_FK1 to 
FNMFDBD_NYHIX_MFD_BI_ID_FK;
alter table F_NYHIX_MFD_BY_DATE rename constraint FNMFDBD_DNMFDIS_FK1 to FNMFDBD_DNMFDIS_FK;

create or replace view F_NYHIX_MFD_BY_DATE_SV as
select
  FNMFDBD_ID,
  bdd.D_DATE D_DATE,
  NYHIX_MFD_BI_ID,
  DNMFDDT_ID,
  DNMFDDS_ID,
  DNMFDES_ID,
  DNMFDDST_ID,
  DNMFDFT_ID,
  DNMFDTS_ID,
  DNMFDIS_ID,
  INSTANCE_STATUS_DT,
  DOCUMENT_STATUS_DT,
  RECEIPT_DT,
  SCAN_DT,
  RELEASE_DT,
  JEOPARDY_FLAG,
  case
    when dense_rank() over (partition by NYHIX_MFD_BI_ID order by NYHIX_MFD_BI_ID asc, bdd.D_DATE 
asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_NYHIX_MFD_BY_DATE fnmfdbd
where 
  bdd.D_DATE >= fnmfdbd.BUCKET_START_DATE 
  and bdd.D_DATE < fnmfdbd.BUCKET_END_DATE
union all
select
  FNMFDBD_ID,
  bdd.D_DATE D_DATE,
  NYHIX_MFD_BI_ID,
  DNMFDDT_ID,
  DNMFDDS_ID,
  DNMFDES_ID,
  DNMFDDST_ID,
  DNMFDFT_ID,
  DNMFDTS_ID,
  DNMFDIS_ID,
  INSTANCE_STATUS_DT,
  DOCUMENT_STATUS_DT,
  RECEIPT_DT,
  SCAN_DT,
  RELEASE_DT,
  JEOPARDY_FLAG,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_NYHIX_MFD_BY_DATE fnmfdbd
where 
  bdd.D_DATE = fnmfdbd.BUCKET_START_DATE
  and bdd.D_DATE = fnmfdbd.BUCKET_END_DATE
with read only;


create unique index FNMFDBD_UIX1 on F_NYHIX_MFD_BY_DATE (NYHIX_MFD_BI_ID,D_DATE) online tablespace 
MAXDAT_INDX parallel compute statistics; 
create unique index FNMFDBD_UIX2 on F_NYHIX_MFD_BY_DATE (NYHIX_MFD_BI_ID,BUCKET_START_DATE) online 
tablespace MAXDAT_INDX parallel compute statistics;
create unique index FNMFDBD_UIX3 on F_NYHIX_MFD_BY_DATE (NYHIX_MFD_BI_ID,BUCKET_END_DATE) online 
tablespace MAXDAT_INDX parallel compute statistics;

create index FNMFDBD_IX1 on F_NYHIX_MFD_BY_DATE ("INSTANCE_STATUS_DT") online tablespace MAXDAT_INDX 
parallel compute statistics;
create index FNMFDBD_IX2 on F_NYHIX_MFD_BY_DATE ("DOCUMENT_STATUS_DT") online tablespace MAXDAT_INDX 
parallel compute statistics;
create index FNMFDBD_IX3 on F_NYHIX_MFD_BY_DATE ("RECEIPT_DT") online tablespace MAXDAT_INDX 
parallel compute statistics;
create index FNMFDBD_IX4 on F_NYHIX_MFD_BY_DATE ("SCAN_DT") online tablespace MAXDAT_INDX parallel 
compute statistics;
create index FNMFDBD_IX5 on F_NYHIX_MFD_BY_DATE ("RELEASE_DT") online tablespace MAXDAT_INDX 
parallel compute statistics;
create index FNMFDBD_IXL1 on F_NYHIX_MFD_BY_DATE (BUCKET_END_DATE) local online tablespace 
MAXDAT_INDX 
parallel compute statistics;
create index FNMFDBD_IXL2 on F_NYHIX_MFD_BY_DATE (NYHIX_MFD_BI_ID) local online tablespace 
MAXDAT_INDX parallel compute statistics;
create index FNMFDBD_IXL3 on F_NYHIX_MFD_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online 
tablespace MAXDAT_INDX parallel compute statistics;

commit;