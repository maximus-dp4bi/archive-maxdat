-- NYHIX-2739 Additional index for MW's Dup Incident Tasks.

create index DCMPLCUR_IDX1 on D_COMPLAINT_CURRENT (INCIDENT_TRACKING_NUMBER) tablespace MAXDAT_INDX;