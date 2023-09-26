/*
Created on 07/30/2015 by Raj A.
Description: Per NYHIX-16619, Creating indexes to increase performance of poorly performing sqls.
*/
create index FCMPLBD_IXL5 on F_COMPLAINT_BY_DATE (INVENTORY_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FCMPLBD_IXL6 on F_COMPLAINT_BY_DATE (COMPLETION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;