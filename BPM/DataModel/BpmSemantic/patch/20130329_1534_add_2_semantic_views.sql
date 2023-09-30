CREATE OR REPLACE FORCE VIEW "D_NYEC_SR_CURRENT_APP_SV" 
AS
  SELECT dnsrcur."Application ID",
    dnpacur."Age in Business Days",
    dnpacur."Age in Calendar Days",
    dnpacur."App Age in Calendar Days",
    dnpacur."App Complete Result",
    dnpacur."Application Type",
    dnpacur."Auto Reprocess Flag",
    dnpacur."Cancel App Flag",
    dnpacur."Cancel App Performed By",
    dnpacur."Cancel Date",
    dnpacur."Channel" "Channel Name",
    dnpacur."Close App Flag",
    dnpacur."Close App Performed By",
    dnpacur."Complete App Flag",
    dnpacur."Complete App Performed By",
    dnpacur."Complete Date",
    dnpacur."Create Date",
    dnpacur."Current Task ID",
    dnpacur."Data Entry Task ID",
    dnpacur."Eligibility Action",
    dnpacur."Jeopardy Flag",
    dnpacur."KPR App Cycle Business Days",
    dnpacur."KPR App Cycle Calendar Days",
    dnpacur."KPR App Cycle End Date",
    dnpacur."KPR App Cycle Start Date",
    dnpacur."Last Mail Date",
    dnpacur."MI Received Task Count",
    dnpacur."Missing Information Flag",
    dnpacur."New MI Flag",
    dnpacur."Notify Clnt Pend App Date",
    dnpacur."Notify Clnt Pend App Flag",
    dnpacur."Notify Clnt Pend App Prfrmd By",
    dnpacur."Notify Clnt Pend App Strt Date",
    dnpacur."Outcome Notification Rqrd Flag",
    dnpacur."Pend Notification Rqrd Flag",
    dnpacur."Perform QC Date",
    dnpacur."Perform QC Performed By",
    dnpacur."Perform QC Flag",
    dnpacur."Perform QC Start Date",
    dnpacur."Perform Research Date",
    dnpacur."Perform Research Performed By",
    dnpacur."Perform Research Flag",
    dnpacur."Perform Research Start Date",
    dnpacur."Process App Info Date",
    dnpacur."Process App Info Flag",
    dnpacur."Process App Info Performed By",
    dnpacur."Process App Info Start Date",
    dnpacur."QC Outcome Flag",
    dnpacur."QC Required Flag",
    dnpacur."QC Task ID",
    dnpacur."Receive and Process MI Flag",
    dnpacur."Receive App Flag",
    dnpacur."Research Flag",
    dnpacur."Research Reason",
    dnpacur."Research Task ID",
    dnpacur."Review Enter Data Date",
    dnpacur."Review Enter Data Performed By",
    dnpacur."Review Enter Data Flag",
    dnpacur."Review Enter Data Start Date",
    dnpacur."SLA Days",
    dnpacur."SLA Days Type",
    dnpacur."SLA Jeopardy Date",
    dnpacur."SLA Jeopardy Days",
    dnpacur."SLA Target Days",
    dnpacur."State Review Task Count",
    dnpacur."State Review Task ID",
    dnpacur."Timeliness Status",
    dnpacur."Wait State Approval Date",
    dnpacur."Wait State Approval Flag",
    dnpacur."Wait State Approval Prfrmd By",
    dnpacur."Wait State Approval Start Date",
    dnpacur."Cur App Status",
    dnpacur."Cur App Status Group",
    dnpacur."Cur County",
    dnpacur."Cur HEART App Status",
    dnpacur."Cur HEART Synch Flag",
    dnpacur."Cur Receipt Date",
    dnpacur."Cur Refer to LDSS Flag",
    dnpacur."Cur CIN",
    dnpacur."CIN Date",
    dnpacur."Provider Name",
    dnpacur."Cur FPBP Sub-type",
    dnpacur."Reverse Clearance Indictr",
    dnpacur."Reverse Clearance Indictr Date",
    dnpacur."Reverse Clearance Outcome",
    dnpacur."Upstate/Downstate Indictr",
    dnpacur."Invoiceable Date",
    dnpacur."Cur HEART Incomplete App Ind",
    dnpacur."Days To Timeout",
    dnpacur."Cur HEART Case Status",
    dnpacur."State Case Identifier"
  FROM D_NYEC_SR_CURRENT dnsrcur
  INNER JOIN D_NYEC_PA_CURRENT dnpacur
  ON (dnsrcur."Application ID" = dnpacur."Application ID")
WITH read only;

CREATE OR REPLACE FORCE VIEW "D_NYEC_PMI_CURRENT_APP_SV" 
AS
SELECT dnpmicur."Cur Application ID",
    dnpacur."Age in Business Days",
    dnpacur."Age in Calendar Days",
    dnpacur."App Age in Calendar Days",
    dnpacur."App Complete Result",
    dnpacur."Application Type",
    dnpacur."Auto Reprocess Flag",
    dnpacur."Cancel App Flag",
    dnpacur."Cancel App Performed By",
    dnpacur."Cancel Date",
    dnpacur."Channel" "Channel Name",
    dnpacur."Close App Flag",
    dnpacur."Close App Performed By",
    dnpacur."Complete App Flag",
    dnpacur."Complete App Performed By",
    dnpacur."Complete Date",
    dnpacur."Create Date",
    dnpacur."Current Task ID",
    dnpacur."Data Entry Task ID",
    dnpacur."Eligibility Action",
    dnpacur."Jeopardy Flag",
    dnpacur."KPR App Cycle Business Days",
    dnpacur."KPR App Cycle Calendar Days",
    dnpacur."KPR App Cycle End Date",
    dnpacur."KPR App Cycle Start Date",
    dnpacur."Last Mail Date",
    dnpacur."MI Received Task Count",
    dnpacur."Missing Information Flag",
    dnpacur."New MI Flag",
    dnpacur."Notify Clnt Pend App Date",
    dnpacur."Notify Clnt Pend App Flag",
    dnpacur."Notify Clnt Pend App Prfrmd By",
    dnpacur."Notify Clnt Pend App Strt Date",
    dnpacur."Outcome Notification Rqrd Flag",
    dnpacur."Pend Notification Rqrd Flag",
    dnpacur."Perform QC Date",
    dnpacur."Perform QC Performed By",
    dnpacur."Perform QC Flag",
    dnpacur."Perform QC Start Date",
    dnpacur."Perform Research Date",
    dnpacur."Perform Research Performed By",
    dnpacur."Perform Research Flag",
    dnpacur."Perform Research Start Date",
    dnpacur."Process App Info Date",
    dnpacur."Process App Info Flag",
    dnpacur."Process App Info Performed By",
    dnpacur."Process App Info Start Date",
    dnpacur."QC Outcome Flag",
    dnpacur."QC Required Flag",
    dnpacur."QC Task ID",
    dnpacur."Receive and Process MI Flag",
    dnpacur."Receive App Flag",
    dnpacur."Research Flag",
    dnpacur."Research Reason",
    dnpacur."Research Task ID",
    dnpacur."Review Enter Data Date",
    dnpacur."Review Enter Data Performed By",
    dnpacur."Review Enter Data Flag",
    dnpacur."Review Enter Data Start Date",
    dnpacur."SLA Days",
    dnpacur."SLA Days Type",
    dnpacur."SLA Jeopardy Date",
    dnpacur."SLA Jeopardy Days",
    dnpacur."SLA Target Days",
    dnpacur."State Review Task Count",
    dnpacur."State Review Task ID",
    dnpacur."Timeliness Status",
    dnpacur."Wait State Approval Date",
    dnpacur."Wait State Approval Flag",
    dnpacur."Wait State Approval Prfrmd By",
    dnpacur."Wait State Approval Start Date",
    dnpacur."Cur App Status",
    dnpacur."Cur App Status Group",
    dnpacur."Cur County",
    dnpacur."Cur HEART App Status",
    dnpacur."Cur HEART Synch Flag",
    dnpacur."Cur Receipt Date",
    dnpacur."Cur Refer to LDSS Flag",
    dnpacur."Cur CIN",
    dnpacur."CIN Date",
    dnpacur."Provider Name",
    dnpacur."Cur FPBP Sub-type",
    dnpacur."Reverse Clearance Indictr",
    dnpacur."Reverse Clearance Indictr Date",
    dnpacur."Reverse Clearance Outcome",
    dnpacur."Upstate/Downstate Indictr",
    dnpacur."Invoiceable Date",
    dnpacur."Cur HEART Incomplete App Ind",
    dnpacur."Days To Timeout",
    dnpacur."Cur HEART Case Status",
    dnpacur."State Case Identifier"
  FROM D_NYEC_PMI_CURRENT dnpmicur
  INNER JOIN D_NYEC_PA_CURRENT dnpacur
  ON (dnpmicur."Cur Application ID" = dnpacur."Application ID")
WITH read only;