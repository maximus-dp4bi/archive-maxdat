----- NYHIX-31758 
----- Patch to set the new colums 
-----
alter session set current_schema = MAXDAT;

update d_nyhix_MFD_current_v2 
set RECVD_TO_SCAN_AGE_IN_BUS_DAYS = bus_days_between(trunc(RECEIVED_DT), trunc(scan_dt)),
    RECVD_TO_SCAN_AGE_IN_CAL_DAYS = trunc(SCAN_DT) - trunc(RECEIVED_DT)
where RECEIVED_DT IS NOT NULL
AND SCAN_DT IS NOT NULL
AND (RECVD_TO_SCAN_AGE_IN_BUS_DAYS IS NULL
 OR RECVD_TO_SCAN_AGE_IN_CAL_DAYS IS NULL);
commit;    
