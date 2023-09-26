/*
Created on 12/20/2016 by Raj A.
Description: MAXDAT-1314
*/
alter table PROCESS_APP_STG move tablespace MAXDAT_DATA;

--Rebuilding indices as the table is moved to the MAXDAT_DATA tablespace.
alter index SYS_C00134166 rebuild online;
alter index AP_PROCESS_FLG_INDX1 rebuild online;

--All indices are in the MAXDAT_INDX tablespace. Hence, no indices need a change.