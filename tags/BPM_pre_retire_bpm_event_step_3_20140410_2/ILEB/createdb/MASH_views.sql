-- Create project-specific views for MicroStrategy MASH reporting.

create or replace view D_ILEB_BPM_SOURCE_LKUP_SV as 
select * from D_BPM_SOURCE_LKUP_SV
with read only;

create or replace public synonym D_ILEB_BPM_SOURCE_LKUP_SV for D_ILEB_BPM_SOURCE_LKUP_SV;
grant select on D_ILEB_BPM_SOURCE_LKUP_SV to MAXDAT_READ_ONLY;


create or replace view D_ILEB_BPM_DATA_MODEL_SV as 
select * from D_BPM_DATA_MODEL_SV
with read only;

create or replace public synonym D_ILEB_BPM_DATA_MODEL_SV for D_ILEB_BPM_DATA_MODEL_SV;
grant select on D_ILEB_BPM_DATA_MODEL_SV to MAXDAT_READ_ONLY;


create or replace view D_ILEB_BUEQ_SV as 
select * from  D_BPM_UPDATE_EVENT_QUEUE_SV
with read only;

create or replace public synonym D_ILEB_BUEQ_SV for D_ILEB_BUEQ_SV;
grant select on D_ILEB_BUEQ_SV to MAXDAT_READ_ONLY;

          
create or replace view D_ILEB_PBQJ_SV as
select * from D_PROCESS_BPM_QUEUE_JOB_SV
with read only;

create or replace public synonym D_ILEB_PBQJ_SV for D_ILEB_PBQJ_SV;
grant select on D_ILEB_PBQJ_SV to MAXDAT_READ_ONLY;


create or replace view D_ILEB_PBQJB_SV as 
select * from D_PROCESS_BPM_QUEUE_JOB_BAT_SV
with read only;

create or replace public synonym D_ILEB_PBQJB_SV for D_ILEB_PBQJB_SV;
grant select on D_ILEB_PBQJB_SV to MAXDAT_READ_ONLY;
