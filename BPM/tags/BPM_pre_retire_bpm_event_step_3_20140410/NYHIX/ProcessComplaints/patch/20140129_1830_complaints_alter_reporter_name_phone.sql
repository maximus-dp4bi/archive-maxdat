
Alter table NYHX_ETL_COMPLAINTS_INCIDENTS add  (REPORTER_NAME             VARCHAR2(180),
                                                REPORTER_PHONE            VARCHAR2(32),
                                                SLA_SATISFIED             VARCHAR2(1));

Alter table NYHX_ETL_COMPL_INCIDENTS_OLTP add  (REPORTER_NAME             VARCHAR2(180),
                                                REPORTER_PHONE            VARCHAR2(32),
                                                SLA_SATISFIED             VARCHAR2(1));

Alter table NYHX_ETL_COMPL_INCIDN_WIP_BPM add  (REPORTER_NAME             VARCHAR2(180),
                                                REPORTER_PHONE            VARCHAR2(32),
                                                SLA_SATISFIED             VARCHAR2(1));


Alter table D_COMPLAINT_CURRENT add (REPORTER_NAME             VARCHAR2(180),
                                     REPORTER_PHONE            VARCHAR2(32),
                                     SLA_SATISFIED             VARCHAR2(1));

create sequence SEQ_DCMPLSS_ID
minvalue 0
maxvalue 999999999999999999999999999
start with 0
increment by 1
cache 20;

create table D_COMPLAINT_SLA_SATISFIED
  (DCMPLSS_ID number not null, 
   SLA_SATISFIED varchar2(10))
tablespace MAXDAT_DATA;

alter table D_COMPLAINT_SLA_SATISFIED add constraint DCMPLSS_PK primary key (DCMPLSS_ID) using index tablespace MAXDAT_INDX;

create unique index DCMPLSS_UIX1 on D_COMPLAINT_SLA_SATISFIED (SLA_SATISFIED) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_COMPLAINT_SLA_SATISFIED for D_COMPLAINT_SLA_SATISFIED;
grant select on D_COMPLAINT_SLA_SATISFIED to MAXDAT_READ_ONLY;

create or replace view D_COMPLAINT_SLA_SATISFIED_SV as
select * from D_COMPLAINT_SLA_SATISFIED
with read only;

create or replace public synonym D_COMPLAINT_SLA_SATISFIED_SV for D_COMPLAINT_SLA_SATISFIED_SV;
grant select on D_COMPLAINT_SLA_SATISFIED_SV to MAXDAT_READ_ONLY;

insert into  D_COMPLAINT_SLA_SATISFIED (DCMPLSS_ID,SLA_SATISFIED ) values (SEQ_DCMPLSS_ID.nextval,'N');
insert into  D_COMPLAINT_SLA_SATISFIED (DCMPLSS_ID,SLA_SATISFIED ) values (SEQ_DCMPLSS_ID.nextval,'Y');
commit;
alter table F_COMPLAINT_BY_DATE ADD DCMPLSS_ID number ;


create or replace view D_COMPLAINT_CURRENT_SV as
select * from D_COMPLAINT_CURRENT
with read only;

create or replace view F_COMPLAINT_BY_DATE_SV as
select
  FCMPLBD_ID,
  bdd.D_DATE,
  CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  INCIDENT_STATUS_DATE,
  LAST_UPDATE_DATE,
  case 
    when dense_rank() over (partition BY CMPL_BI_ID order BY CMPL_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    END CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  COMPLETE_DT,
  DCMPLSS_ID
from 
  BPM_D_DATES bdd,
  F_COMPLAINT_BY_DATE fcmplbd
where
  bdd.D_DATE >= fcmplbd.BUCKET_START_DATE 
  and bdd.D_DATE < fcmplbd.BUCKET_END_DATE
union all
select
 FCMPLBD_ID,
  bdd.D_DATE,
  CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  INCIDENT_STATUS_DATE,
  LAST_UPDATE_DATE,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  COMPLETE_DT,
  DCMPLSS_ID
from 
  BPM_D_DATES bdd,
  F_COMPLAINT_BY_DATE fcmplbd
where
  bdd.D_DATE = fcmplbd.BUCKET_START_DATE 
  and bdd.D_DATE = fcmplbd.BUCKET_END_DATE
with read only;

Insert into bpm_attribute_lkup (BAL_ID,BDL_ID,NAME,PURPOSE) values (505,2,'Reporter Name','The name of the individual who submitted the incident.');

Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2601,505,22,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');

Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,2601,22,'REPORTER_NAME');

exec BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1606,2,'Reporter Phone','The Phone number of the individual who submitted the incident.');
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2602,1606,22,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');

Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,2602,22,'REPORTER_PHONE');

update bpm_attribute_lkup set bdl_id = 2 where name = 'Followup Flag';
update bpm_attribute_lkup set bdl_id = 3 where name = 'Forward DT';

exec BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1607,2,'SLA Satisfied','The Phone number of the individual who submitted the incident.');
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2603,1607,22,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');

Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,2603,22,'SLA_SATISFIED');

commit;
