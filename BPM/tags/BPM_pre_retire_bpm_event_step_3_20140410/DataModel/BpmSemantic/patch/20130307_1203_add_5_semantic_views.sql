
--Process App State Rev Task View
CREATE OR REPLACE FORCE VIEW D_NYEC_PA_STATE_REV_TASK_SV
AS
  SELECT dnpacur."State Review Task ID",
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
  FROM D_NYEC_PA_CURRENT dnpacur
  INNER JOIN D_MW_CURRENT dmwcur
  ON (dnpacur."State Review Task ID" = dmwcur."Task ID")
WITH read only;

--State Review State Rev Task View
CREATE OR REPLACE FORCE VIEW D_NYEC_SR_STATE_REV_TASK_SV
AS
  SELECT dnsrcur."State Review Task ID",
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
  FROM D_NYEC_SR_CURRENT dnsrcur
  INNER JOIN D_MW_CURRENT dmwcur
  ON (dnsrcur."State Review Task ID" = dmwcur."Task ID")
WITH read only;

--State Review Data Correction Task View
CREATE OR REPLACE FORCE VIEW D_NYEC_SR_DATA_CORRECT_TASK_SV
AS
  SELECT dnsrcur."Data Correction Task ID",
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
  FROM D_NYEC_SR_CURRENT dnsrcur
  INNER JOIN D_MW_CURRENT dmwcur
  ON (dnsrcur."Data Correction Task ID" = dmwcur."Task ID")
WITH read only;

--State Review Research Task View
CREATE OR REPLACE FORCE VIEW D_NYEC_SR_RESEARCH_TASK_SV
AS
  SELECT dnsrcur."Research Task ID",
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
  FROM D_NYEC_SR_CURRENT dnsrcur
  INNER JOIN D_MW_CURRENT dmwcur
  ON (dnsrcur."Research Task ID" = dmwcur."Task ID")
WITH read only;

--State Review Current Task View
CREATE OR REPLACE FORCE VIEW D_NYEC_SR_CURRENT_TASK_SV
AS
  SELECT dnsrcur."Current Task ID",
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
  FROM D_NYEC_SR_CURRENT dnsrcur
  INNER JOIN D_MW_CURRENT dmwcur
  ON (dnsrcur."Current Task ID" = dmwcur."Task ID")
WITH read only;










