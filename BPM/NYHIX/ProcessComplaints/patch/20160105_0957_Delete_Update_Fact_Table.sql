/*
Created on 01/05/2016 by Raj A.
Decsription:
Fix a Complaints record in the queue processor that errored due to incorrect source data.
Last_Update_date in the source system had a retro date timestamp causing the facts table's D_Date and FCMPLBD_ID 
to go out of sync chronologically.
Incident_ID = 26466083
*/
UPDATE F_COMPLAINT_BY_DATE
   SET  bucket_end_date = to_date('7/7/2077','mm/dd/yyyy')       
  WHERE FCMPLBD_ID = 2405130;

DELETE  F_COMPLAINT_BY_DATE
  WHERE FCMPLBD_ID = 2412201;
  COMMIT; 