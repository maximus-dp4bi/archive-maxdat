-- Create project-specific views for MicroStrategy MASH reporting.

create or replace view D_FLHK_BPM_SOURCE_LKUP_SV as 
select * from D_BPM_SOURCE_LKUP_SV
with read only;

create or replace view D_FLHK_BPM_DATA_MODEL_SV as 
select * from D_BPM_DATA_MODEL_SV
with read only;

create or replace view D_FLHK_BUEQ_SV as 
select * from  D_BPM_UPDATE_EVENT_QUEUE_SV
with read only;
          
create or replace view D_FLHK_PBQJ_SV as
select * from D_PROCESS_BPM_QUEUE_JOB_SV
with read only;

create or replace view D_FLHK_PBQJB_SV as 
select * from D_PROCESS_BPM_QUEUE_JOB_BAT_SV
with read only;
