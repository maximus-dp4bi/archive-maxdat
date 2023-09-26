-- Use current dimension instead of staging table for view.
create or replace view INCIDENT_DESC_SV as
select 
  "Incident ID" INCIDENT_ID,
  "INCIDENT_DESCRIPTION" INCIDENT_DESCRIPTION
from D_PI_CURRENT;

-- Use current dimension instead of staging table for view.
create or replace view RESOLUTION_DESC_SV as
select 
  "Incident ID" INCIDENT_ID,
  "RESOLUTION_DESCRIPTION" RESOLUTION_DESCRIPTION
from D_PI_CURRENT;
