-- Create project-specific views for MicroStrategy MASH reporting.

create or replace view D_CAHCO_BPM_SOURCE_LKUP_SV as
select * from D_BPM_SOURCE_LKUP_SV
with read only;

grant select on D_CAHCO_BPM_SOURCE_LKUP_SV to MAXDAT_READ_ONLY;

create or replace view D_CAHCO_BPM_DATA_MODEL_SV as
select * from D_BPM_DATA_MODEL_SV
with read only;

grant select on D_CAHCO_BPM_DATA_MODEL_SV to MAXDAT_READ_ONLY;

create or replace view D_CAHCO_BUEQ_SV as
select * from D_BPM_UPDATE_EVENT_QUEUE_SV
with read only;

grant select on D_CAHCO_BUEQ_SV to MAXDAT_READ_ONLY;

create or replace view D_CAHCO_PBQJ_SV as
select * from D_PROCESS_BPM_QUEUE_JOB_SV
with read only;

grant select on D_CAHCO_PBQJ_SV to MAXDAT_READ_ONLY;

create or replace view D_CAHCO_PBQJB_SV as
select * from D_PROCESS_BPM_QUEUE_JOB_BAT_SV
with read only;

grant select on D_CAHCO_PBQJB_SV to MAXDAT_READ_ONLY;