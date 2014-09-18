-- Create project-specific views for MicroStrategy MASH reporting.

drop view D_NYHIX_BPM_SOURCE_LKUP_SV;

create or replace view D_NYHX_BPM_SOURCE_LKUP_SV as 
select * from D_BPM_SOURCE_LKUP_SV
with read only;

drop view D_NYHIX_BPM_DATA_MODEL_SV;

create or replace view D_NYHX_BPM_DATA_MODEL_SV as 
select * from D_BPM_DATA_MODEL_SV
with read only;

drop view D_NYHIX_BUEQ_SV;

create or replace view D_NYHX_BUEQ_SV as 
select * from  D_BPM_UPDATE_EVENT_QUEUE_SV
with read only;

drop view D_NYHIX_PBQJ_SV;
          
create or replace view D_NYHX_PBQJ_SV as
select * from D_PROCESS_BPM_QUEUE_JOB_SV
with read only;

drop view D_NYHIX_PBQJB_SV;

create or replace view D_NYHX_PBQJB_SV as 
select * from D_PROCESS_BPM_QUEUE_JOB_BAT_SV
with read only;

