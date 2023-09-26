/*
Created on 10/20/2014 by Raj A.
Description: Task_type_id should not exist in the history table. So, fixing this as part of the deployment,NYHIX-11405, NYHXMXDU only.
*/
alter table D_MW_V2_HISTORY drop column task_type_id;

create or replace view D_MW_V2_HISTORY_SV
as
SELECT
  h.DMWBD_ID,
  bdd.D_DATE,
  h.MW_BI_ID,
  h.TASK_STATUS,
  h.GROUP_ID,
  h.TEAM_ID,
  h.LAST_UPDATE_DATE,
  h.STATUS_DATE,
  h.WORK_RECEIPT_DATE
FROM D_MW_V2_HISTORY h JOIN BPM_D_DATES bdd on (bdd.D_DATE >= h.BUCKET_START_DATE AND bdd.D_DATE <= h.BUCKET_END_DATE);

create or replace public synonym D_MW_V2_HISTORY_SV for D_MW_V2_HISTORY_SV;
grant select on D_MW_V2_HISTORY_SV to MAXDAT_READ_ONLY;

execute maxdat_admin.RESET_BPM_QUEUE_ROWS_BY_BSL_ID(2001);
