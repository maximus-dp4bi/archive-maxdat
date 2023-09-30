create or replace view D_NYEC_PA_CURRENT_TASK_SV as
select
  dnpacur."Current Task ID", 
  dmwcur."Age in Business Days", 
  dmwcur."Age in Calendar Days", 
  dmwcur."Create Date", 
  dmwcur."Complete Date", 
  dmwcur."Jeopardy Flag", 
  dmwcur."SLA Days", 
  dmwcur."SLA Days Type", 
  dmwcur."SLA Jeopardy Days", 
  dmwcur."SLA Target Days", 
  dmwcur."Timeliness Status", 
  dmwcur."Cancel Work Date", 
  dmwcur."Cancel Work Flag", 
  dmwcur."Complete Flag", 
  dmwcur."Created By Name", 
  dmwcur."Source Reference ID", 
  dmwcur."Source Reference Type", 
  dmwcur."Status Age in Business Days", 
  dmwcur."Status Age in Calendar Days", 
  dmwcur."Unit of Work", 
  dmwcur."Current Escalated Flag", 
  dmwcur."Current Escalated To Name", 
  dmwcur."Current Forwarded By Name", 
  dmwcur."Current Forwarded Flag", 
  dmwcur."Current Group Name", 
  dmwcur."Current Group Parent Name", 
  dmwcur."Current Group Supervisor Name", 
  dmwcur."Current Last Update By Name", 
  dmwcur."Current Owner Name", 
  dmwcur."Current Task Status", 
  dmwcur."Current Task Type", 
  dmwcur."Current Team Name", 
  dmwcur."Current Team Parent Name", 
  dmwcur."Current Team Supervisor Name", 
  dmwcur."Current Last Update Date", 
  dmwcur."Current Status Date"
from D_NYEC_PA_CURRENT dnpacur
inner join D_MW_CURRENT dmwcur on (dnpacur."Current Task ID" = dmwcur."Task ID")
with read only;

alter table D_NYEC_PA_CURRENT drop constraint DNPACUR_DNPACT_FK;
drop table D_NYEC_PA_CURRENT_TASK;


create or replace view D_NYEC_PA_DATA_ENTRY_TASK_SV as
select
  dnpacur."Data Entry Task ID", 
  dmwcur."Age in Business Days", 
  dmwcur."Age in Calendar Days", 
  dmwcur."Create Date", 
  dmwcur."Complete Date", 
  dmwcur."Jeopardy Flag", 
  dmwcur."SLA Days", 
  dmwcur."SLA Days Type", 
  dmwcur."SLA Jeopardy Days", 
  dmwcur."SLA Target Days", 
  dmwcur."Timeliness Status", 
  dmwcur."Cancel Work Date", 
  dmwcur."Cancel Work Flag", 
  dmwcur."Complete Flag", 
  dmwcur."Created By Name", 
  dmwcur."Source Reference ID", 
  dmwcur."Source Reference Type", 
  dmwcur."Status Age in Business Days", 
  dmwcur."Status Age in Calendar Days", 
  dmwcur."Unit of Work", 
  dmwcur."Current Escalated Flag", 
  dmwcur."Current Escalated To Name", 
  dmwcur."Current Forwarded By Name", 
  dmwcur."Current Forwarded Flag", 
  dmwcur."Current Group Name", 
  dmwcur."Current Group Parent Name", 
  dmwcur."Current Group Supervisor Name", 
  dmwcur."Current Last Update By Name", 
  dmwcur."Current Owner Name", 
  dmwcur."Current Task Status", 
  dmwcur."Current Task Type", 
  dmwcur."Current Team Name", 
  dmwcur."Current Team Parent Name", 
  dmwcur."Current Team Supervisor Name", 
  dmwcur."Current Last Update Date", 
  dmwcur."Current Status Date"
from D_NYEC_PA_CURRENT dnpacur
inner join D_MW_CURRENT dmwcur on (dnpacur."Data Entry Task ID" = dmwcur."Task ID")
with read only;

alter table D_NYEC_PA_CURRENT drop constraint DNPACUR_DNPADET_FK;
drop table D_NYEC_PA_DATA_ENTRY_TASK;


create or replace view D_NYEC_PA_QC_TASK_SV as
select
  dnpacur."QC Task ID", 
  dmwcur."Age in Business Days", 
  dmwcur."Age in Calendar Days", 
  dmwcur."Create Date", 
  dmwcur."Complete Date", 
  dmwcur."Jeopardy Flag", 
  dmwcur."SLA Days", 
  dmwcur."SLA Days Type", 
  dmwcur."SLA Jeopardy Days", 
  dmwcur."SLA Target Days", 
  dmwcur."Timeliness Status", 
  dmwcur."Cancel Work Date", 
  dmwcur."Cancel Work Flag", 
  dmwcur."Complete Flag", 
  dmwcur."Created By Name", 
  dmwcur."Source Reference ID", 
  dmwcur."Source Reference Type", 
  dmwcur."Status Age in Business Days", 
  dmwcur."Status Age in Calendar Days", 
  dmwcur."Unit of Work", 
  dmwcur."Current Escalated Flag", 
  dmwcur."Current Escalated To Name", 
  dmwcur."Current Forwarded By Name", 
  dmwcur."Current Forwarded Flag", 
  dmwcur."Current Group Name", 
  dmwcur."Current Group Parent Name", 
  dmwcur."Current Group Supervisor Name", 
  dmwcur."Current Last Update By Name", 
  dmwcur."Current Owner Name", 
  dmwcur."Current Task Status", 
  dmwcur."Current Task Type", 
  dmwcur."Current Team Name", 
  dmwcur."Current Team Parent Name", 
  dmwcur."Current Team Supervisor Name", 
  dmwcur."Current Last Update Date", 
  dmwcur."Current Status Date"
from D_NYEC_PA_CURRENT dnpacur
inner join D_MW_CURRENT dmwcur on (dnpacur."QC Task ID" = dmwcur."Task ID")
with read only;

alter table D_NYEC_PA_CURRENT drop constraint DNPACUR_DNPAQT_FK;
drop table D_NYEC_PA_QC_TASK;


drop table REL_TASK_APP;

create or replace view REL_TASK_APP_SV
as
select 
  dmwcur.MW_BI_ID as mw_bi_id,
  dnpacur.NYEC_PA_BI_ID as nyec_pa_bi_id
from 
  D_MW_CURRENT dmwcur, 
  D_NYEC_PA_CURRENT dnpacur
where 
  dmwcur."Source Reference Type" = dnpacur."Application ID"
  and dmwcur."Source Reference Type" = 'Application ID'
with read only;