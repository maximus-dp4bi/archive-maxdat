/*
Created on 03/24/2017 by Raj A.
Description: Created for TNERPS-2158.
Approval received from TNRD Project on TNERPS-2196
*/
CREATE INDEX "ATS"."XIE2ETL_L_MAILHOUSE" ON "ATS"."ETL_L_MAILHOUSE" ("LMREQ_ID", "JOB_ID") TABLESPACE "ATS_DATA";