/*
Created on 08/03/2016 by Raj A.
Description: MAXDAT-3721. Created for NYEC.
*/
alter session set current_schema = MAXDAT;

alter table HOLIDAYS drop constraint HOY_UK;
drop INDEX HOY_UK;

alter table HOLIDAYS add constraint HOY_UK unique (HOLIDAY_DATE) 
using index tablespace MAXDAT_INDX;

alter index HOY_UK invisible;