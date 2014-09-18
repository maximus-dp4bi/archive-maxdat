
Alter table NYHX_ETL_COMPLAINTS_INCIDENTS drop column enrollment_status ;


Alter table NYHX_ETL_COMPLAINTS_INCIDENTS add  (MAX_INCI_STAT_HIST_ID       NUMBER(18,0),
                                                STAFF_TYPE_CD             VARCHAR2(20),
                                                FOLLOWUP_FLAG             VARCHAR2(1),
                                                STAGE_DONE_DT             DATE,
                                                COMPLETE_DT               DATE,
                                                FORWARD_DT                DATE);


Alter table NYHX_ETL_COMPL_INCIDENTS_OLTP drop column enrollment_status ;
Alter table NYHX_ETL_COMPL_INCIDENTS_OLTP add  (MAX_INCI_STAT_HIST_ID       NUMBER(18,0),
                                                STAFF_TYPE_CD             VARCHAR2(20),
                                                FOLLOWUP_FLAG             VARCHAR2(1),
                                                STAGE_DONE_DT             DATE,
                                                COMPLETE_DT               DATE,
                                                FORWARD_DT                DATE);


Alter table NYHX_ETL_COMPL_INCIDN_WIP_BPM drop column enrollment_status ;
Alter table NYHX_ETL_COMPL_INCIDN_WIP_BPM add  (MAX_INCI_STAT_HIST_ID       NUMBER(18,0),
                                                STAFF_TYPE_CD             VARCHAR2(20),
                                                FOLLOWUP_FLAG             VARCHAR2(1),
                                                STAGE_DONE_DT             DATE,
                                                COMPLETE_DT               DATE,
                                                FORWARD_DT                DATE);

Alter table D_COMPLAINT_CURRENT drop column cur_enrollment_status;
Alter table D_COMPLAINT_CURRENT add (FOLLOWUP_FLAG     VARCHAR2(1)
                                     ,COMPLETE_DT               DATE,
                                     FORWARD_DT                DATE);

alter table F_COMPLAINT_BY_DATE drop constraint FCMPLBD_DCMPLB_FK;
alter table F_COMPLAINT_BY_DATE drop column DCMPLES_ID;
alter table F_COMPLAINT_BY_DATE ADD COMPLETE_DT DATE;

truncate table D_COMPLAINT_ENROLLMENT_STATUS;
drop table D_COMPLAINT_ENROLLMENT_STATUS;
drop view D_COMPLAINT_ENROLL_STATUS_SV;

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
  COMPLETE_DT
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
  COMPLETE_DT
from 
  BPM_D_DATES bdd,
  F_COMPLAINT_BY_DATE fcmplbd
where
  bdd.D_DATE = fcmplbd.BUCKET_START_DATE 
  and bdd.D_DATE = fcmplbd.BUCKET_END_DATE
with read only;

