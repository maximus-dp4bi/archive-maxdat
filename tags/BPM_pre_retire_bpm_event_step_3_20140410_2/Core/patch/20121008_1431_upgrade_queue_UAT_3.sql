alter index BPM_D_HOURS_PK rebuild tablespace MAXDAT_INDX parallel;

alter table D_NYEC_PA_COUNTY rename constraint DPAC_PK to DPACOU_PK;
drop index DPAC_UIX1;
create unique index DPACOU_UIX1 on D_NYEC_PA_COUNTY  ("County") tablespace MAXDAT_INDX parallel compute statistics;    

alter table D_NYEC_PA_CURRENT add constraint DPACUR_PK primary key (NYEC_PA_BI_ID);
alter index DPACUR_PK rebuild tablespace MAXDAT_INDX parallel;

alter table F_NYEC_PA_BY_DATE 
    add constraint FNPABD_DPACUR_FK foreign key 
   (
     NYEC_PA_BI_ID
   ) 
    references D_NYEC_PA_CURRENT 
   (
     NYEC_PA_BI_ID
   ) 
;

alter table REL_TASK_APP 
    add constraint RTA_DPACUR_FK foreign key 
   (
     NYEC_PA_BI_ID
   ) 
    references D_NYEC_PA_CURRENT 
   (
     NYEC_PA_BI_ID
   ) 
;
